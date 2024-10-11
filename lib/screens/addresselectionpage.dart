import 'dart:async';

import 'package:coswan/models/address_model.dart';
import 'package:coswan/models/cart_model.dart';
import 'package:coswan/screens/address%20_list.dart';
import 'package:coswan/screens/paymentscreen.dart';
import 'package:coswan/services/address_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/widgets/ordercartlistcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddresselectionPage extends StatefulWidget {
  final List<CartModel> checkoutproduct;
  const AddresselectionPage({super.key, required this.checkoutproduct});

  @override
  State<AddresselectionPage> createState() => _AddresselectionPageState();
}

class _AddresselectionPageState extends State<AddresselectionPage> {
  late AddressModel checkoutaddress;
  List<String> checkoutProductIds = []; // List to store checkout product IDs

  bool isloading = true;
  @override
  void initState() {
    addressAPI().then((value) {
      setState(() {
        checkoutaddress = value;
        print(checkoutaddress);
        isloading = false;
        print(checkoutaddress);
      });
    });

    /// getting the cartId from checkout product list
    for (var product in widget.checkoutproduct) {
      checkoutProductIds.add(product.id.toString());
    }
    print(checkoutProductIds);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.checkoutproduct);
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
              forceMaterialTransparency: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'My Cart',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            body: isloading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Shipping Address',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 18.h,
                          ),
                          checkoutaddress.id.isEmpty
                              ? ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => AddressList(
                                                checkoutproduct:
                                                    widget.checkoutproduct)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(69.w, 26.h),
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color:
                                                  Color.fromRGBO(145, 142, 142, 1)),
                                          borderRadius:
                                              BorderRadius.circular(30.r))),
                                  child: Text(
                                    'SelectAddress',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500),
                                  ))
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.location_on),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          checkoutaddress.addressType,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SizedBox(
                                              width: 250.w,
                                              child: checkoutaddress.id.isEmpty
                                                  ? SizedBox()
                                                  : Text(
                                                      '${checkoutaddress.houseNo} ,${checkoutaddress.landmark},${checkoutaddress.state},${checkoutaddress.city},${checkoutaddress.pincode}',
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              120, 99, 99, 1),
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                            ), ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushReplacement(MaterialPageRoute(
                                                  builder: (context) => AddressList(
                                                        checkoutproduct:
                                                            widget.checkoutproduct,
                                                      )));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: Size(69.w, 26.h),
                                            elevation: 0,
                                            backgroundColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    color: Color.fromRGBO(
                                                        145, 142, 142, 1)),
                                                borderRadius:
                                                    BorderRadius.circular(30.r))),
                                        child: Text(
                                          'change',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500),
                                        )),

                                          ],
                                        ),
                                      ],
                                    ),
                                    
                                   
                                  ],
                                ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Divider(
                            height: 0.h,
                            color: const Color.fromRGBO(196, 190, 176, 1),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: widget.checkoutproduct.length,
                                itemBuilder: (context, index) {
                                  final checkoutProductIndex =
                                      widget.checkoutproduct[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.h),
                                    child: OrderCartList(
                                      id: checkoutProductIndex.id.toString(),
                                      image: checkoutProductIndex.image.toString(),
                                      title: checkoutProductIndex.title.toString(),
                                      qunatity: checkoutProductIndex
                                          .variant_quantity
                                          .toString(),
                                      price: checkoutProductIndex.variant_price
                                          .toString(),
                                      status:
                                          checkoutProductIndex.status.toString(),
                                    ),
                                  );
                                }),
                          ),
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => PaymentScreen(
                                                addressID: checkoutaddress.id,
                                                cartIds: checkoutProductIds,
                                              )));
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40.w, vertical: 10.h),
                                  minimumSize: Size(181.w, 22.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                                child: Text(
                                  'Continue To Payment',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )),
                          )
                        ]),
                  ),
          ),
        ),
      ),
    );
  }

  Future<AddressModel> addressAPI() async {
    final response = await AddressApi.getCurretAddress(context);
    return response;
  }
}
