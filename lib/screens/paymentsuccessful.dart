import 'package:coswan/screens/e_receipt.dart';
import 'package:coswan/screens/homepage.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSucessful extends StatelessWidget {
  final List<String> orderid;
  final List<String> transactionId;
  const PaymentSucessful({
    super.key,
    required this.orderid,
    required this.transactionId,
  });

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
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              forceMaterialTransparency: true,
              title: Text(
                'Payment',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 100.h),
              child: Center(
                  child: Column(
                children: [
                  Image.asset('assets/icons/ic_paymentsuccessTick.png'),
                  SizedBox(
                    height: 23.h,
                  ),
                  Text(
                    'Order Successful !',
                    style:
                        TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Thank you for your purchase.',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 210.h,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(238.w, 50.h),
                          backgroundColor: Theme.of(context).primaryColor),
                      child: Text(
                        'Order Again',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                    height: 30.h,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EReceipt(
                                  orderid: orderid,
                                  transactionId: transactionId,
                                )));
                      },
                      child: Text(
                        'E-Receipt',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 17.sp, fontWeight: FontWeight.w600),
                      )),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
