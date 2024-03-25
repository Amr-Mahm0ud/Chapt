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

//login models
//user model
class UserModel {
  String id;
  String name;
  UserModel(this.id, this.name);
}

//contact model
class ContactModel {
  String phone;
  String email;
  ContactModel(this.phone, this.email);
}

//Authentication Model
class AuthenticationModel {
  UserModel? user;
  ContactModel? contacts;
  AuthenticationModel(this.user, this.contacts);
}
