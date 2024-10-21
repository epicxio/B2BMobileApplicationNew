import 'package:coswan/screens/distributor_pages/bottombardistributor.dart';
import 'package:coswan/screens/distributor_pages/month_graph.dart';
import 'package:coswan/screens/distributor_pages/orderstatustabbar.dart';
import 'package:coswan/screens/distributor_pages/week_graph.dart';
import 'package:coswan/screens/distributor_pages/year_graph.dart';
import 'package:coswan/screens/notifiactionview.dart';
import 'package:coswan/providers/notificatiion_provider.dart';
import 'package:coswan/services/distributor_dashboard_api.dart';
import 'package:coswan/services/fcm_update_api.dart';
import 'package:coswan/services/notification_api.dart';
import 'package:coswan/services/push_notification_service.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/widgets/homepagesdrawer.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DashboradDistribtor extends StatefulWidget {
  const DashboradDistribtor({super.key});

  @override
  State<DashboradDistribtor> createState() => _DashboradDistribtorState();
}

late Map<String, dynamic> usersCount;
late Map<String, dynamic> revenueCount;
late Map<String, dynamic> ordersCount;
late Map<String, dynamic> productsCount;
late Map<dynamic, dynamic> weekdata;
late Map<dynamic, dynamic> monthdata;
late Map<dynamic, dynamic> yeardata;
late Map<String, dynamic> orderStatusCount;

