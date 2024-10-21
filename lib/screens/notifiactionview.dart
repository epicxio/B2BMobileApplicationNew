import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coswan/models/notification_model.dart';
import 'package:coswan/providers/notificatiion_provider.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/screens/cartpage.dart';
import 'package:coswan/screens/distributor_pages/orderstatustabbar.dart';
import 'package:coswan/screens/orderhistorypage.dart';
import 'package:coswan/screens/productdetailspage.dart';
import 'package:coswan/services/notification_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationViewScreen extends StatefulWidget {
  const NotificationViewScreen({super.key});

  @override
  State<NotificationViewScreen> createState() => _NotificationViewScreenState();
}

class _NotificationViewScreenState extends State<NotificationViewScreen> {
  bool isloading = true;
  late List<NotificationModel> notificationData;

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    final user = Provider.of<UserProvider>(context, listen: false).user;
    // final List<NotificationModel> notificationData =
    //     notification.notificationData;
    return Consumer<NotificationDataProvider>(
        builder: (context, notification, child) {
           final notificationProvider =
        Provider.of<NotificationDataProvider>(context);
      return Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          bottom: false,
          child: Container(
            decoration: const BoxDecoration(gradient: gradient),
            child: PopScope(
              canPop: true,
              onPopInvokedWithResult: (didpop, result) {
                notification.clearCount();
                // print('returned');
              },
              child: Scaffold(
                extendBody: true,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  forceMaterialTransparency: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: const Text(
                    'Notifications',
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  actions: [
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 8.h),
                        padding: EdgeInsets.only(
                            left: 20.w, right: 20.w, top: 5.h, bottom: 5.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(30.r),
                          color: const Color.fromRGBO(210, 159, 73, 1),
                        ),
                        child: Text(
                          '${notificationProvider.notificationCount} New',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.sp),
                        ))
                  ],
                ),
                body: SafeArea(
                    child: isloading
                        ? const Center(child: CircularProgressIndicator())
                        : RefreshIndicator(
                            triggerMode: RefreshIndicatorTriggerMode.anywhere,
                            onRefresh: _refresh,
                            child: ListView.builder(
                                itemCount: notificationData.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: user.role == 'Store Owner'
                                        ? storeOwnerListtiles(
                                            index, notificationData)
                                        : purchaseManagerListtiles(
                                            index, notificationData),
                                  );
                                }),
                          )),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget storeOwnerListtiles(int index, List<NotificationModel> notification) {
    // final notification =
    //     Provider.of<NotificationProvider>(context, listen: true);
    final dataofNotification = notification[index];
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

    String createdAtString = dataofNotification.createdAt;

    // Parse the string into a DateTime object
    DateTime dateTime = DateTime.parse(createdAtString);

    // Format the DateTime object to get the time

    DateTime now = DateTime.now();
    bool isToday = now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year;
    // Format the DateTime object to display the date if it's not today
    String formattedDate =
        isToday ? 'Today' : DateFormat('dd-MMM-yyyy').format(dateTime);

//    return
    // Consumer<NotificationProvider>(
    //   builder: (context, notification, child) {
    //     final dataofNotification = notification.notificationData [index];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 12.h),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3.r),
                child: CachedNetworkImage(
                  imageUrl: dataofNotification.image.toString(),
                  width: 70.w,
                  height: 90.h,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      ShimmerEffect(conHeight: 98.h, conWidth: 165.w),
                ),
              ),
              SizedBox(
                width: 8.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 300.w,
                        child: Text(
                          dataofNotification.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 22.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Row(
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Quantity : ${dataofNotification.variant_quantity}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      dataofNotification.approvalStatus != 'Pending'
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 10.w),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                color: determineBackgroundColor(dataofNotification
                                    .approvalStatus), // Use the function to get the color
                              ),
                              child: Text(
                                (dataofNotification.approvalStatus),
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                              ),
                            )
                          : const SizedBox()
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          SizedBox(
            width: 350.w,
            child: Text(
              dataofNotification.receiverMessage,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          dataofNotification.approvalStatus != 'Pending'
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          final res = await productAccepAPI(
                              dataofNotification.cartId,
                              dataofNotification.productId,
                              dataofNotification.variant_quantity.toString(),
                              'decline',
                              dataofNotification.variant_SKU,
                              dataofNotification.parentSKU_childSKU,
                              index,
                              dataofNotification.variantType,
                              'Product declined Successfully');
                          if (res.statusCode == 200) {
                            notificationData.removeAt(index);
                            setState(() {});
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 8.h),
                            backgroundColor:
                                const Color.fromRGBO(252, 111, 111, 1)),
                        child: Text(
                          'Reject',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        )),
                    ElevatedButton(
                        onPressed: () async {
                          final res = await productAccepAPI(
                              dataofNotification.cartId,
                              dataofNotification.productId,
                              dataofNotification.variant_quantity.toString(),
                              'approval',
                              dataofNotification.variant_SKU,
                              dataofNotification.parentSKU_childSKU,
                              index,
                              dataofNotification.variantType,
                              'Product Accepted Successfully');

                          if (res.statusCode == 200) {
                            setState(() {
                              notificationData.removeAt(index);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 8.h),
                            backgroundColor: Theme.of(context).primaryColor),
                        child: Text(
                          'Accept',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(
                                    variantqunatityStock:
                                        dataofNotification.product_quantity,
                                    productid:
                                        dataofNotification.productId.toString(),
                                    productimage:
                                        dataofNotification.image.toString(),
                                    name: dataofNotification.title.toString(),
                                    productprice: dataofNotification
                                        .variant_price
                                        .toString(),
                                    productDescription: dataofNotification
                                        .description
                                        .toString(),
                                    productweight: dataofNotification
                                        .variant_weight
                                        .toString(),
                                    wherefrom: 'Notification',
                                    cartIdFromNotification:
                                        dataofNotification.cartId.toString(),
                                    quantityFromNotification: dataofNotification
                                        .variant_quantity
                                        .toString(),
                                    variantType: dataofNotification.variantType
                                        .toString(),
                                    variantColor: dataofNotification
                                        .variant_color
                                        .toString(),
                                    variantMaterial: dataofNotification
                                        .variant_material
                                        .toString(),
                                    variantSKU: dataofNotification.variant_SKU
                                        .toString(),
                                    variantSize: dataofNotification.variant_size
                                        .toString(),
                                    variantStyle: dataofNotification
                                        .variant_style
                                        .toString(),
                                    parentChildSku: dataofNotification
                                        .parentSKU_childSKU
                                        .toString(),
                                  )));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(30.r)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 8.h),
                            backgroundColor: Colors.white),
                        child: Text(
                          'View More',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ))
                  ],
                )
        ],
      ),
      //    );
      //    },
    );
  }

