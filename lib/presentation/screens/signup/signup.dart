import 'package:chapt/app/app_prefs.dart';
import 'package:chapt/app/dependency_injection.dart';
import 'package:chapt/presentation/resources/app_strings.dart';
import 'package:chapt/presentation/resources/routes_manager.dart';
import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../view_models/signup/signup_view_model.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/text_field.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final SignupViewModel _viewModel = instance<SignupViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
    _passController
        .addListener(() => _viewModel.setPassword(_passController.text));
    _nameController.addListener(() => _viewModel.setName(_nameController.text));
    _phoneController
        .addListener(() => _viewModel.setPhoneNum(_phoneController.text));
    _viewModel.isUserRegisteredSuccefully.stream.listen((event) {
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
      body: _buildSignupBody(context),
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
            AppStrings.haveAcc,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes.signin);
            },
            child: const Text(AppStrings.signin),
          )
        ],
      ),
    );
  }

  Center _buildSignupBody(BuildContext context) {
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
                  AppStrings.signupText1,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: AppValues.v10),
                Text(
                  AppStrings.signupText2,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppValues.v30),
                StreamBuilder<String?>(
                  stream: _viewModel.outName,
                  builder: (context, snapshot) => AppInputField(
                    type: TextInputType.name,
                    hint: AppStrings.signupInputText1,
                    errorText: snapshot.data,
                    icon: Icons.person_outlined,
                    controller: _nameController,
                    validator: (name) => _viewModel.validateName(name),
                  ),
                ),
                const SizedBox(height: AppValues.v15),
                StreamBuilder<String?>(
                  stream: _viewModel.outEmail,
                  builder: (context, snapshot) => AppInputField(
                    type: TextInputType.emailAddress,
                    hint: AppStrings.logininputText1,
                    errorText: snapshot.data,
                    icon: Icons.email_outlined,
                    controller: _emailController,
                    validator: (email) => _viewModel.validateEmail(email),
                  ),
                ),
                const SizedBox(height: AppValues.v15),
                StreamBuilder<String?>(
                  stream: _viewModel.outPhoneNum,
                  builder: (context, snapshot) => AppInputField(
                    type: TextInputType.phone,
                    hint: AppStrings.signupInputText2,
                    errorText: snapshot.data,
                    icon: Icons.phone_outlined,
                    controller: _phoneController,
                    validator: (phone) => _viewModel.validatePhoneNum(phone),
                  ),
                ),
                const SizedBox(height: AppValues.v15),
                StreamBuilder<String?>(
                  stream: _viewModel.outPass,
                  builder: (context, snapshot) => AppInputField(
                    type: TextInputType.visiblePassword,
                    hint: AppStrings.logininputText2,
                    errorText: snapshot.data,
                    icon: Icons.lock_outline,
                    obscure: true,
                    controller: _passController,
                    validator: (pass) => _viewModel.validatePass(pass),
                  ),
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
                                await _viewModel.register(context);
                              }
                            }
                          : null,
                      content: snapshot.data!
                          ? const CircularProgressIndicator()
                          : const Text(AppStrings.signup),
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
