import 'package:cached_network_image/cached_network_image.dart';
import 'package:coswan/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCartList extends StatelessWidget {
  final String id;
  final String image;
  final String title;
  final String price;
  final String qunatity;
  final String status;

  const OrderCartList(
      {super.key,
      required this.image,
      required this.title,
      required this.price,
      required this.status,
      required this.qunatity,
      required this.id});
  static int totalcount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(206, 148, 56, 1)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.r)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.r),
            child: CachedNetworkImage(
              imageUrl: image,
              width: 84.w,
              height: 90.h,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  ShimmerEffect(conHeight: 98.h, conWidth: 165.w),
            ),

            //  Image.network(loadingBuilder: (contex,child,progress){
            //   if(progress == null) return child;
            //   return Center(
            //     child:   CircularProgressIndicator(
            //     ),
            //   );
            // },
            //     image,
            //     width: 84.w, height: 90.h, fit: BoxFit.fill
            // ),
          ),
          SizedBox(
            width: 15.w,
          ),
          SizedBox(
            height: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Earings',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              // Text(
              //   '₹ $price',
              //   style: TextStyle(
              //     color: const Color.fromRGBO(206, 148, 56, 1),
              //     fontSize: 14.sp,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              Text(
                'Quantity : $qunatity',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp),
              ),
              SizedBox(height: 7.h),
              Text(
                'Approval Status : $status',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
