import 'package:coswan/providers/distributor_order_provider.dart';
import 'package:coswan/screens/distributor_pages/orderstatuscontainer.dart';
import 'package:coswan/services/order_distributor.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrderStatusTabBar extends StatefulWidget {
  const OrderStatusTabBar({super.key});

  @override
  State<OrderStatusTabBar> createState() => _OrderStatusTabBarState();
}

class _OrderStatusTabBarState extends State<OrderStatusTabBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  // late List<OrderModel> shipped;
  // //late List<Map<String, dynamic>> hold;
  // late List<OrderModel> completed;
  // late List<OrderModel> cancelled;
  // late List<OrderModel> inProgress;
  bool isloading = true;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(_handleTabSelection);
    fetchDataInit();
    super.initState();
  }

  @override
  void dispose() {
    tabController.removeListener(_handleTabSelection);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderDistributor = Provider.of<DistributorOrderProvider>(
      context,
    );
    return Container(
      decoration: const BoxDecoration(gradient: gradient),
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios)),
          title: const Text(
            'My Orders',
          ),
          bottom: TabBar(
              automaticIndicatorColorAdjustment: true,

              controller: tabController,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              isScrollable: true,
             tabAlignment: TabAlignment.start,
              onTap: (index) {
                if (index == 1) {
                  orderStatus('In-Progress');
                } else if (index == 2) {
                  orderStatus('Shipped');
                } else if (index == 3) {
                  orderStatus('Completed');
                } else if (index == 4) {
                  orderStatus('Cancelled');
                } else {
                  orderStatus('order-submitted');
                }
              },
              labelPadding: EdgeInsets.symmetric(horizontal: 6.w),
              tabs: [
                Tab(
                  child: Text(
                    'New',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'In-Progress',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Shipped',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Cancelled',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ]),
        ),
        body: orderDistributor.dataloading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(

                controller: tabController,
                children: const [
                  OrderStatusContainer(
                    pageendPoint: 'order-submitted',
                    statusvalue: 'In-Progress',
                  ),
                  OrderStatusContainer(
                    pageendPoint: 'In-Progress',
                    statusvalue: 'Shipped',
                  ),
                  OrderStatusContainer(
                    pageendPoint: 'Shipped',
                    statusvalue: 'Completed',
                  ),
                  OrderStatusContainer(
                    pageendPoint: 'Completed',
                    statusvalue: 'completed',
                  ),
                  OrderStatusContainer(
                    pageendPoint: 'Cancelled',
                    statusvalue: 'cancelled',
                  ),
                ],
              ),
      ),
    );
  }

  void fetchDataInit() async {
    if (isloading) {
      orderStatus('order-submitted');

      if (mounted) {
        setState(() {
          isloading = false;
        });
      }

      // inProgress = await orderStatus('In-Progress');
      // setState(() {});

      // shipped = await orderStatus('Shipped');
      // setState(() {});

      // completed = await orderStatus('Completed');
      // setState(() {});

      // cancelled = await orderStatus('Cancelled');
    }
  }

  //order status
  Future<void> orderStatus(String endPoint) async {
    await OrderDistributor.orderStatus(context, endPoint);
  }

  void _handleTabSelection() {
    if (!tabController.indexIsChanging) {
      switch (tabController.index) {
        case 0:
          orderStatus('order-submitted');
          break;
        case 1:
          orderStatus('In-Progress');
          break;
        case 2:
          orderStatus('Shipped');
          break;
        case 3:
          orderStatus('Completed');
          break;
        case 4:
          orderStatus('Cancelled');
          break;
      }
    }
  }
}
