import 'dart:async';

import 'package:chapt/app/app_constants.dart';
import 'package:chapt/presentation/common/freezed_data_classes.dart';
import 'package:chapt/presentation/resources/app_strings.dart';
import 'package:chapt/presentation/view_models/base/base_view_model.dart';

import '../../../domain/use_case/login_use_case.dart';

class SigninViewModel extends BaseViewModel
    implements SigninViewModelInputs, SigninViewModelOutputs {
  final LoginUseCase _loginUseCase;

  // constructor
  SigninViewModel(this._loginUseCase);

  //variables
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _passStreamController =
      StreamController<String>.broadcast();
  LoginObject loginObject =
      LoginObject(AppConstants.emptyStr, AppConstants.emptyStr);

  // base view model functions
  @override
  void dispose() {
    _emailStreamController.close();
    _passStreamController.close();
  }

  @override
  void start() {}

//*********************************************************** */

//input view model
  @override
  Sink<String> get inputEmail => _emailStreamController.sink;

  @override
  Sink<String> get inputPass => _passStreamController.sink;

  //functions
  @override
  login() async {
    (await _loginUseCase.excute(
      LoginUseCaseInput(loginObject.email, loginObject.pass),
    ))
        .fold((failure) => {}, (data) => {});
  }

  @override
  void setEmail(String email) {
    inputEmail.add(email);
    loginObject = loginObject.copyWith(email: email);
  }

  @override
  void setPass(String pass) {
    inputPass.add(pass);
    loginObject = loginObject.copyWith(pass: pass);
  }

  // **************************************************************** */

  // outputs
  @override
  Stream<String> get outEmail =>
      _emailStreamController.stream.map((email) => _validateEmail(email));

  @override
  Stream<String> get outPass =>
      _passStreamController.stream.map((pass) => _validatePass(pass));

  //validation functions
  String _validateEmail(email) {
    if (email.isNotEmpty) {
      return AppConstants.emptyStr;
    } else {
      return AppStrings.emailReq;
    }
  }

  String _validatePass(String pass) {
    if (pass.isNotEmpty) {
      return AppConstants.emptyStr;
    } else {
      return AppStrings.passReq;
    }
  }
}

abstract class SigninViewModelInputs extends BaseViewModelInputs {
  void setEmail(String email);
  void setPass(String pass);
  login() {}

  Sink<String> get inputEmail;
  Sink<String> get inputPass;
}

abstract class SigninViewModelOutputs extends BaseViewModelOutputs {
  Stream<String> get outEmail;
  Stream<String> get outPass;
}
