import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coswan/models/address_model.dart';
import 'package:coswan/models/order_model.dart';
import 'package:coswan/services/order_distributor.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatefulWidget {
  final String cartID;
  final String title;
  final String image;
  final String tobeDone;
  final String pageendPoint;
  final String orderID;
  final String price;
  final String weight;
  final String quantity;
  final String size;
  final AddressModel address;
  final String role;
  final String status;
  final String email;
  final String date;
  final String transactionId;
  final int remainingQuantity ;

  const OrderDetailsPage(
      {super.key,
      required this.cartID,
      required this.title,
      required this.image,
      required this.tobeDone,
      required this.pageendPoint,
      required this.orderID,
      required this.price,
      required this.weight,
      required this.quantity,
      required this.size,
      required this.address,
      required this.status,
      required this.email,
      required this.role,
      required this.remainingQuantity,
      required this.transactionId,
      required this.date});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late List<OrderModel> data;
  late TextEditingController comment;
  List<File>? imagepick = [];
  String statusupdate = '';

  @override
  void initState() {
    comment = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.date);
    final dateOnly = DateFormat('dd-MM-yyyy').format(date);
    final txtstyl1 = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).primaryColor);
    final txtsty2 = TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
    );
    final txtsty = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    );
    const satusBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(130, 130, 130, 1)));
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(gradient: gradient),
          child: Scaffold(
            extendBody: true,
            //   resizeToAvoidBottomInset: false,
            appBar: AppBar(
              forceMaterialTransparency: true,
              title: Text(widget.title),
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios)),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.image,
                          fit: BoxFit.fill,
                          width: 91.w,
                          height: 80.h,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                                style: txtstyl1),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text('₹ ${widget.price}', style: txtstyl1),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Weight : ${widget.weight} grams',
                              style: txtsty2,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Qty: ${widget.quantity} Pcs',
                                  style: txtsty2,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'Size : ${widget.size} MM',
                                  style: txtsty2,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.h),
                      child: Row(
                        children: [
                          Text(
                            'Status',
                            style: txtsty2,
                          ),
                          SizedBox(
                            width: 20.h,
                          ),
                          SizedBox(
                            width: 248.w,
                            height: 35.h,
                            child: widget.status == 'Completed' ||
                                    widget.status == 'Cancelled'
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(widget.status))
                                : DropDownTextField(
                                    clearOption: false,

                                    // padding: EdgeInsets.all(5.w),
                                    listPadding:
                                        ListPadding(top: 10.h, bottom: 10.h),
                                    textFieldDecoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 10.w, bottom: 15.h),
                                        alignLabelWithHint: true,
                                        hintText: 'Select From List ',
                                        hintStyle: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color.fromRGBO(
                                                132, 128, 128, 1)),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none),
                                    searchDecoration: InputDecoration(
                                        floatingLabelStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        focusedBorder: satusBorder,
                                        enabledBorder: satusBorder),
                                    isEnabled: true,
                                    onChanged: (field) {
                                      print(field.value);
                                      setState(() {
                                        statusupdate = field.value;
                                      });
                                    },
                                    dropDownList: [
                                        DropDownValueModel(
                                            name: widget.tobeDone,
                                            value: widget.tobeDone),
                                        const DropDownValueModel(
                                            name: 'Cancelled',
                                            value: 'Cancelled')
                                      ]),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Vendor Information',
                      style: txtstyl1,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Vendor Name : ${widget.address.fullName}',
                      style: txtsty,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Contact Person : ${widget.role}',
                      style: txtsty,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Phone Number : ${widget.address.phoneNumber}',
                      style: txtsty,
                    ),
                    Text(
                      'Email Address : ${widget.email} ',
                      style: txtsty,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Address : ${widget.address.houseNo},${widget.address.roadName},${widget.address.landmark},${widget.address.city},${widget.address.pincode}',
                      style: txtsty,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'Order Information',
                      style: txtstyl1,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Order ID - ${widget.orderID}',
                      style: txtsty,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Product Name : ${widget.title}',
                      style: txtsty,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Quantity : ${widget.quantity}',
                      style: txtsty,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Price : ₹ ${widget.price}',
                      style: txtsty,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Order Date : $dateOnly',
                      style: txtsty,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Order Status : ${widget.status}',
                      style: txtsty,
                    ),
                    Text('RemainingQuantity : ${widget.remainingQuantity}'),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Comment',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      height: 73.h,
                      child: TextFormField(
                        controller: comment,
                        decoration: const InputDecoration(
                            hintText: "Enter the comments here",
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none),
                        maxLines: 5,
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            orderStatusUpdate(widget.cartID, statusupdate,
                                statusupdate, comment.text, widget.quantity);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.r)),
                              backgroundColor: Theme.of(context).primaryColor),
                          child: Text(
                            'Send Message',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 30.r,
                          child: IconButton(
                            onPressed: () {
                              pickImageForStatusUpdate();
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    imagepick!.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 110.h,
                            child: Stack(
                              children: [
                                ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: imagepick!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(3.r),
                                              child: SizedBox(
                                                height: 100.h,
                                                width: 100.w,
                                                child: Image.file(
                                                  imagepick![index],
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            // Positioned(
                                            //     top: -15,
                                            //     right: -15,
                                            //     child: Material(
                                            //       elevation: 4,
                                            //       shape: const CircleBorder(),
                                            //       child: CircleAvatar(
                                            //         radius: 20,
                                            //         backgroundColor:
                                            //             Theme.of(context)
                                            //                 .primaryColor,
                                            //         child: IconButton(
                                            //           icon: const Icon(
                                            //               Icons.clear_outlined,
                                            //               size: 15,
                                            //               color: Colors.white),
                                            //           onPressed: () {},
                                            //         ),
                                            //       ),
                                            //     )),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImageForStatusUpdate() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? selectedImage =
          await imagePicker.pickImage(source: ImageSource.camera);
      if (selectedImage == null) return;
      final tempImage = File(selectedImage.path);
      setState(() {
        imagepick!.add(tempImage);
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> orderStatusUpdate(String cartId, String status, String toastmsg,
      String comment, String variantQuantity) async {
    await OrderDistributor.orderStatusUpdate(
        context,
        cartId,
        status,
        toastmsg,
        widget.pageendPoint,
        comment,
        variantQuantity,
        '0',
        widget.transactionId,
        imagepick != null ? imagepick![0] : null);
  }
}