class _DashboradDistribtorState extends State<DashboradDistribtor> {
  String selectedGraph = 'week';
  String selectedType = '';
  late TextEditingController searchFieldEditor;
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(3.r)),
    borderSide: const BorderSide(
      color: Color.fromRGBO(203, 213, 225, 1),
    ),
  );
  bool isloading = true;
  @override
  void initState() {
    searchFieldEditor = TextEditingController();
    final pushNotificationService = PushNotificationService();
    // push notification service
    pushNotificationService.initNotificationPermission();
    pushNotificationService.firebaseinitwhileAppActiveState(context);
    pushNotificationService.setInteractMsg(context);
    // pushNotificationService.tokenRefresh();
    pushNotificationService.getFCMToken().then((value) {
      print(value);
    });
    fetchInitData();

    super.initState();
  }

  @override
  void dispose() {
    searchFieldEditor.dispose();
    super.dispose();
  }

  DateTime? lastPressed;
  void onexitFromHome() {
    DateTime now = DateTime.now();
    if (lastPressed == null ||
        now.difference(lastPressed!) > const Duration(seconds: 3)) {
      lastPressed = now;
      Fluttertoast.showToast(
        msg: "Press back again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(gradient: gradient),
          child: PopScope(
            canPop: false,
            onPopInvoked: (didpop) {
              onexitFromHome();
            },
            child: Scaffold(
              extendBody: true,
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                forceMaterialTransparency: true,
                elevation: 0,
                title: const Text('Coswan Silvers'),
                backgroundColor: Colors.transparent,
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderStatusTabBar()));
                    },
                    child: const Icon(Icons.shopping_cart_outlined),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  GestureDetector(onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const NotificationViewScreen())));
                  }, child: Consumer<NotificationDataProvider>(
                      builder: (context, notification, ch) {
                    return Provider.of<NotificationDataProvider>(context)
                                .notificationCount >
                            0
                        ? Badge(
                            backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
                            label: Text(
                                '${Provider.of<NotificationDataProvider>(context).notificationCount}'),
                            child: const Icon(Icons.notifications_outlined))
                        : const Icon(Icons.notifications_outlined);
                  })),
                  SizedBox(
                    width: 20.w,
                  )
                ],
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              ),
              drawer: const HomePageDrawer(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: SizedBox(
                height: 80.h,
                width: 80.w,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(50.r)),
                  onPressed: () {},
                  child: Image.asset('assets/icons/ic_distributorFAB.png'),
                ),
              ),
              bottomNavigationBar: const BottomBarDistributor(),
              body: isloading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      child: RefreshIndicator(
                        onRefresh: refresh,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  _buildContainer(
                                      'assets/icons/ic_revenue.png',
                                      'Total Revenue',
                                      revenueCount['totalRevenue'].toString()),
                                  SizedBox(
                                    width: 40.h,
                                  ),
                                  _buildContainer(
                                      'assets/icons/ic_graphincrease.png',
                                      'Total Products',
                                      productsCount['count'].toString()),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                children: [
                                  _buildContainer(
                                      'assets/icons/ic_orderD.png',
                                      'Total.of.orders',
                                      ordersCount['orderCount'].toString()),
                                  SizedBox(
                                    width: 40.h,
                                  ),
                                  _buildContainer(
                                      'assets/icons/ic_vendoruser.png',
                                      'No.of.users',
                                      usersCount['uniqueStoreOwnerCount']
                                          .toString()),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OrderStatusTabBar()));
                                    },
                                    child: _buildContainer(
                                        'assets/icons/ic_orderD.png',
                                        'Orders In New',
                                        orderStatusCount['order-submitted']
                                            .toString()),
                                  ),
                                  SizedBox(
                                    width: 40.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OrderStatusTabBar()));
                                    },
                                    child: _buildContainer(
                                        'assets/icons/ic_orderD.png',
                                        'In-Progress',
                                        orderStatusCount["In-Progress"]
                                            .toString()),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OrderStatusTabBar()));
                                    },
                                    child: _buildContainer(
                                        'assets/icons/ic_orderD.png',
                                        'Shipped',
                                        orderStatusCount['Shipped'].toString()),
                                  ),
                                  SizedBox(
                                    width: 40.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OrderStatusTabBar()));
                                    },
                                    child: _buildContainer(
                                        'assets/icons/ic_orderD.png',
                                        'Completed',
                                        orderStatusCount['Completed'].toString()),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                height: 450.h,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sales Overview',
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        FittedBox(
                                          child: SizedBox(
                                            height: 40.h,
                                            width: 150.w,
                                            child: DropDownTextField(
                                                clearOption: false,
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.w400),
                                                textFieldDecoration:
                                                    InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        contentPadding:
                                                            const EdgeInsets.all(
                                                                10),
                                                        enabledBorder: border,
                                                        focusedBorder: border,
                                                        hintText: 'This Week'),
                                                onChanged: (value) {
                                                  if (value.value == 'month') {
                                                    setState(() {
                                                      monthgraphcall();
                                                      selectedGraph = value.value;
                                                    });
                                                  }
                                                  if (value.value == 'week') {
                                                    setState(() {
                                                      weekgraphcall(
                                                          "api/graph/completed-order-counts?type=week");
                                                      selectedGraph = value.value;
                                                    });
                                                  }
                                                  if (value.value == 'year') {
                                                    setState(() {
                                                      yeargraphcall();
                                                      selectedGraph = value.value;
                                                    });
                                                  }
                                                },
                                                listTextStyle: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                                dropDownList: const [
                                                  DropDownValueModel(
                                                      name: 'This week',
                                                      value: 'week'),
                                                  DropDownValueModel(
                                                      name: 'This month',
                                                      value: 'month'),
                                                  DropDownValueModel(
                                                      name: 'This year',
                                                      value: 'year'),
                                                ]),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    SizedBox(height: 350.h, child: _buildGraph()),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(String imageurl, String name, String count) {
    return Container(
      width: 172.w,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(5.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imageurl),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                count,
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 14.h,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.arrow_upward_sharp,
                    color: Color.fromRGBO(210, 159, 73, 1),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    '56%',
                    style: TextStyle(
                        color: const Color.fromRGBO(210, 159, 73, 1),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _choicechip(String title, String category) {
    return ChoiceChip(
      showCheckmark: false,
      label: Text(
        title,
        style: TextStyle(
            color: selectedType == category ? Colors.white : Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      disabledColor: Colors.white,
      selectedColor: Theme.of(context).primaryColor,
      selected: selectedType == category,
      onSelected: (boolVal) {
        setState(() {
          if (boolVal) {
            selectedType = category;
            print(selectedType);
          }
        });
      },
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color.fromRGBO(189, 189, 189, 1)),
          borderRadius: BorderRadius.circular(30.r)),
    );
  }

Future<void> refresh() async {
  setState(() {
    isloading = true;
  });
   fetchInitData();
}
  void fetchInitData() async {
    orderStatusCount = await DistributorDashboardAPI.ordersCountAPI(context);
    usersCount = await DistributorDashboardAPI.dasboardCount(
        context, 'unique_user_count');
    weekdata = await DistributorDashboardAPI.WeekgraphAPI(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
    NotificationAPI.notificationApi(context);
    ordersCount =
        await DistributorDashboardAPI.dasboardCount(context, 'order_count');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
    revenueCount =
        await DistributorDashboardAPI.dasboardCount(context, 'total-revenue');
    monthgraphcall();
    yeargraphcall();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
    productsCount =
        await DistributorDashboardAPI.dasboardCount(context, 'products-count');

    isloading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
    FcmUpdateAPI.fcmUpdateAPI(context);
  }

  //api call for dashboard grid view
  Widget _buildGraph() {
    switch (selectedGraph) {
      case 'month':
        return monthdata.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              ) //
            : MonthGraph(graphdata: monthdata);
      case 'year':
        return yeardata.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : YearGraph(graphdata: yeardata);
      case 'week':
      default:
        return weekdata.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : WeekGraph(graphdata: weekdata);
    }
  }

  // graph call
  void weekgraphcall(String endpoint) async {
    weekdata = await DistributorDashboardAPI.WeekgraphAPI(
      context,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void monthgraphcall() async {
    DateTime dateTime = DateTime.now(); // Get the current date and time
    int year = dateTime.year;
    int month = dateTime.month;

    monthdata = await DistributorDashboardAPI.monthgraphAPI(
        context, month.toString(), year.toString());

    setState(() {});
  }

  void yeargraphcall() async {
    DateTime dateTime = DateTime.now(); // Get the current date and time
    int year = dateTime.year;

    yeardata =
        await DistributorDashboardAPI.yeargraphAPI(context, year.toString());
    setState(() {});
  }
}
