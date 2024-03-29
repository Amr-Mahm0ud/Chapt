import 'package:chapt/presentation/resources/app_strings.dart';
import 'package:chapt/presentation/resources/routes_manager.dart';
import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../view_models/signin/signin_view_model.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final SigninViewModel _viewModel = SigninViewModel();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
    _passController.addListener(() => _viewModel.setPass(_passController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSigninBody(context),
      bottomSheet: _buildBottomSheet(context),
    );
  }

  Container _buildBottomSheet(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.haveNoAcc,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes.signup);
            },
            child: const Text(AppStrings.signup),
          )
        ],
      ),
    );
  }

  Center _buildSigninBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.v40),
            child: Column(
              children: [
                Text(
                  AppStrings.loginText1,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: AppValues.v10),
                Text(
                  AppStrings.loginText2,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppValues.v40),
                StreamBuilder<String>(
                  stream: _viewModel.outEmail,
                  builder: (context, snapshot) => AppInputField(
                    hint: AppStrings.logininputText1,
                    errorText: snapshot.data == '' ? null : snapshot.data,
                    icon: Icons.email_outlined,
                    controller: _emailController,
                  ),
                ),
                const SizedBox(height: AppValues.v15),
                StreamBuilder(
                  stream: _viewModel.outPass,
                  builder: (context, snapshot) {
                    return AppInputField(
                      hint: AppStrings.logininputText2,
                      errorText: snapshot.hasData
                          ? snapshot.data!.isEmpty
                              ? null
                              : snapshot.data!
                          : null,
                      icon: Icons.lock_outline,
                      obscure: true,
                      controller: _passController,
                    );
                  },
                ),
                const SizedBox(height: AppValues.v20),
                TextButton(
                  onPressed: () {},
                  child: const Text(AppStrings.forgotPass),
                ),
                const SizedBox(height: AppValues.v50),
                StreamBuilder(
                  stream: CombineLatestStream.combine2(
                      _viewModel.outEmail,
                      _viewModel.outPass,
                      (email, pass) => (email.isEmpty && pass.isEmpty)),
                  builder: (context, snapshot) => AppButton(
                    action: snapshot.hasData
                        ? snapshot.data!
                            ? () {}
                            : null
                        : null,
                    content: const Text(AppStrings.signin),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
