import 'package:coswan/screens/login_page.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/utils/navigation_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordUpdateSuccess extends StatelessWidget {
  const PasswordUpdateSuccess({super.key});

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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/success.png'),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Successfully Updated',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                      'Congratulations ! Your password has been \nchanged. Click continue to login',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 15.h,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(NavigationTransition(const LoginPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(horizontal: 40.w, vertical: 8.h),
                          backgroundColor: Theme.of(context).primaryColor),
                      child: Text(
                        'Continue With Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
