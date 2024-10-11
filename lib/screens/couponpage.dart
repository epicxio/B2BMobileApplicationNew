import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/widgets/couponcontainer.dart';
import 'package:coswan/widgets/couponoffer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouponPageView extends StatefulWidget {
  const CouponPageView({super.key});

  @override
  State<CouponPageView> createState() => _CouponPageViewState();
}

class _CouponPageViewState extends State<CouponPageView> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: gradient),
      child: Scaffold(
          extendBody: true,
        appBar: AppBar(
           forceMaterialTransparency: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Apply Coupon',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Best Offers for you',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomPaint(
                    //  size: Size(18.w, 1000.h),
                    painter: CustomCouponPainter(),
                    child: Container(
                      padding: EdgeInsets.only(left: 15.w, top: 13.h),
                      height: 125.h,
                      width: 183.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '50%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          // SizedBox(
                          //   height: 0.h,
                          // ),
                          Padding(
                            padding: EdgeInsets.only(left: 70.w),
                            child: Text(
                              'OFFER',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            'Promo Code : Save 50',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: 22.h,
                ),
                SizedBox(
                  height: 45.sp,
                  child: TextField(
                    // text field to apply the special offers coupon.
                    controller: _controller,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                        hintText: 'Enter Coupon code',
                        contentPadding: const EdgeInsets.all(15),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.r),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(217, 217, 217, 1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.r),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(217, 217, 217, 1)),
                        ),
                        suffixIconConstraints: BoxConstraints(
                            minWidth: 135.w, minHeight: double.infinity),
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.only(top: 10.h),
                            width: double.minPositive,
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              textAlign: TextAlign.center,
                              'Apply',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ClipPath(
                        clipper: CustomContainer(),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              border: Border.all(
                                color: const Color.fromRGBO(182, 182, 182, 1),
                              ),
                              borderRadius: BorderRadius.circular(14.r)),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 15.h, left: 30.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Cashback ₹ 3000',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Text(
                                      'Add items worth \$2 more to unlock',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                            'assets/icons/ic_discount.png'),
                                        SizedBox(
                                          width: 4.h,
                                        ),
                                        Text(
                                          'Diwali 10 % Off',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 46.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(14.r),
                                      bottomRight: Radius.circular(14.r)),
                                  color: const Color.fromRGBO(246, 246, 246, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    'Copy Code',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
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
