import 'package:coswan/screens/login_page.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpSuccesspage extends StatelessWidget {
  const OtpSuccesspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
            decoration: const BoxDecoration(
              gradient: gradient,
            ),
            child: Scaffold(
                extendBody: true,
                appBar: AppBar(
                  forceMaterialTransparency: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'Verification Code',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  centerTitle: true,
                  leading: const Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromRGBO(206, 206, 206, 1),
                  ),
                ),
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Column(children: [
                    SizedBox(
                      height: 38.h,
                    ),
                    Center(child: Image.asset('assets/images/otplogin.png')),
                    SizedBox(
                      height: 108.h,
                    ),
                    Text(
                      'Success',
                      style:
                          TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Text(
                      'Congratulations! ',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Thanks ! for Join Us\nYour mobile number is Verified\nPlease Login and See the all Products.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 31.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const LoginPage())));
                      },
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(370.w, 60.h),
                          backgroundColor: Theme.of(context).primaryColor),
                    ),
                  ]),
                ))),
      ),
    );
  }
}
