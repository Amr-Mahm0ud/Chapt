import 'dart:async';

import 'package:chapt/app/app_constants.dart';
import 'package:chapt/domain/use_case/signup_use_case.dart';
import 'package:chapt/presentation/common/freezed_data_classes.dart';
import 'package:chapt/presentation/resources/app_strings.dart';
import 'package:chapt/presentation/view_models/base/base_view_model.dart';

import '../../common/popup_error.dart';

class SignupViewModel extends BaseViewModel
    implements SignupViewModelInputs, SignupViewModelOutputs {
  final StreamController<String?> _emailStreamController =
      StreamController<String?>.broadcast();
  final StreamController<String?> _passStreamController =
      StreamController<String?>.broadcast();
  final StreamController<String?> _nameStreamController =
      StreamController<String?>.broadcast();
  final StreamController<String?> _phoneNumStreamController =
      StreamController<String?>.broadcast();
  final StreamController<bool> _isLoadingStreamController =
      StreamController<bool>.broadcast();

  final StreamController<bool> isUserRegisteredSuccefully =
      StreamController<bool>.broadcast();

  RegisterObject registerObject = RegisterObject(AppConstants.emptyStr,
      AppConstants.emptyStr, AppConstants.emptyStr, AppConstants.emptyStr);

  final SignupUseCase _signupUseCase;

  // constructor
  SignupViewModel(this._signupUseCase);

  //abstract class functions
  @override
  void dispose() {
    _emailStreamController.close();
    _passStreamController.close();
    _nameStreamController.close();
    _phoneNumStreamController.close();
    _isLoadingStreamController.close();
    isUserRegisteredSuccefully.close();
  }

  @override
  void start() {
    inIsLoading.add(false);
  }

  //input sinks
  @override
  Sink<bool> get inIsLoading => _isLoadingStreamController.sink;

  @override
  Sink<String?> get inputEmail => _emailStreamController.sink;

  @override
  Sink<String?> get inputName => _nameStreamController.sink;

  @override
  Sink<String?> get inputPass => _passStreamController.sink;

  @override
  Sink<String?> get inputPhoneNum => _phoneNumStreamController.sink;

  //input functions
  @override
  register(context) async {
    inIsLoading.add(true);
    (await _signupUseCase.excute(
      SignupUseCaseInput(
        registerObject.email,
        registerObject.pass,
        registerObject.phoneNum,
        registerObject.userName,
      ),
    ))
        .fold((failure) {
      inIsLoading.add(false);
      PopupError.showErrorDialog(context, failure.message);
      return {};
    }, (data) {
      inIsLoading.add(false);
      isUserRegisteredSuccefully.add(true);
    });
  }

  @override
  void setEmail(email) {
    inputEmail.add(email);
    registerObject = registerObject.copyWith(email: email);
  }

  @override
  void setName(name) {
    inputName.add(name);
    registerObject = registerObject.copyWith(userName: name);
  }

  @override
  void setPassword(pass) {
    inputPass.add(pass);
    registerObject = registerObject.copyWith(pass: pass);
  }

  @override
  void setPhoneNum(phone) {
    inputPhoneNum.add(phone);
    registerObject = registerObject.copyWith(phoneNum: phone);
  }

  //output streams
  @override
  Stream<String?> get outEmail =>
      _emailStreamController.stream.map((email) => validateEmail(email));

  @override
  Stream<bool> get outIsLoading => _isLoadingStreamController.stream;

  @override
  Stream<String?> get outName =>
      _nameStreamController.stream.map((name) => validateName(name));

  @override
  Stream<String?> get outPass =>
      _passStreamController.stream.map((pass) => validatePass(pass));

  @override
  Stream<String?> get outPhoneNum => _phoneNumStreamController.stream
      .map((phoneNum) => validatePhoneNum(phoneNum));

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

  String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return AppStrings.nameRep;
    } else {
      return null;
    }
  }

  String? validatePhoneNum(String? phoneNum) {
    if (phoneNum == null || phoneNum.trim().isEmpty) {
      return AppStrings.phoneReq;
    } else {
      return null;
    }
  }
}

abstract class SignupViewModelInputs extends BaseViewModelInputs {
  void setEmail(email);
  void setPassword(pass);
  void setName(name);
  void setPhoneNum(phone);
  register(context);

  Sink<String?> get inputEmail;
  Sink<String?> get inputPass;
  Sink<String?> get inputName;
  Sink<String?> get inputPhoneNum;
  Sink<bool> get inIsLoading;
}

abstract class SignupViewModelOutputs extends BaseViewModelOutputs {
  Stream<String?> get outEmail;
  Stream<String?> get outPass;
  Stream<String?> get outName;
  Stream<String?> get outPhoneNum;
  Stream<bool> get outIsLoading;
}
