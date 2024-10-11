import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 150.h,
            right: 57.w,
            left: 67.w,
          ),
          child: Image(
            height: 367.h,
            width: 307.w,
            image: const AssetImage(
              'assets/images/LakshmiPicture.png',
            ),
          ),
        ),
        SizedBox(height: 90.h),
        FittedBox(
          alignment: Alignment.center,
          child: Text(
            'Welcome  to Coswan Silvers',
            textAlign: TextAlign.center,
            maxLines: 1,
            softWrap: true,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 24.sp,
            ),
          ),
        ),
        SizedBox(
          height: 19.h,
        ),
        FittedBox(
          alignment: Alignment.center,
          child: SizedBox(
            child: Text(
              "Connect with Coswan Jewellery\nManufacturers & Wholesalers",
              textAlign: TextAlign.center,
              maxLines: 2,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
          ),
        )
      ],
    );
  }
}
