const String tNext = "Next";
const String tLogin = "Login";
const String tEmail = "E-Mail";
const String tSignup = "Signup";
const String tPhoneNo = "Phone No";
const String tPassword = "Password";
const String tFullName = "Full Name";
const String tForgetPassword = "Forget Password";
const String tSignInWithGoogle = "Sign-In with Google";
const String sloganLine = "Emergency?";
const String sloganUnderhead = "We are always there for you";
const String tLoginTitle = "Welcome";
const String tLoginSubTitle = "Make it work, make it right, make it fast.";
const String tRememberMe = "Remember Me?";
const String tDontHaveAnAccount = "New User? ";
const String emailAddress = "Email Address";
const String password = "Password";
const String forgotPasswor = "Forgot Password";
const String skip = "Skip";
// -- Sign Up Screen Text
const String tSignUpTitle = "Create\nAn Account!";
const String tsubTitle = "Get Help at time of emergency";
const String name = "Name";
const String phoneNumber = "Phone Number";
const String termsAndConditions = "By continuing you agree to our";
const String termsAndConditions2 = "Terms of Service and Privacy Policy";
const String contin = "Countinue";
//SignUpPage2
const String subTitle = "Emergency services one tap away";
const String tage = "Age";
const String tbloodGroup = "Blood Group";
const String tgender = "Gender";
const String theight = "Height";
const String goBack = "Go Back";

//SignUpPage3
const String page3title = "Emergency Service one tap away";
const String trelative1 = "Relative Phone Number 1";
const String trelative2 = "Relative Phone Number 2";
const String tsignIn = "Sign In";

const String tForgetPhoneSubTitle = "Enter your registered Phone No to receive OTP";

const String tForgetMailSubTitle = "Enter your registered E-Mail to receive OTP";

class ApiEndPoints {
  static const String baseUrl = 'http://tapit.herokuapp.com/user/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'authaccount/registration';
  final String loginEmail = 'add/login';
}
