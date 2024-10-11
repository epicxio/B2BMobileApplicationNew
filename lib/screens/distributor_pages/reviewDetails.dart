// import 'package:coswan/utils/lineargradient.dart';
// import 'package:coswan/widgets/ereceiptproduct.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ReviewDetails extends StatelessWidget {
//   final String image;
//   final String title;
//   final String size;
//   final String quantity;
//   final String status;
//   final String price;
//   const ReviewDetails(
//       {super.key,
//       required this.image,
//       required this.title,
//       required this.size,
//       required this.quantity,
//       required this.status,
//       required this.price});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(gradient: gradient),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: Text(
//             'Leave Review',
//             style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
//           ),
//           centerTitle: true,
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//         ),
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               EReceiptProductList(
//                   image: image,
//                   quantity: quantity,
//                   size: quantity,
//                   title: title,
//                   price: price),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Divider(
//                 height: 0.h,
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'How is your Order?',
//                       style: TextStyle(
//                           fontSize: 24.sp, fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                     Text(
//                       'Your overall rating',
//                       style: TextStyle(
//                           color: const Color.fromRGBO(166, 163, 163, 1),
//                           fontSize: 17.sp,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(
//                       height: 30.h,
//                     ),
//                     RatingBarIndicator(
//                       itemPadding: EdgeInsets.symmetric(horizontal: 6.w),
//                       itemCount: 5,
//                       rating: 3.3,
//                       direction: Axis.horizontal,
//                       unratedColor: const Color.fromRGBO(208, 205, 204, 1),
//                       itemSize: 40,
//                       itemBuilder: (context, i) => Icon(
//                         Icons.stars_rounded,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 35.h,
//               ),
//               Divider(
//                 height: 0.h,
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Add detailed review',
//                     style:
//                         TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     height: 12.h,
//                   ),
//                   Container(
//                     width: 385.w,
//                     padding: const EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(3.r),
//                         border: Border.all(
//                             color: const Color.fromRGBO(222, 222, 222, 1))),
//                     child: Text(
//                       'Very nice product 😍 reasonable cost',
//                       style: TextStyle(
//                           fontSize: 14.sp, fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.camera_alt_outlined),
//                       SizedBox(
//                         width: 10.w,
//                       ),
//                       Text(
//                         'Photos',
//                         style: TextStyle(
//                             fontSize: 17.sp, fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(3.r),
//                     child: Image.asset(
//                       'assets/images/LakshmiPicture.png',
//                       height: 90.h,
//                       width: 112.h,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 140.h,
//               ),
//               Center(
//                 child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 50.w, vertical: 8.h)),
//                     child: Text(
//                       'Close',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 17.sp,
//                           fontWeight: FontWeight.w500),
//                     )),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
