import 'package:cached_network_image/cached_network_image.dart';
import 'package:coswan/screens/addresselectionpage.dart';
import 'package:coswan/providers/cartprovider.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/services/cart_api.dart';
import 'package:coswan/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartContainer extends StatefulWidget {
  final String cartId;
  final int index;
  final String productId;
  final String image;
  final String title;
  final String price;
  final int qunatity;
  final String weight;
  final String status;
  final String parentSKUchildSKU;
  final String variantSKU;
  const CartContainer({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.qunatity,
    required this.weight,
    required this.status,
    required this.index,
    required this.productId,
    required this.cartId,
    required this.parentSKUchildSKU,
    required this.variantSKU,
  });

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  int totalcount = 0;
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController =
        TextEditingController(text: widget.qunatity.toString());
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    Color determineColor(String status) {
      if (status == 'Approved') {
        return const Color.fromRGBO(4, 160, 29, 1); // Green
      } else if (status == 'Declined') {
        return const Color.fromRGBO(255, 0, 0, 1); // Red
      } else if (status == 'Pending') {
        return const Color.fromRGBO(255, 204, 0, 1); // Yellow
      } else {
        return const Color.fromRGBO(
            128, 128, 128, 1); // Default gray for unknown statuses
      }
    }

    final cart = Provider.of<CartProvider>(context).cart;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      
     
      width: 402.w,
      child: Column(
         mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  fit: BoxFit.fill,
                  width: 110.w,
                height: 192.h,
                  placeholder: (context, url) =>
                      ShimmerEffect(conHeight: 98.h, conWidth: 165.w),
                ),
              ),
              SizedBox(
                width: 15.h,
              ),
              SizedBox(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    SizedBox(
                      width: 210.w,
                      child: Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 11.h),
                    Text(
                      'Gross Weight :${widget.weight} grams',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(51, 51, 51, 1)),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        user.role == "Store Owner"
                            ? SizedBox()
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.w),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  color: determineColor(widget
                                      .status), // Use the function to get the color
                                ),
                                child: Text(
                                  widget.status,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.r),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor)),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (int.parse(textEditingController.text) >
                                        1) {
                                      int total =
                                          int.parse(textEditingController.text);
                                      total -= 1;

                                      textEditingController.text =
                                          total.toString();
                                      user.role == "Store Owner"
                                          ? storeOwnerUpdateForHisCart(
                                              widget.cartId,
                                              textEditingController.text)
                                          : null;
                                    } else {
                                      textEditingController.text = 1.toString();
                                    }
                                  });
                                },
                                child: Icon(Icons.remove_circle_outline_sharp,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Expanded(
                                // height: 20.h,
                                // width: 50.w,
                                child: TextFormField(
                                  ///  initialValue: widget.qunatity.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      //   totalcount = int.parse(value);
                                      //  print(totalcount);
                                      textEditingController.text =
                                          int.parse(value).toString();
                                    });

                                    print(totalcount);
                                  },
                                  onFieldSubmitted: (value) {
                                    user.role == "Store Owner"
                                        ? storeOwnerUpdateForHisCart(
                                            widget.cartId,
                                            textEditingController.text)
                                        : null;
                                    if (value.isEmpty) {
                                      setState(() {
                                        textEditingController.text = '1';
                                      });
                                    }
                                  },

                                  textAlign: TextAlign.center,
                                  controller: textEditingController,

                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 7.w),
                                    border: const OutlineInputBorder(
                                  
                                      borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    int total =
                                        int.parse(textEditingController.text);
                                    total += 1;
                                    textEditingController.text =
                                        total.toString();
                                    user.role == "Store Owner"
                                        ? storeOwnerUpdateForHisCart(
                                            widget.cartId,
                                            textEditingController.text)
                                        : null;
                                  });
                                },
                                child: Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          '${textEditingController.text} Items Selected',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: (widget.status != 'Approved')
                                ? null
                                : () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddresselectionPage(
                                                    checkoutproduct: [
                                                      cart[widget.index]
                                                    ])));
                                  },
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(96.w, 28.h),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 5.h),
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            child: Text(
                              'Buy Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                        SizedBox(
                          width: 10.w,
                        ),
                        user.role == 'Store Owner'
                            ? SizedBox()
                            : ElevatedButton(
                                onPressed: (widget.qunatity.toString() !=
                                        textEditingController.text)
                                    ? () {
                                        print(widget.qunatity);
                                        print(textEditingController.text);
                                        purchaseManagerUpdate(
                                            widget.cartId,
                                            widget.productId,
                                            textEditingController.text,
                                            widget.parentSKUchildSKU,
                                            widget.variantSKU);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(164.w, 28.h),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.r)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 5.h),
                                    backgroundColor:
                                        Theme.of(context).primaryColor),
                                child: Text(
                                  'Send For Approval',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                      ],
                    ),
                  ]))
            ],
          ),
        ],
      ),
    );
  }
// store owner cart  update

  Future<void> storeOwnerUpdateForHisCart(
      String cartId, String quantity) async {
    await CartAPI.storeOwnerUpdateForHisCart(context, cartId, quantity);
  }

// purchase manager update for his cart quantity product
  Future<void> purchaseManagerUpdate(String id, String productId,
      String quantity, String parentSKUchildSKU, String variantSKU) async {
    await CartAPI.purchaseManagerUpdate(
        context, id, productId, quantity, parentSKUchildSKU, variantSKU);
  }
}
