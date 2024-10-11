import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllowLocation extends StatelessWidget {
  const AllowLocation({super.key});

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
            backgroundColor: Colors.transparent,
            appBar: AppBar(
               forceMaterialTransparency: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Allow Location',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              centerTitle: true,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150.h,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  minRadius: 70.r,
                  child: Icon(
                    Icons.location_on,
                    size: 50,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text('What is your Location?',
                    style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor)),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                    'We need to know your location in order to \nsuggest nearby services.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  height: 40.h,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r)),
                      maximumSize: Size(275.w, 45.h),
                      backgroundColor: Theme.of(context).primaryColor),
                  child: Center(
                    child: Text(
                      'Allow Location Access',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Enter Location Manually',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
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
