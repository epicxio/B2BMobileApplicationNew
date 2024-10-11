import 'package:coswan/screens/forgot_password_screen.dart';
import 'package:coswan/services/login_api.dart';
import 'package:coswan/utils/navigation_transition.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/screens/register_page.dart';
import 'package:coswan/screens/swipepageview/swipepageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isChecked = false;

  late FocusNode emailfocus;
  late FocusNode passwordfocus;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool field = false;
  bool _obscureText = true;
  final errorborder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.r),
      borderSide: const BorderSide(color: Colors.red));

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(3.r)),
    borderSide: const BorderSide(
      color: Color.fromRGBO(203, 213, 225, 1),
    ),
  );

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailfocus = FocusNode();
    passwordfocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailfocus.dispose();
    passwordfocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(gradient: gradient),
          child: Scaffold(
              extendBody: true,
            backgroundColor: Colors.transparent,
            // resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              forceMaterialTransparency: true,
              backgroundColor: Colors.transparent,
              title: Text(
                'Login',
                style: TextStyle(
                  fontSize: 22.sp,
                ),
              ),
              leading: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SwipePageView()));
                  },
                  child: const Icon(Icons.arrow_back_ios)),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 10.h,
                    left: 25.w,
                    right: 25.w,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Image(
                              image: AssetImage('assets/images/login_image.png'),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            "Welcome Back",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Text(
                            "Great to you see again",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Phone no Or Email Id",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 42.h,
                            width: 380.w,
                            child: TextFormField(
                              //Email Text field
                              focusNode: emailfocus,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              autofillHints: const [AutofillHints.email],
                              maxLines: 1,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Phone No / Email",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: Image.asset(
                                   // 'assets/icons/ic_emailIcon.png',
                                  'assets/icons/ic_phone_email.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 42.w),
                                enabledBorder: border,
                                focusedBorder: border,
                                errorText: null,
                                errorBorder: errorborder,
                                focusedErrorBorder: errorborder,
                                errorStyle: TextStyle(height: 0.h),
                              ),
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(passwordfocus);
                              },
                             
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                // Regular expression for email validation
                                bool isEmail =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value);
                                // Regular expression for phone number validation
                                bool isPhone =
                                    RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value);
        
                                if (!isEmail && !isPhone) {
                                  return null ;
                                }
                                return null;
                              },
                             
                            ),
                          ),
                          Visibility(
                            visible: (emailController.text.isEmpty && field),
                            child: Text(
                              "Phone no or Email id is required",
                              style: TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            height: 19.h,
                          ),
                          Text(
                            "Password",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 42.h,
                            width: 380.w,
                            child: TextFormField(
                              focusNode: passwordfocus,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10.w),
                                  hintText: "Password",
                                  enabledBorder: border,
                                  focusedBorder: border,
                                  errorBorder: errorborder,
                                  errorText: null,
                                  focusedErrorBorder: errorborder,
                                //  errorStyle: TextStyle(height: 0.h),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: Image.asset(
                                      'assets/icons/ic_passwordicon.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 42.w),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                } else if (value.length < 8) {
                                  return null;
                                  // } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                  //   return "";
                                  // } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                                  //   return "";
                                  // } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                                  //   return "";
                                  // }
                                }
                                return null;
                              },
                             
                            ),
                          ),
                          Visibility(
                            visible: (passwordController.text.isEmpty && field),
                            child: Text(
                              "Password is required",
                              style: TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                  value: isChecked,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isChecked = newValue!;
                                    });
                                  }),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    "Remember Me",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(NavigationTransition(
                                      const ForgotPasswordScreen()));
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).primaryColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                postData(emailController.text,
                                    passwordController.text, isChecked);
                              } else {
                                setState(() {
                                  field = true;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(144, 110, 16, 1),
                                minimumSize: Size(378.w, 46.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                )
        
                                // minimumSize: ,
                                ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(255, 255, 255, 1),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account ?",
                                style: TextStyle(
                                    fontSize: 16.sp, fontWeight: FontWeight.w600),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()));
                                },
                                child: Text(
                                  " Sign Up Now",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postData(identifier, password, isChecked) async {
    await LoginAPI.postData(context, identifier, password, isChecked);
  }
}
