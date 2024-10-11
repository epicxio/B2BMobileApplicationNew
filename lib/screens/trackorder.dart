import 'package:coswan/screens/reviewpage.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/widgets/ereceiptproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrackOrder extends StatefulWidget {
  final String image;
  final String title;
  final String size;
  final String quantity;
  final String status;
  final String price;
  final String productId;

  const TrackOrder(
      {super.key,
      required this.image,
      required this.size,
      required this.quantity,
      required this.status,
      required this.title,
      required this.price,
      required this.productId});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  bool isOrderplaced = true;
  bool isInProgress = false;
  bool isShipped = false;
  bool isDelivered = false;

  @override
  Widget build(BuildContext context) {
    statusMethod();

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
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios)),
              title: const Text(
                'Track Order',
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: 100.h,
              child: Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => ReviewPage(
                              image: widget.image,
                              quantity: widget.quantity,
                              size: widget.quantity,
                              title: widget.title,
                              productId: widget.productId,
                              price: widget.price))));
                    },
                    child: Text(
                      'Write a review',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    )),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: EReceiptProductList(
                          image: widget.image,
                          quantity: widget.quantity,
                          size: widget.quantity,
                          title: widget.title,
                          price: widget.price)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    height: 0.h,
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  // Text(
                  //   'Order Details',
                  //   style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  // ),
                  // SizedBox(
                  //   height: 16.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Expected Delivery Date',
                  //       style: TextStyle(
                  //           color: const Color.fromRGBO(149, 146, 146, 1),
                  //           fontSize: 16.sp,
                  //           fontWeight: FontWeight.w500),
                  //     ),
                  //     Text(
                  //       '03-oct-24',
                  //       style:
                  //           TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 12.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Expected Delivery Date',
                  //       style: TextStyle(
                  //           color: const Color.fromRGBO(149, 146, 146, 1),
                  //           fontSize: 16.sp,
                  //           fontWeight: FontWeight.w500),
                  //     ),
                  //     Text(
                  //       'TRK452126542',
                  //       style:
                  //           TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // Divider(
                  //   height: 0.h,
                  // ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    'Order Status',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  TimelineTile(
                    beforeLineStyle: LineStyle(
                        color: isOrderplaced
                            ? Theme.of(context).primaryColor
                            : const Color.fromRGBO(217, 217, 217, 1)),
                    afterLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    indicatorStyle: IndicatorStyle(
                      width: 30.w,
                      color: Theme.of(context).primaryColor,
                      iconStyle: IconStyle(
                          iconData: Icons.check, fontSize: 20, color: Colors.white),
                    ),
                    axis: TimelineAxis.vertical,
                    isFirst: true,
                    endChild: SizedBox(
                      height: 100.h,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Placed',
                                style: TextStyle(
                                    fontSize: 16.sp, fontWeight: FontWeight.w600),
                              ),
                              // SizedBox(
                              //   height: 6.h,
                              // ),
                              // Text(
                              //   '23 Aug 2023, 04:25 PM',
                              //   style: TextStyle(
                              //       color: const Color.fromRGBO(136, 133, 133, 1),
                              //       fontSize: 14.sp,
                              //       fontWeight: FontWeight.w500),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  TimelineTile(
                    beforeLineStyle: LineStyle(
                        color: isInProgress
                            ? Theme.of(context).primaryColor
                            : const Color.fromRGBO(217, 217, 217, 1)),
                    afterLineStyle: LineStyle(
                        color: isInProgress
                            ? Theme.of(context).primaryColor
                            : const Color.fromRGBO(217, 217, 217, 1)),
                    indicatorStyle: IndicatorStyle(
                        width: 30.w,
                        color: isInProgress
                            ? Theme.of(context).primaryColor
                            : const Color.fromRGBO(217, 217, 217, 1),
                        iconStyle: IconStyle(
                            iconData: Icons.check,
                            fontSize: 20,
                            color: Colors.white)),
                    axis: TimelineAxis.vertical,
                    endChild: SizedBox(
                      height: 100.h,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'In Progress',
                                style: TextStyle(
                                    fontSize: 16.sp, fontWeight: FontWeight.w600),
                              ),
                              // SizedBox(
                              //   height: 6.h,
                              // ),
                              // Text(
                              //   '23 Aug 2023, 04:25 PM',
                              //   style: TextStyle(
                              //       color: const Color.fromRGBO(136, 133, 133, 1),
                              //       fontSize: 14.sp,
                              //       fontWeight: FontWeight.w500),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  TimelineTile(
                    beforeLineStyle: LineStyle(
                        color: isShipped
                            ? Theme.of(context).primaryColor
                            : const Color.fromRGBO(217, 217, 217, 1)),
                    afterLineStyle: LineStyle(
                        color: isShipped
                            ? Theme.of(context).primaryColor
                            : const Color.fromRGBO(217, 217, 217, 1)),
                    indicatorStyle: IndicatorStyle(
                      width: 30.w,
                      color: isShipped
                          ? Theme.of(context).primaryColor
                          : const Color.fromRGBO(217, 217, 217, 1),
                      iconStyle: IconStyle(
                          iconData: Icons.check, fontSize: 20, color: Colors.white),
                    ),
                    axis: TimelineAxis.vertical,
                    endChild: SizedBox(
                      height: 100.h,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipped',
                                style: TextStyle(
                                    fontSize: 16.sp, fontWeight: FontWeight.w600),
                              ),
                              // SizedBox(
                              //   height: 6.h,
                              // ),
                              // Text(
                              //   '23 Aug 2023, 04:25 PM',
                              //   style: TextStyle(
                              //       color: const Color.fromRGBO(136, 133, 133, 1),
                              //       fontSize: 14.sp,
                              //       fontWeight: FontWeight.w500),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  TimelineTile(
                    beforeLineStyle: LineStyle(
                        color: isDelivered
                            ? Theme.of(context).primaryColor
                            : const Color.fromRGBO(217, 217, 217, 1)),
                    afterLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    indicatorStyle: IndicatorStyle(
                      width: 30.w,
                      color: isDelivered
                          ? Theme.of(context).primaryColor
                          : const Color.fromRGBO(217, 217, 217, 1),
                      iconStyle: IconStyle(
                          iconData: Icons.check, fontSize: 20, color: Colors.white),
                    ),
                    axis: TimelineAxis.vertical,
                    isLast: true,
                    endChild: SizedBox(
                      height: 100.h,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivered',
                                style: TextStyle(
                                    fontSize: 16.sp, fontWeight: FontWeight.w600),
                              ),
                              // SizedBox(
                              //   height: 6.h,
                              // ),
                              // Text(
                              //   '23 Aug 2023, 04:25 PM',
                              //   style: TextStyle(
                              //       color: const Color.fromRGBO(136, 133, 133, 1),
                              //       fontSize: 14.sp,
                              //       fontWeight: FontWeight.w500),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void statusMethod() {
    if (widget.status == 'Order Submitted') {
      setState(() {
        isOrderplaced = true;
      });
    }

    if (widget.status == 'In-Progress') {
      setState(() {
        isOrderplaced = true;
        isInProgress = true;
      });
    }

    if (widget.status == 'Shipped') {
      setState(() {
        isOrderplaced = true;
        isInProgress = true;
        isShipped = true;
      });
    }
    if (widget.status == 'Completed') {
      setState(() {
        isOrderplaced = true;
        isInProgress = true;
        isShipped = true;
        isDelivered = true;
      });
    }
  }
}
