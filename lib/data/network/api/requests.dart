class LoginRequest {
  String email;
  String password;
  LoginRequest(this.email, this.password);
}

class SignupRequest {
  String email;
  String password;
  String phoneNumber;
  String userName;
  SignupRequest(this.email, this.password, this.phoneNumber, this.userName);
}
