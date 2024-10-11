import 'package:coswan/screens/addcard.dart';
import 'package:coswan/screens/couponpage.dart';
import 'package:coswan/services/order_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentScreen extends StatefulWidget {
  final String addressID;
  final List cartIds;
  const PaymentScreen(
      {super.key,
      //  required this.checkoutproduct,
      required this.addressID,
      required this.cartIds});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedPayment = -1;
  String method = '';
  @override
  Widget build(BuildContext context) {
    final containerDecoration = BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color.fromRGBO(183, 181, 181, 1)),
      borderRadius: BorderRadius.circular(3.r),
    );
    final txtstyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
    );
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
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Payment Methods',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Credit & Debit Card',
                    style: txtstyle,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const AddCard()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 45.h,
                      decoration: containerDecoration,
                      child: Row(
                        children: [
                          Image.asset('assets/icons/ic_creditCart.png'),
                          SizedBox(
                            width: 16.w,
                          ),
                          Text(
                            'Add Card',
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 18,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Offers for you',
                        style: txtstyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CouponPageView()));
                        },
                        child: Text(
                          'View All Promo Code',
                          style: TextStyle(
                              color: const Color.fromRGBO(178, 144, 50, 1),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 45.h,
                    decoration: containerDecoration,
                    child: Row(
                      children: [
                        Image.asset('assets/icons/ic_discount.png'),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'COUPON30OFF',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'More Payment Options',
                    style: txtstyle,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  paymentList('assets/icons/ic_paytm.png', 25, 'Paytm', 0),
                  SizedBox(
                    height: 15.h,
                  ),
                  paymentList('assets/icons/ic_gpay.png', 25, 'Google Pay', 1),
                  SizedBox(
                    height: 15.h,
                  ),
                  paymentList('assets/icons/ic_cashOndelivery.png', 25,
                      'Cash on Delivery', 2),
                  SizedBox(
                    height: 15.h,
                  ),
                  morePaymentList('assets/icons/ic_offline.png', 25, 'Offline', 3),
                 
                  const   Spacer(
                          flex: 1,
                        ),
                  Center(
                    child: ElevatedButton(
                        // order apito buy the product
                        onPressed: method.isEmpty ? null : () {
                          orderAPI(method, widget.cartIds, widget.addressID);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 10.h),
                            minimumSize: Size(154.w, 42.h),
                            backgroundColor: Theme.of(context).primaryColor),
                        child: Text(
                          'Continue to Payment',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentList(
      String paymentIcon, int width, String title, int radioval) {
    final txtstyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    );
    return Container(
      padding: const EdgeInsets.all(10),
      height: 55.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromRGBO(183, 181, 181, 1)),
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Row(
        children: [
          Image.asset(paymentIcon),
          SizedBox(
            width: width.w,
          ),
          Text(
            title,
            style: txtstyle,
          ),
        ],
      ),
    );
  }

  Widget morePaymentList(
      String paymentIcon, int width, String title, int radioval) {
    final txtstyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    );
    return Container(
      padding: const EdgeInsets.all(10),
      height: 55.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromRGBO(183, 181, 181, 1)),
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Row(
        children: [
          Image.asset(paymentIcon),
          SizedBox(
            width: width.w,
          ),
          Text(
            title,
            style: txtstyle,
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Radio(
                  value: radioval,
                  groupValue: selectedPayment,
                  onChanged: (valu) {
                    setState(() {
                      selectedPayment = valu!;
                      method = 'offline';
                      print(selectedPayment);
                      print(widget.cartIds);
                      print(widget.addressID);
                      print(method);
                    });
                  }),
            ],
          ))
        ],
      ),
    );
  }

  Future<void> orderAPI(String payment, List cartIds, String addressID) async {
    await OrderApi.orderAPI(context, payment, cartIds, addressID);
  }
}
