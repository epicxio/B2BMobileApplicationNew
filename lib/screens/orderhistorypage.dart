import 'package:coswan/models/order_model.dart';
import 'package:coswan/screens/trackorder.dart';
import 'package:coswan/services/order_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/widgets/orderhistory_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  bool isloading = true;
  List<OrderModel>? orderHistorydata = [];

  @override
  void initState() {
    orderHistoryAPI().then((value) {
      setState(() {
        orderHistorydata = value;
        print(value);
        isloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            gradient: gradient,
          ),
          child: Scaffold(
             extendBody: true,
            resizeToAvoidBottomInset: false,

            appBar: AppBar(
              forceMaterialTransparency: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Order History',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              actions: [
                SizedBox(
                  width: 23.h,
                )
              ],
            ),

            backgroundColor: Colors.transparent,
            body: isloading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : orderHistorydata!.isEmpty
                    ? Center(child: Text('No Orders Found'))
                    : RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.builder(
                          itemCount: orderHistorydata!.length,
                          itemBuilder: (context, index) {
                            final orderHistory = orderHistorydata![index];
                      
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 14.w),
                                child: SizedBox(
                                  // height: 210.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TrackOrder(
                                                    image: orderHistory.image,
                                                    quantity: orderHistory
                                                        .variant_quantity
                                                        .toString(),
                                                    size: orderHistory
                                                        .variant_size
                                                        .toString(),
                                                    status: orderHistory.status,
                                                    title: orderHistory.title,
                                                    price: orderHistory
                                                        .variant_price
                                                        .toString(),
                                                    productId:
                                                        orderHistory.productId,
                                                  )));
                                    },
                                    child: OrderHistoryContainer(
                                      orderId: orderHistory.order_Id.toString(),
                                      index: index,
                                      productId:
                                          orderHistory.productId.toString(),
                                      image: orderHistory.image.toString(),
                                      price:
                                          orderHistory.variant_price.toString(),
                                      qunatity: orderHistory.variant_quantity,
                                      status: orderHistory.status.toString(),
                                      title: orderHistory.title.toString(),
                                      weight:
                                          orderHistory.variant_weight.toString(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
          ),
        ),
      ),
    );
  }

// order history api call
  Future orderHistoryAPI() async {
    final response = await OrderApi.orderHistoryAPI(context);
    return response;
  }
  Future<void> _refresh() async  {
    isloading = true;
    setState(() {
        
    });
    orderHistoryAPI().then((value) {
      setState(() {
        orderHistorydata = value;
        print(value);
        isloading = false;
      });
    });
  }
}