//// purchse manager notification tile
  Widget purchaseManagerListtiles(
      int index, List<NotificationModel> notification) {
    final user = Provider.of<UserProvider>(context).user;
    // final notification =
    //     Provider.of<NotificationProvider>(context, listen: true);
    // final notificationData = notification.notificationData;
    final dataofNotification = notification[index];
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
          return const Color.fromRGBO(40, 167, 69, 1); // Default grey
      }
    }

    String createdAtString = dataofNotification.createdAt;
    print(createdAtString);

    // Parse the string into a DateTime object
    DateTime dateTime = DateTime.parse(createdAtString);

    // Format the DateTime object to get the time

    DateTime now = DateTime.now();
    bool isToday = now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year;
    // Format the DateTime object to display the date if it's not today
    String formattedDate =
        isToday ? 'Today' : DateFormat('dd-MMM-yyyy').format(dateTime);

    // Duration difference = now.difference(dateTime);

//     String formattedTimeAgo = '';

// // Calculate the difference in hours

//     if (difference.inSeconds < 60) {
//       formattedTimeAgo = '${difference.inSeconds} seconds ago';
//     } else if (difference.inMinutes < 60) {
//       formattedTimeAgo = '${difference.inMinutes} minutes ago';
//     } else {
//       formattedTimeAgo = '${difference.inHours} hours ago';
//     }

//Format the DateTime object to display the time
    //    String formattedTime = DateFormat.jm().format(createdAt);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3.r),
                child: CachedNetworkImage(
                  imageUrl: dataofNotification.image.toString(),
                  width: 61.w,
                  height: 59.h,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      ShimmerEffect(conHeight: 98.h, conWidth: 165.w),
                  errorWidget: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/coswanlogo.png',
                      height: 74.h,
                      width: 83.w,
                    );
                  },
                ),
              ),
              SizedBox(
                width: 8.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 300.w,
                          child: Text(
                            dataofNotification.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 22.sp, fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quantity : ${dataofNotification.variant_quantity}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 70.w,
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r)),
                        // color: const Color.fromRGBO(4, 160, 29, 1),
                        color: determineBackgroundColor(dataofNotification
                            .approvalStatus) // Red for declined
                        ),
                    child: Text(
                      dataofNotification.approvalStatus,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          SizedBox(
            width: 350.w,
            child: Text(
              dataofNotification.receiverMessage,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: () {
                  user.role == 'Purchase Manager'
                      ? dataofNotification.approvalStatus == 'Pending' ||
                              dataofNotification.approvalStatus == 'Declined' ||
                              dataofNotification.approvalStatus == 'Approved'
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => const CartPage()),
                              ),
                            )
                          : Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) =>
                                    const OrderHistoryPage()),
                              ),
                            )
                      : Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => const OrderStatusTabBar()),
                          ),
                        );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(3.r)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    backgroundColor: Theme.of(context).primaryColor),
                child: Text(
                  user.role == "Purchase Manager"
                      ? dataofNotification.approvalStatus == 'Pending' ||
                              dataofNotification.approvalStatus == 'Declined' ||
                              dataofNotification.approvalStatus == 'Approved'
                          ? 'View Cart'
                          : 'View Order'
                      : 'View Order',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                )),
          )
        ],
      ),
    );
  }

  Future<Response> productAccepAPI(
      String cartId,
      productId,
      quantity,
      endPoint,
      String variantSku,
      String parentChildSku,
      index,
      String variantType,
      String toast) async {
    final res = await NotificationAPI.productAcceptAndDeclineAPI(
        context,
        cartId,
        productId,
        quantity,
        endPoint,
        variantSku,
        parentChildSku,
        index,
        variantType,
        toast);
    if (res.statusCode == 200) {
      setState(() {});
    }
    return res;
  }

  Future _refresh() async {
    setState(() {
      isloading = true;
    });
    notificationData = await NotificationAPI.notificationApi(context);

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      isloading = !isloading;
    });
  }
}
