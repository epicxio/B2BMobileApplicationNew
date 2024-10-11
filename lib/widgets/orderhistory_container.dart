import 'package:cached_network_image/cached_network_image.dart';
import 'package:coswan/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHistoryContainer extends StatefulWidget {
  final int index;
  final String productId;
  final String image;
  final String title;
  final String price;
  final int qunatity;
  final String weight;
  final String status;
  final String orderId;
  const OrderHistoryContainer(
      {super.key,
      required this.image,
      required this.title,
      required this.price,
      required this.qunatity,
      required this.weight,
      required this.status,
      required this.index,
      required this.productId,
      required this.orderId});

  @override
  State<OrderHistoryContainer> createState() => _OrderHistoryContainerState();
}

class _OrderHistoryContainerState extends State<OrderHistoryContainer> {
  int totalcount = 0;
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController =
        TextEditingController(text: widget.qunatity.toString());
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String determineOrder(String status) {
      if (status == 'order-submitted') {
        return 'Order Submitted';
      } else {
        return status;
      }
    }

    Color determineBackgroundColor(String status) {
      switch (status) {
        case 'Completed':
          return const Color.fromRGBO(40, 167, 69, 1); // Green
        case 'Shipped':
          return const Color.fromRGBO(0, 123, 255, 1); // Blue
        case 'In-Progress':
          return const Color.fromRGBO(253, 126, 20, 1); // Orange
        case 'Hold':
          return const Color.fromRGBO(255, 193, 7, 1); // Yellow
        case 'Cancelled':
          return const Color.fromRGBO(220, 53, 69, 1); // Red
        case 'Pending':
          return const Color.fromRGBO(108, 117, 125, 1); // Grey
        case 'Declined':
          return const Color.fromRGBO(255, 0, 0, 1); // Red
        case 'order-submitted':
          return const Color.fromRGBO(4, 160, 29, 1); // Green
        default:
          return const Color.fromRGBO(128, 128, 128, 1); // Default grey
      }
    }

    Color determineTextColor(String status) {
      switch (status) {
        case 'Completed':
        case 'Shipped':
        case 'In-Progress':
        case 'Cancelled':
        case 'Pending':
        case 'order-submitted':
          return const Color.fromRGBO(255, 255, 255, 1); // White
        case 'Hold':
          return const Color.fromRGBO(0, 0, 0, 1); // Black
        default:
          return const Color.fromRGBO(255, 255, 255, 1); // Default white
      }
    }

    // textEditingController.text= totalcount.toString();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
      // padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 8.h),
      // margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      // height: 210.h,
      width: 402.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  width: 84.w,
                  height: 150.h,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      ShimmerEffect(conHeight: 98.h, conWidth: 165.w),
                ),
              ),
              SizedBox(
                width: 15.h,
              ),
              SizedBox(
                  child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 11.h),
                      Text(
                        'Gross Weight :${widget.weight} grams',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.qunatity} Items Ordered',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            'Order Id :${widget.orderId}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 10.w),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                          color: determineBackgroundColor(widget
                              .status), // Use the function to get the color
                        ),
                        child: Text(
                          determineOrder(widget.status),
                          textAlign: TextAlign.center,
                          // style: const TextStyle(color: Colors.white),
                          style: TextStyle(
                              color: determineTextColor(widget.status)),
                        ),
                      ),
                    ]),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
