import 'package:coswan/screens/password_change_page.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/utils/navigation_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassWordBtn extends StatelessWidget {
  final String userMail;
  const ForgotPassWordBtn({super.key, required this.userMail});

  @override
  Widget build(BuildContext context) {
    return Container(
       color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(gradient: gradient),
          child: GestureDetector(
            onTap: () {
              Focus.of(context).unfocus();
            },
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
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your password has been successfully reset. \nclick confirm to set a new password',
                      style:
                          TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(NavigationTransition(PasswordChangePage(
                          userMail: userMail,
                        )));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 158.w, vertical: 18.h),
                          backgroundColor: Theme.of(context).primaryColor),
                      child: Text('Confirm',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
