import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EReceiptProductList extends StatelessWidget {
  final String image;
  final String size;
  final String title;
  final String quantity;
  final String price;
  const EReceiptProductList(
      {super.key,
      required this.image,
      required this.size,
      required this.quantity,
      required this.title,
      required this.price});

  @override
  Widget build(BuildContext context) {
    final txtstyle2 = TextStyle(
        fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black);
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: CachedNetworkImage(
              imageUrl: image,
              width: 101.w,
              height: 110.h,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          width: 17.w,
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: txtstyle2,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Size : $size',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      width: 66.w,
                    ),
                    Text(
                      'Qty : $quantity Pcs',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    // Text(
                    //   '₹ $price',
                    //   style: TextStyle(
                    //       fontSize: 16.sp,
                    //       fontWeight: FontWeight.w500,
                    //       color: const Color.fromRGBO(188, 144, 14, 1)),
                    // ),
                    SizedBox(
                      width: 40.w,
                    ),
                    // ElevatedButton(
                    //     onPressed: () {},
                    //     style: ElevatedButton.styleFrom(
                    //         backgroundColor: Theme.of(context).primaryColor,
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: 20.w, vertical: 8.h)),
                    //     child: Text(
                    //       ' Return order',
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 16.sp,
                    //           fontWeight: FontWeight.w500),
                    //     ))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
