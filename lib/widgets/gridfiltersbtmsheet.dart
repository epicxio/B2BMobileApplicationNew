import 'package:coswan/screens/gridviewhomepage.dart';
import 'package:coswan/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridModalSheet extends StatelessWidget {
  final String title;
  const GridModalSheet({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.h, left: 25.h),
            child: Text(
              'Sort By',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
          ),
          SizedBox(
            height: 23.h,
          ),
          Divider(
            height: 0.h,
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 27.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => GridViewHomePage(
                            appbartitletext: title,
                            customcategoryvalue:
                                '${APIRoute.route}/products/sort?top_sellers=true'))));
                  },
                  child: Text(
                    'Best Sellers',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => GridViewHomePage(
                            appbartitletext: title,
                            customcategoryvalue:
                                '${APIRoute.route}/products/sort?new_arrived=true'))));
                  },
                  child: Text(
                    'New Arrivals',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => GridViewHomePage(
                            appbartitletext: title,
                            customcategoryvalue:
                                '${APIRoute.route}/products/sort?recommanded_product=true'))));
                  },
                  child: Text(
                    'Popularity',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => GridViewHomePage(
                            appbartitletext: title,
                            customcategoryvalue:
                                '${APIRoute.route}/products/sort?fast_moving=true'))));
                  },
                  child: Text(
                    'Fast Moving',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => GridViewHomePage(
                            appbartitletext: title,
                            customcategoryvalue:
                                '${APIRoute.route}/products/sort?history_based=true'))));
                  },
                  child: Text(
                    'History Based',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => GridViewHomePage(
                            appbartitletext: title,
                            customcategoryvalue:
                                '${APIRoute.route}/products/sort?price_low_to_high=true'))));
                  },
                  child: Text(
                    'Price - Low to High',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => GridViewHomePage(
                            appbartitletext: title,
                            customcategoryvalue:
                                '${APIRoute.route}/products/sort?price_high_to_low=true'))));
                  },
                  child: Text(
                    'Price - High to Low',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
