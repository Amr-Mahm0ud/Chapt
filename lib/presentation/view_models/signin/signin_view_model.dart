import 'dart:async';

import 'package:chapt/app/app_constants.dart';
import 'package:chapt/presentation/common/freezed_data_classes.dart';
import 'package:chapt/presentation/common/popup_error.dart';
import 'package:chapt/presentation/resources/app_strings.dart';
import 'package:chapt/presentation/view_models/base/base_view_model.dart';

import '../../../domain/use_case/login_use_case.dart';

class SigninViewModel extends BaseViewModel
    implements SigninViewModelInputs, SigninViewModelOutputs {
  final LoginUseCase _loginUseCase;

  // constructor
  SigninViewModel(this._loginUseCase);

  //variables
  final StreamController<String?> _emailStreamController =
      StreamController<String?>.broadcast();
  final StreamController<String?> _passStreamController =
      StreamController<String?>.broadcast();
  final StreamController<bool> _isLoadingStreamController =
      StreamController<bool>.broadcast();

  final StreamController<bool> isUserLoggedInSuccefully =
      StreamController<bool>.broadcast();

  LoginObject loginObject =
      LoginObject(AppConstants.emptyStr, AppConstants.emptyStr);

  // base view model functions
  @override
  void dispose() {
    _emailStreamController.close();
    _passStreamController.close();
    _isLoadingStreamController.close();
    isUserLoggedInSuccefully.close();
  }

  @override
  void start() {
    inIsLoading.add(false);
  }

//*********************************************************** */

//input view model
  @override
  Sink<String?> get inputEmail => _emailStreamController.sink;

  @override
  Sink<String?> get inputPass => _passStreamController.sink;

  @override
  Sink<bool> get inIsLoading => _isLoadingStreamController.sink;
  //functions
  @override
  login(context) async {
    inIsLoading.add(true);
    (await _loginUseCase.excute(
      LoginUseCaseInput(loginObject.email, loginObject.pass),
    ))
        .fold((failure) {
      inIsLoading.add(false);
      PopupError.showErrorDialog(context, failure.message);
      return {};
    }, (data) {
      inIsLoading.add(false);
      isUserLoggedInSuccefully.add(true);
    });
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
  Stream<String?> get outEmail =>
      _emailStreamController.stream.map((email) => validateEmail(email ?? ''));

  @override
  Stream<String?> get outPass =>
      _passStreamController.stream.map((pass) => validatePass(pass ?? ''));

  @override
  Stream<bool> get outIsLoading => _isLoadingStreamController.stream;

  //validation functions
  String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return AppStrings.emailReq;
    } else {
      return null;
    }
  }

  String? validatePass(String? pass) {
    if (pass == null || pass.trim().isEmpty) {
      return AppStrings.passReq;
    } else {
      return null;
    }
  }
}

abstract class SigninViewModelInputs extends BaseViewModelInputs {
  void setEmail(String email);
  void setPass(String pass);
  login(context) {}

  Sink<String?> get inputEmail;
  Sink<String?> get inputPass;
  Sink<bool> get inIsLoading;
}

abstract class SigninViewModelOutputs extends BaseViewModelOutputs {
  Stream<String?> get outEmail;
  Stream<String?> get outPass;
  Stream<bool> get outIsLoading;
}
