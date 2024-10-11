import 'package:coswan/services/login_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final errorborder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.r),
      borderSide: const BorderSide(color: Colors.red));
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(3.r)),
    borderSide: const BorderSide(
      color: Color.fromRGBO(203, 213, 225, 1),
    ),
  );
  late TextEditingController emailController;
  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
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
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 80.h,
                              ),
                              Image.asset('assets/images/forgotpassword.png'),
                              SizedBox(
                                height: 87.h,
                              ),
                              Text(
                                'Forgot Password',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                'Don\'t worry! Please enter address associated.\nWe\'ll send you reset instructions.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 39.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email Id',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        height: 42.h,
                                        width: 380.w,
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: emailController,
                                          autofillHints: const [
                                            AutofillHints.email
                                          ],
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            filled: true,
                                            fillColor: Colors.white,
                                            enabledBorder: border,
                                            focusedBorder: border,
                                            errorStyle: TextStyle(height: 0.h),
                                            errorBorder: null,
                                            focusedErrorBorder: errorborder,
                                            prefixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10.h),
                                              child: Image.asset(
                                                'assets/icons/ic_phone_email.png',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                    .hasMatch(value)) {
                                              return null;
                                            }
                                            return null;
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 22.h,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                          print('ddd');
                                            if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
                                              forgotpassword(
                                                  emailController.text);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  'Invalid Email',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                backgroundColor: Colors.red,
                                              ));
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(381.w, 46.h),
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                          ),
                                          child: Text(
                                            'Send',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.sp,
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Future<void> forgotpassword(String email) async {
    await LoginAPI.forgotpassword(context, email);
  }
}
