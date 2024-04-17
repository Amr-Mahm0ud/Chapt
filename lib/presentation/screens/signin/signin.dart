import 'package:chapt/app/app_prefs.dart';
import 'package:chapt/app/dependency_injection.dart';
import 'package:chapt/presentation/resources/app_strings.dart';
import 'package:chapt/presentation/resources/routes_manager.dart';
import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../view_models/signin/signin_view_model.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/text_field.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final SigninViewModel _viewModel = instance<SigninViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
    _passController.addListener(() => _viewModel.setPass(_passController.text));
    _viewModel.isUserLoggedInSuccefully.stream.listen((event) {
      //because we use navigator and context inside stream listener
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _appPreferences.setUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.home);
      });
    });
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
                StreamBuilder<String?>(
                  stream: _viewModel.outEmail,
                  builder: (context, snapshot) => AppInputField(
                    hint: AppStrings.logininputText1,
                    errorText: snapshot.data,
                    icon: Icons.email_outlined,
                    controller: _emailController,
                    validator: (email) => _viewModel.validateEmail(email),
                  ),
                ),
                const SizedBox(height: AppValues.v15),
                StreamBuilder<String?>(
                  stream: _viewModel.outPass,
                  builder: (context, snapshot) => AppInputField(
                    hint: AppStrings.logininputText2,
                    errorText: snapshot.data,
                    icon: Icons.lock_outline,
                    obscure: true,
                    controller: _passController,
                    validator: (pass) => _viewModel.validatePass(pass),
                  ),
                ),
                const SizedBox(height: AppValues.v20),
                TextButton(
                  onPressed: () {},
                  child: const Text(AppStrings.forgotPass),
                ),
                const SizedBox(height: AppValues.v50),
                StreamBuilder<bool>(
                  stream: _viewModel.outIsLoading,
                  initialData: false,
                  builder: (context, snapshot) {
                    return AppButton(
                      action: !snapshot.data!
                          ? () async {
                              bool valid = _formKey.currentState!.validate();
                              if (valid) {
                                await _viewModel.login(context);
                              }
                            }
                          : null,
                      content: snapshot.data!
                          ? const CircularProgressIndicator()
                          : const Text(AppStrings.signin),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
