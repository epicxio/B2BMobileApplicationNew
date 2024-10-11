import 'dart:async';
import 'package:coswan/services/login_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordChangePage extends StatefulWidget {
  final String userMail;
  const PasswordChangePage({super.key, required this.userMail});

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(3.r)),
    borderSide: const BorderSide(
      color: Color.fromRGBO(203, 213, 225, 1),
    ),
  );
  final errorborder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.r),
      borderSide: const BorderSide(color: Colors.red));

  late FocusNode passwordfocus1;
  late FocusNode passwordfocus2;
  late TextEditingController passwordController1;
  late TextEditingController passwordController2;
  bool obscureText1 = true;
  bool obscureText2 = false;

  @override
  void initState() {
    passwordfocus1 = FocusNode();
    passwordfocus2 = FocusNode();
    passwordController1 = TextEditingController();
    passwordController2 = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(gradient: gradient),
          child: Scaffold(
              extendBody: true,
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              forceMaterialTransparency: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Password reset',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Set a new password',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      'Create a new password. Ensure it differs from previous ones for security',
                      style: TextStyle(
                          color: const Color.fromRGBO(152, 152, 152, 1),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 38.h,
                  ),
                  Text(
                    'Password',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  passwordField(
                    passwordController1,
                    obscureText1,
                    passwordfocus1,
                    (value) {
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
                  SizedBox(
                    height: 22.h,
                  ),
                  Text(
                    'Confirm Password',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  passwordField(
                    passwordController2,
                    obscureText2,
                    passwordfocus2,
                    (value) {
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
                        // })  }
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (passwordController1.text.length >= 8 &&
                            passwordController2.text.length >= 8 &&  passwordController1.text == passwordController2.text) {
                          newpasswordAPI(
                              widget.userMail,
                              passwordController1.text,
                              passwordController2.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Minimum 8 character and both fields should be same',style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white
                            ),),
                            backgroundColor: Colors.red,),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(380.w, 50.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 100.w, vertical: 18.h),
                          backgroundColor: Theme.of(context).primaryColor),
                      child: Text(
                        'Update Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordField(TextEditingController controller, bool isObscured,
      FocusNode focusnode, String? Function(String?)? validator) {
    return SizedBox(
      height: 42.h,
      width: 380.w,
      child: TextFormField(
        focusNode: focusnode,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        controller: controller,
        obscureText: isObscured,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(10.w),
            hintText: "Password",
            errorBorder: errorborder,
            focusedErrorBorder: errorborder,
            errorStyle: TextStyle(height: 0.h),
            enabledBorder: border,
            focusedBorder: border,
            suffixIcon: IconButton(
              icon: Icon(
                isObscured ? Icons.visibility : Icons.visibility_off,
                color: const Color.fromRGBO(166, 155, 155, 1),
              ),
              onPressed: () {
                setState(() {
                  if (controller == passwordController1) {
                    obscureText1 = !obscureText1;
                  } else {
                    setState(() {
                      obscureText2 = !obscureText2;
                    });
                  }
                });
              },
            )),
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Future newpasswordAPI(
      String email, String newpassword, String confirmPassword) async {
    await LoginAPI.newpasswordAPI(context, email, newpassword, confirmPassword);
  }
}
