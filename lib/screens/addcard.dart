import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  bool saveCard = false;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromRGBO(203, 213, 225, 1)),
        borderRadius: BorderRadius.circular(3.r));
    return Container(
      decoration: const BoxDecoration(
        gradient: gradient,
      ),
      child: Scaffold(
         extendBody: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
           forceMaterialTransparency: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
         
          title: Text(
            'Add Card',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
          leading: Icon(Icons.arrow_back_ios),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(252, 224, 185, 1),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  //   height: 200.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 35.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.h, left: 20.w),
                        width: double.infinity,
                        height: 40.h,
                        color: Colors.black,
                        child: Text(
                          '4716 9627 1635 8047',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp),
                        ),
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 22.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Steve Smith',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                Image.asset('assets/icons/ic_cardc1.png'),
                                SizedBox(
                                  width: 100.w,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                            'assets/icons/ic_cardc2.png'),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Image.asset(
                                            'assets/icons/ic_cardc3.png'),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Image.asset(
                                            'assets/icons/ic_cardc4.png'),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 74.h,
                ),
                Text(
                  'Card Holder Name',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                    height: 42.h,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          hintText: 'Steve Smith',
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: border,
                          focusedBorder: border),
                    )),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Card Number',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                    height: 42.h,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          hintText: '4716 9627 1635 8047',
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: border,
                          focusedBorder: border),
                    )),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiry Date',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                            width: 153.w,
                            height: 42.h,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                  hintText: '02/30',
                                  contentPadding: const EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: border,
                                  focusedBorder: border),
                            )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CVV',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                            width: 153.w,
                            height: 42.h,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                  hintText: '321',
                                  contentPadding: const EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: border,
                                  focusedBorder: border),
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                Row(
                  children: [
                    Checkbox(
                        value: saveCard,
                        checkColor: Colors.amber,
                        onChanged: (val) {
                          setState(() {
                            saveCard = val!;
                          });
                        }),
                    Text(
                      'Save Card',
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                SizedBox(
                  height: 100.h,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(238.w, 50.h),
                        backgroundColor: Theme.of(context).primaryColor),
                    child: Text(
                      'Add Card',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
