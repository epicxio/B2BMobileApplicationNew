import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 90.h, left: 66.w, right: 62.w),
          child: const Image(
            image: AssetImage("assets/images/image1.png"),
          ),
        ),
        SizedBox(
          height: 54.h,
        ),
        Text(
          'Welcome to  Coswan Silvers',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
          ),
        ),
        SizedBox(
          height: 17.h,
        ),
        FittedBox(
          alignment: Alignment.center,
          child: SizedBox(
            width: 303.w,
            height: 54.h,
            child: Column(
              children: [
                Text(
                  'Connect Buyers and Suppliers of the',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    color: const Color.fromRGBO(51, 51, 51, 1),
                  ),
                ),
                FittedBox(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Silvers',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Theme.of(context).primaryColor),
                      ),
                      Text(
                        " Jewellery Industry",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: const Color.fromRGBO(51, 51, 51, 1),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 33.h,
        ),
      ],
    );
  }
}
