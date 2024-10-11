import 'package:coswan/services/register_and_forgot_pwd_otp.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpLoginpage extends StatefulWidget {
  final String useremail;
  const OtpLoginpage({super.key, required this.useremail});

  @override
  State<OtpLoginpage> createState() => _OtpLoginpageState();
}

class _OtpLoginpageState extends State<OtpLoginpage> {
  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;
  late TextEditingController controller4;

  @override
  void initState() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
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
            // resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
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
                //  color: Color.fromRGBO(206, 206, 206, 1),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 38.h,
                    ),
                    Center(child: Image.asset('assets/images/otplogin.png')),
                    SizedBox(
                      height: 108.h,
                    ),
                    Text(
                      'Verification Code',
                      style:
                          TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'We have sent to you an Verification code\n  via email for  Verification',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        otptext(context, controller1),
                        otptext(context, controller2),
                        otptext(context, controller3),
                        otptext(context, controller4),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Didn't receive the OTP?",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Resend OTP',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        postOtp(widget.useremail, controller1.text,
                            controller2.text, controller3.text, controller4.text);
                        // print(controller1.text);
                        // print(controller2.text);
                        // print(controller3.text);
                        // print(controller4.text);
                        // print(
                        //     '${controller1.text + controller2.text + controller3.text + controller4.text}');
        
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const OtpSuccesspage()));
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(370.w, 60.h),
                          backgroundColor: Theme.of(context).primaryColor),
                      child: Text(
                        'Verify',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget otptext(
      BuildContext context, TextEditingController textEditingController) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(
          color: Color.fromRGBO(221, 221, 221, 1),
        ));
    return SizedBox(
      height: 71.h,
      width: 71.h,
      child: TextField(
        controller: textEditingController,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
          // if (value.length == 0) {
          //   FocusScope.of(context).previousFocus();
          // }
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'A',
          border: InputBorder.none,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: TextInputType.text,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          //FilteringTextInputFormatter.deny(RegExp('r^[0-9]')),
          // FilteringTextInputFormatter.allow(RegExp('r^[a-zA-Z]'))
        ],
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
      ),
    );
  }

  postOtp(String userEmail, String otp1, String otp2, String otp3,
      String otp4) async {
    await OTPAPI.postOtp(
        context, 'submit-otp', userEmail, otp1, otp2, otp3, otp4);
  }
}
