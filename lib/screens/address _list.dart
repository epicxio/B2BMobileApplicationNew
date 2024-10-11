import 'package:coswan/models/address_model.dart';
import 'package:coswan/models/cart_model.dart';
import 'package:coswan/screens/adddeliveryaddress.dart';
import 'package:coswan/services/address_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressList extends StatefulWidget {
  final List<CartModel> checkoutproduct;
  const AddressList({super.key, required this.checkoutproduct});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  String defaultaddress = '';
  bool isloading = true;
  int selectedAddress = -1;
  late List<AddressModel> addressList;
  @override
  void initState() {
    addressListAPI().then((value) {
      setState(() {
        addressList = value;
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
            decoration: const BoxDecoration(gradient: gradient),
            child: Scaffold(
                extendBody: true,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                forceMaterialTransparency: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(
                  'Shipping Address',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              body: isloading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                            Expanded(
                              child: ListView.builder(
                                  itemCount: addressList.length,
                                  itemBuilder: (context, index) {
                                    final listofAddress = addressList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          defaultaddress =
                                              listofAddress.id[index].toString();
                                          selectedAddress = index;
                                          print(selectedAddress);
                                        });
                                      },
                                      child: SizedBox(
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      listofAddress.addressType,
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    SizedBox(
                                                      width: 250.w,
                                                      child: Text(
                                                        '${listofAddress.houseNo} ,${listofAddress.landmark},${listofAddress.state},${listofAddress.city},${listofAddress.pincode}',
                                                        softWrap: true,
                                                        style: TextStyle(
                                                            color: const Color
                                                                .fromRGBO(
                                                                120, 99, 99, 1),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 30.w,
                                                ),
                                                Radio(
                                                    value: index,
                                                    groupValue: selectedAddress,
                                                    onChanged: (Valu) {
                                                      setState(() {
                                                        selectedAddress =
                                                            Valu!.toInt();
                                                        print(selectedAddress);
                                                        defaultaddress =
                                                            listofAddress.id;
        
                                                        print(defaultaddress);
                                                      });
                                                    })
                                              ],
                                            ),
                                            SizedBox(height: 12.h),
                                            Divider(
                                              height: 0.h,
                                              color: const Color.fromRGBO(
                                                  196, 190, 176, 1),
                                            ),
                                            SizedBox(height: 18.h),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => AddDeliveryAddress(
                                                checkoutproduct:
                                                    widget.checkoutproduct,
                                              )));
                                    },
                                    child: DottedBorder(
                                      color: Theme.of(context).primaryColor,
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(5.r),
                                      child: Container(
                                        width: 328.w,
                                        height: 45.h,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50.w, vertical: 10.h),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5.r),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add_circle,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              'Add New Shipping Address',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35.h,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        addressSelectionAPI(
                                            defaultaddress, widget.checkoutproduct);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 40.w, vertical: 10.h),
                                          minimumSize: Size(181.w, 22.h),
                                          backgroundColor:
                                              Theme.of(context).primaryColor),
                                      child: Text(
                                        'Continue to Payment',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500),
                                      ))
                                ],
                              ),
                            ),
                          ]),
                    ),
            )),
      ),
    );
  }

  Future<List<AddressModel>> addressListAPI() async {
    final response = await AddressApi.addressListAPI(context);
    return response;
  }

  Future<void> addressSelectionAPI(
      String defaultaddress, checkoutproduct) async {
    await AddressApi.addressSelectAPI(context, defaultaddress, checkoutproduct);
  }
}
