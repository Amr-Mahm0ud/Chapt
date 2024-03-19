// Onboarding models
class OnboardingObject {
  String title;
  String subTitle;
  String image;
  OnboardingObject(this.image, this.title, this.subTitle);
}

class OnboardingViewObject {
  OnboardingObject onboardingObject;
  int pageCount;
  int currentIndex;
  OnboardingViewObject(
      this.onboardingObject, this.pageCount, this.currentIndex);
}
