import 'package:coswan/services/login_api.dart';
import 'package:coswan/services/register_and_forgot_pwd_otp.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordOtp extends StatefulWidget {
  const ForgotPasswordOtp({super.key, this.userEmail});
  final userEmail;
  @override
  State<ForgotPasswordOtp> createState() => _ForgotPasswordOtpState();
}

class _ForgotPasswordOtpState extends State<ForgotPasswordOtp> {
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
  Widget build(BuildContext context) {
    return Container(
       color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            gradient: gradient,
          ),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
                extendBody: true,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                forceMaterialTransparency: true,
                title: Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80.h,
                        ),
                        Image.asset('assets/images/forgotpassword.png'),
                        SizedBox(
                          height: 87.h,
                        ),
                        Text(
                          'Check your Email',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text('We sent an 4 digit code to\n ${widget.userEmail}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400)),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            forgotOtp(context, controller1),
                            forgotOtp(context, controller2),
                            forgotOtp(context, controller3),
                            forgotOtp(context, controller4),
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              forgotpasswordOTPAPI(
                                  widget.userEmail,
                                  controller1.text,
                                  controller2.text,
                                  controller3.text,
                                  controller4.text);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                minimumSize: Size(316.w, 46.w)),
                            child: Text(
                              'Verify',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500),
                            )),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive the email?      ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // api call to resend the otp
                                forgotpassword(widget.userEmail);
                              },
                              child: Text(
                                'Resend OTP',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
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
    );
  }

  Widget forgotOtp(
      BuildContext context, TextEditingController textEditingController) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(3.r),
        borderSide:
            BorderSide(width: 1.w, color: Theme.of(context).primaryColor));
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
        ],
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
      ),
    );
  }

  // to resend the otp for forgot password

  Future<void> forgotpassword(String email) async {
    await LoginAPI.forgotpassword(context, email);
  }

  /// otp post password api
  Future<void> forgotpasswordOTPAPI(
      String email, String otp1, String otp2, String otp3, String otp4) async {
    await OTPAPI.postOtp(context, 'verify-otp', email, otp1, otp2, otp3, otp4);
  }
}
