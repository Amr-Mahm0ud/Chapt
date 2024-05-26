import 'package:chapt/domain/models/models.dart';
import 'package:chapt/presentation/resources/app_strings.dart';
import 'package:chapt/presentation/resources/routes_manager.dart';
import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:chapt/presentation/view_models/onboarding/onboarding_view_model.dart';
import 'package:chapt/presentation/widgets/common/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final OnboardingViewModel _viewModel = OnboardingViewModel();

  _bind() {
    _viewModel.start();
    // _appPreferences.setOnBoardingScreenViewed();
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
    return StreamBuilder<OnboardingViewObject>(
      stream: _viewModel.outputOnboardingViewModel,
      builder: (context, snapshot) => _getContent(snapshot.data),
    );
  }

  Widget _getContent(OnboardingViewObject? viewObject) {
    if (viewObject == null) {
      return const CircularProgressIndicator();
    } else {
      return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemCount: viewObject.pageCount,
                  onPageChanged: (index) {
                    _viewModel.onPageChanged(index);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          viewObject.onboardingObject.image,
                          width: AppValues.getWidth(context) * AppValues.v05,
                          height: AppValues.getWidth(context) * AppValues.v05,
                        ),
                        Card(
                          margin: const EdgeInsets.all(AppMargins.m30),
                          child: Padding(
                            padding: const EdgeInsets.all(AppPadding.p30),
                            child: Column(
                              children: [
                                Text(
                                  viewObject.onboardingObject.title,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                Text(
                                  viewObject.onboardingObject.subTitle,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p30,
                  horizontal: AppPadding.p30,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: AppValues.i300),
                  child: _viewModel.currentIndex == _pageController.initialPage
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AppButton(
                              action: () {
                                Navigator.pushReplacementNamed(
                                    context, Routes.signup);
                              },
                              content: Text(AppStrings.skip,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color)),
                              color: Theme.of(context).colorScheme.secondary,
                              rounded: true,
                            ),
                            AppButton(
                              action: () {
                                _pageController.animateToPage(
                                    _viewModel.goNext(),
                                    duration: const Duration(
                                        milliseconds: AppValues.i300),
                                    curve: AppValues.linear);
                              },
                              content: const Text(AppStrings.next),
                              rounded: true,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: AppButton(
                                action: () {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.signup);
                                },
                                content: const Text(AppStrings.cont),
                                rounded: true,
                              ),
                            ),
                            const SizedBox(height: AppValues.v10),
                            SizedBox(
                              width: double.infinity,
                              child: AppButton(
                                action: () {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.home);
                                },
                                color: Theme.of(context).colorScheme.secondary,
                                content: const Text(AppStrings.guest),
                                rounded: true,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
