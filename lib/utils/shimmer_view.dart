import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerView extends StatelessWidget {
  const ShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: gradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            //Color.fromRGBO(245, 220, 196, 1),
            highlightColor: const Color.fromRGBO(254, 253, 251, 1),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 25.h,
                    color: const Color.fromARGB(255, 240, 245, 249),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Container(
                              width: 90.w,
                              height: 90.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.r),
                                color: const Color.fromARGB(255, 240, 245, 249),
                              ),
                            ),
                          );
                        })),
                SizedBox(
                  height: 25.h,
                ),
                SizedBox(
                  height: 120.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.all(10),
                            width: 165.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: const Color.fromARGB(255, 240, 245, 249),
                            ),
                          )),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Expanded(
                    child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 211.w,
                          height: 15.h,
                          color: const Color.fromARGB(255, 240, 245, 249),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          width: 343.w,
                          height: 15.h,
                          color: const Color.fromARGB(255, 240, 245, 249),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          width: 355.w,
                          height: 27.h,
                          color: const Color.fromARGB(255, 240, 245, 249),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 260.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 256.h,
                                      width: 190.w,
                                      color: const Color.fromARGB(
                                          255, 240, 245, 249),
                                    ),
                                  )),
                        ),
                        Container(
                          width: 211.w,
                          height: 15.h,
                          color: const Color.fromARGB(255, 240, 245, 249),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          width: 343.w,
                          height: 15.h,
                          color: const Color.fromARGB(255, 240, 245, 249),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          width: 355.w,
                          height: 27.h,
                          color: const Color.fromARGB(255, 240, 245, 249),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 260.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 256.h,
                                      width: 190.w,
                                      color: const Color.fromARGB(
                                          255, 240, 245, 249),
                                    ),
                                  )),
                        ),
                        Container(
                          width: 211.w,
                          height: 15.h,
                          color: const Color.fromARGB(255, 240, 245, 249),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          width: 343.w,
                          height: 15.h,
                          color: const Color.fromARGB(255, 240, 245, 249),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          width: 355.w,
                          height: 27.h,
                          color: const Color.fromARGB(255, 240, 245, 249),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 260.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 256.h,
                                      width: 190.w,
                                      color: const Color.fromARGB(
                                          255, 240, 245, 249),
                                    ),
                                  )),
                        ),
                      ],
                    )
                  ],
                ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
