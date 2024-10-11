import 'package:coswan/services/register_api.dart';
import 'package:flutter/services.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/screens/login_page.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterpageState();
}

class RegisterpageState extends State<RegisterPage> {
  String itemSelected = '';
  late FocusNode storenameFocus;
  late FocusNode addressFocus;

  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  late FocusNode phoneNoFocus;
  late FocusNode gstFocus;
  bool storefield = false;
  bool addressfield = false;
  bool rolefield = false;
  bool emailfield = false;
  bool passwordfield = false;
  bool phoneNofield = false;
  bool gstfield = false;
  bool cityfield = false;
  bool loading = true;

  late String role = '';
  late TextEditingController storeEditor;
  late TextEditingController addressEditor;
  late TextEditingController emailEditor;
  late TextEditingController phoneNumEditor;
  late TextEditingController pwdEditor;
  late TextEditingController gstEditor;
  bool acceptedTerms = false;
  bool _obscureText = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    fetchInitData();
    setState(() {});
    storenameFocus = FocusNode();
    addressFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    phoneNoFocus = FocusNode();
    gstFocus = FocusNode();
    phoneNumEditor = TextEditingController();
    storeEditor = TextEditingController();
    addressEditor = TextEditingController();
    emailEditor = TextEditingController();
    gstEditor = TextEditingController();
    pwdEditor = TextEditingController();
    super.initState();
  }

  bool isChecked = false;
  late List<String> cities;
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
  void dispose() {
    storenameFocus.dispose();
    addressFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    phoneNoFocus.dispose();
    gstFocus.dispose();
    phoneNumEditor.dispose();
    storeEditor.dispose();
    addressEditor.dispose();
    emailEditor.dispose();
    gstEditor.dispose();
    pwdEditor.dispose();
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
              gradient: gradient), //  extendBodyBehindAppBar: true,
          //  resizeToAvoidBottomInset: false,
          child: Scaffold(
              extendBody: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              forceMaterialTransparency: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text("Registration"),
              leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back_ios)),
            ),
            body: SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 31.w),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create an account and get started",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Store name",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5.h),
                          SizedBox(
                            width: 380.w,
                            height: 42.h,
                            child: TextFormField(
                              focusNode: storenameFocus,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              controller: storeEditor,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(height: 0.h),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Store Name",
                                  contentPadding: const EdgeInsets.all(10),
                                  enabledBorder: border,
                                  focusedBorder: border,
                                  errorBorder: errorborder,
                                  focusedErrorBorder: errorborder,
                                  errorText: null),
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(addressFocus);
                              },
                              validator: (value) {
                                if (storeEditor.text == null ||
                                    storeEditor.text.isEmpty) {
                                  return null;
                                }
                                return null;
                              },
                            ),
                          ),
                          Visibility(
                            visible: (storeEditor.text.isEmpty && storefield),
                            child: Text(
                              "Store name is required",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Address",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            width: 380.w,
                            height: 42.h,
                            child: TextFormField(
                              focusNode: addressFocus,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                              controller: addressEditor,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: "Address",
                                  enabledBorder: border,
                                  focusedBorder: border,
                                  errorBorder: errorborder,
                                  focusedErrorBorder: errorborder,
                                  errorStyle: TextStyle(height: 0.h),
                                  errorText: null),
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(emailFocus);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                return null;
                              },
                            ),
                          ),
                          Visibility(
                            visible:
                                (addressEditor.text.isEmpty && addressfield),
                            child: Text(
                              "Address is required",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "Role",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            width: 380.w,
                            height: 42.h,
                            child: DropDownTextField(
                              textStyle: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                              textFieldDecoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: Image.asset(
                                        'assets/icons/ic_loginpersonicon.png',
                                        fit: BoxFit.fill),
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 42.w),
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: "Role",
                                  enabledBorder: border,
                                  focusedBorder: border,
                                  errorBorder: errorborder,
                                  focusedErrorBorder: errorborder,
                                  errorText: null,
                                  errorStyle: TextStyle(height: 0.h)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                return null;
                              },
                              clearOption: false,
                              dropDownList: const [
                                DropDownValueModel(
                                    name: "Store owner", value: "Store Owner"),
                                DropDownValueModel(
                                    name: "Purchase Manager",
                                    value: "Purchase Manager"),
                              ],
                              onChanged: (valueofDropDown) {
                                setState(() {
                                  role = valueofDropDown.value;
                                });
                                // print(role);
                              },
                            ),
                          ),
                          Visibility(
                            visible: (role.isEmpty && rolefield),
                            child: Text(
                              "Role is required",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Email Id",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5.h),
                          SizedBox(
                            width: 380.w,
                            height: 42.h,
                            child: TextFormField(
                              focusNode: emailFocus,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                              controller: emailEditor,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Email",
                                enabledBorder: border,
                                focusedBorder: border,
                                errorBorder: errorborder,
                                focusedErrorBorder: errorborder,
                                errorText: null,
                                errorStyle: TextStyle(height: 0.h),
                              ),
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(passwordFocus);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }

                                // Regular expression for basic email validation
                                final emailRegex = RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,}$');

                                if (!emailRegex.hasMatch(value)) {
                                  return null;
                                }

                                return null; // Return null if the input is valid
                              },
                            ),
                          ),
                          Visibility(
                            visible: (emailEditor.text.isEmpty && emailfield),
                            child: Text(
                              "Email id is required",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            width: 380.w,
                            height: 42.h,
                            child: TextFormField(
                              focusNode: passwordFocus,
                              obscureText: _obscureText,
                              controller: pwdEditor,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                hintText: "Password",
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: const EdgeInsets.all(10),
                                enabledBorder: border,
                                focusedBorder: border,
                                errorBorder: errorborder,
                                errorText: null,
                                focusedErrorBorder: errorborder,
                                errorStyle: TextStyle(height: 0.h),
                                suffixIconConstraints:
                                    BoxConstraints(minWidth: 42.w),
                                suffixIcon: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(3.r),
                                      bottomRight: Radius.circular(3.r),
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: Icon(_obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    color: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(phoneNoFocus);
                              },
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
                            visible: (pwdEditor.text.isEmpty && passwordfield),
                            child: Text(
                              "Minimum 8 character is required",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Phone No',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            width: 380.w,
                            height: 42.h,
                            child: TextFormField(
                              focusNode: phoneNoFocus,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                              controller: phoneNumEditor,
                              decoration: InputDecoration(
                                hintText: 'Phone No',
                                filled: true,
                                contentPadding: const EdgeInsets.all(10),
                                fillColor: Colors.white,
                                enabledBorder: border,
                                focusedBorder: border,
                                errorBorder: errorborder,
                                focusedErrorBorder: errorborder,
                                errorText: null,
                                errorStyle: TextStyle(height: 0.h),
                              ),
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(gstFocus);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                } else if (value.length != 10) {
                                  return null;
                                }
                                return null;
                              },
                            ),
                          ),
                          Visibility(
                            visible:
                                (phoneNumEditor.text.isEmpty && phoneNofield),
                            child: Text(
                              "Phone no is required",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          const Text(
                            "GST Number",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            width: 380.w,
                            height: 42.h,
                            child: TextFormField(
                              focusNode: gstFocus,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                              controller: gstEditor,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: "GST",
                                  enabledBorder: border,
                                  focusedBorder: border,
                                  focusedErrorBorder: errorborder,
                                  errorBorder: errorborder,
                                  errorText: null,
                                  errorStyle: TextStyle(height: 0.h)),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                  // } else if (!RegExp(
                                  //         r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9A-Z]{1}[Z]{1}$')
                                  //     .hasMatch(value)) {
                                  //   return "please Enter the appropriate Gst";
                                  // }
                                }
                                return null;
                              },
                            ),
                          ),
                          Visibility(
                            visible: (gstEditor.text.isEmpty && gstfield),
                            child: Text(
                              "Gst is required",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "City",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            width: 380.w,
                            height: 42.h,
                            child: DropdownSearch<String>(
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  constraints: BoxConstraints(maxHeight: 5.h),
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'city',
                                  //   hintStyle: TextStyle(color: Colors.black),
                                  contentPadding: const EdgeInsets.all(10),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  errorBorder: errorborder,
                                  errorText: null,
                                  focusedErrorBorder: errorborder,
                                  errorStyle: TextStyle(height: 0.h),
                                ),
                              ),
                              items: loading ? [] : cities,
                              onChanged: (value) {
                                setState(() {
                                  itemSelected = value.toString();
                                });
                              },
                              selectedItem: itemSelected,
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        constraints:
                                            BoxConstraints(maxHeight: 50.h))),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                return null;
                              },
                            ),
                          ),
                          Visibility(
                            visible: (itemSelected.isEmpty && cityfield),
                            child: Text(
                              "City is required",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                  value: isChecked,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isChecked = newValue!;
                                      if (isChecked) {
                                        acceptedTerms = true;
                                      } else {
                                        acceptedTerms = false;
                                      }
                                    });
                                  }),
                              Text(
                                'I accept the',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                ' Privacy Policy ',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'and',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                " Terms & Conditons",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (!acceptedTerms) {
                                const snackBar = SnackBar(
                                  content: Text('Select the checkbox'),
                                  duration: Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor:
                                      Color.fromRGBO(144, 110, 16, 1),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              if (isChecked == true) {
                                if (storeEditor.text.isEmpty) {
                                  setState(() {
                                    storefield = true;
                                  });
                                } else {
                                  storefield = false;
                                }
                                if (addressEditor.text.isEmpty) {
                                  setState(() {
                                    addressfield = true;
                                  });
                                }
                                if (role.isEmpty) {
                                  setState(() {
                                    rolefield = true;
                                  });
                                }
                                if (emailEditor.text.isEmpty) {
                                  setState(() {
                                    emailfield = true;
                                  });
                                }
                                if (pwdEditor.text.isEmpty) {
                                  setState(() {
                                    passwordfield = true;
                                  });
                                }
                                if (phoneNumEditor.text.isEmpty ||
                                    phoneNumEditor.text.length != 10) {
                                  setState(() {
                                    phoneNofield = true;
                                  });
                                }
                                if (gstEditor.text.isEmpty) {
                                  setState(() {
                                    gstfield = true;
                                  });
                                }
                                if (itemSelected.isEmpty) {
                                  setState(() {
                                    cityfield = true;
                                  });
                                }
                                if (_formkey.currentState!.validate()) {
                                  registerAPI(
                                      storeEditor.text,
                                      addressEditor.text,
                                      role,
                                      emailEditor.text,
                                      pwdEditor.text,
                                      int.parse(phoneNumEditor.text),
                                      gstEditor.text,
                                      itemSelected,
                                      acceptedTerms);
                                }
                                //   else {
                                //     setState(() {
                                //       field = true;
                                //     });
                                //     print('..................................');
                                //     final snackBar = SnackBar(
                                //       content: Text('Enter all the fields'),
                                //       duration: Duration(seconds: 3),
                                //       behavior: SnackBarBehavior.floating,
                                //       backgroundColor:
                                //           const Color.fromRGBO(144, 110, 16, 1),
                                //     );
                                //     ScaffoldMessenger.of(context)
                                //         .showSnackBar(snackBar);
                                //   }
                                // }
                              }
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const OtpLoginpage()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(144, 110, 16, 1),
                              minimumSize: Size(378.w, 46.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                            ),
                            child: Text(
                              "Sign Up Now",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(255, 255, 255, 1),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 17.h,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account ? ",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  },
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                )
                              ]),
                          // SizedBox(
                          //   height: 17.h,
                          // ),
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

  void fetchInitData() async {
    cities = await registerCityAPI();
    loading = false;
    setState(() {});
  }

  Future<void> registerAPI(
    String storename,
    String address,
    String role,
    String email,
    String password,
    int phoneno,
    String gst,
    String city,
    bool acceptedTerms,
  ) async {
    await RegisterApi.postData(context, storename, address, email, password,
        phoneno, gst, city, role, acceptedTerms);
  }

  Future<List<String>> registerCityAPI() async {
    final response = await RegisterApi.registerCityAPI();
    return response;
  }
}
