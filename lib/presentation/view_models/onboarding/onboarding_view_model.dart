import 'dart:async';

import 'package:chapt/domain/models/models.dart';
import 'package:chapt/presentation/resources/app_strings.dart';
import 'package:chapt/presentation/resources/assets_manager.dart';
import 'package:chapt/presentation/view_models/base/base_view_model.dart';

class OnboardingViewModel extends BaseViewModel
    implements OnboardingViewModelInputs, OnboardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<OnboardingViewObject>();
  late List<OnboardingObject> _list;
  int _currentIndex = 0;
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = getListItems();
    _postDataToView();
  }

  //to animate to next onboarding page
  @override
  int goNext() {
    _currentIndex++;
    return _currentIndex;
  }

  //to save current index
  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputOnboardingViewModel => _streamController.sink;

  @override
  Stream<OnboardingViewObject> get outputOnboardingViewModel =>
      _streamController.stream
          .map((onboardingViewObject) => onboardingViewObject);

  //posting data to view
  _postDataToView() {
    inputOnboardingViewModel.add(OnboardingViewObject(
      _list[_currentIndex],
      _list.length,
      _currentIndex,
    ));
  }

  //get list items
  List<OnboardingObject> getListItems() => [
        OnboardingObject(
          AssetsManager.onboarding1,
          AppStrings.onboardingTitle1,
          AppStrings.onboardingSubTitle1,
        ),
        OnboardingObject(
          AssetsManager.onboarding2,
          AppStrings.onboardingTitle2,
          AppStrings.onboardingSubTitle2,
        ),
      ];
}

abstract class OnboardingViewModelInputs extends BaseViewModelInputs {
  // any order comes from view
  int goNext();
  void onPageChanged(int index);
  //sink getter
  Sink get inputOnboardingViewModel;
}

abstract class OnboardingViewModelOutputs extends BaseViewModelOutputs {
  //stream getter
  Stream<OnboardingViewObject> get outputOnboardingViewModel;
}
