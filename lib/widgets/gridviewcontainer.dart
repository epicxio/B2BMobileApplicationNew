import 'package:cached_network_image/cached_network_image.dart';
import 'package:coswan/models/multivariant_model.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/providers/whislist_provider.dart';
import 'package:coswan/services/cart_api.dart';
import 'package:coswan/services/wishlist_api.dart';
import 'package:coswan/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GridViewContainer extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String? price;
  final String? weight;
  final String variantType;
  final List<MultivariantModel>? multiVariants;
  final String? variantSize;
  final String? variantColor;
  final String? variantStyle;
  final String? variantMaterial;
  final String? variantPrice;
  final String variantSKU;
  final String parentChildSKU;
  final String variantqunatityStock;

  const GridViewContainer(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.weight,
      required this.id,
      required this.variantType,
      required this.multiVariants,
      required this.variantSize,
      required this.variantStyle,
      required this.variantqunatityStock,
      required this.variantColor,
      required this.variantMaterial,
      required this.variantPrice,
      required this.variantSKU,
      required this.parentChildSKU});

  @override
  State<GridViewContainer> createState() => _GridViewContainerState();
}

class _GridViewContainerState extends State<GridViewContainer> {
  int totalcount = 1;
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController(text: totalcount.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final whislist = Provider.of<WhislistProvider>(context);

    // final cart = Provider.of<CartProvider>(context);
    // final wishlistItem = whislist.listOfwhislist.firstWhere(
    //     (element) => element['productId'] == widget.id,
    //     orElse: () => {'_id': ''});

    // String whislistId = wishlistItem['productId']!.toString();

    // final cartItem = cart.cart.firstWhere(
    //     (element) => element['productId'] == widget.id,
    //     orElse: () => {'quantity': 1});

    // int total = cartItem['quantity'];
    // quantity = total;

    return Card(
      elevation: 10,
      //   color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: Theme.of(context).primaryColor)),
        width: 190.w,
        height: 285.h,
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.r),
                  topRight: Radius.circular(5.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  height: 167.h,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      ShimmerEffect(conHeight: 98.h, conWidth: 165.w),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: 15.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(children: [
                      widget.variantType == 'single'
                          ? int.parse(textEditingController.text) <
                                  int.parse(widget.variantqunatityStock!)
                              ? Text(
                                  "In Stock",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(13, 165, 28, 1),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Text(
                                  "Out Of Stock",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                          : int.parse(textEditingController.text) <
                                  (widget.multiVariants![0].variant_quantity)
                              ? Text(
                                  "In Stock",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(13, 165, 28, 1),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Text(
                                  "Out of Stock",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        '( ${widget.variantType == 'single' ? widget.variantqunatityStock : widget.multiVariants![0].variant_quantity} )',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                    SizedBox(
                      height: 14.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 35.h,
                          width: 98.w,
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
                                    if (int.parse(textEditingController.text) >=
                                        1) {
                                      int total =
                                          int.parse(textEditingController.text);
                                      total -= 1;
                                      textEditingController.text =
                                          total.toString();
                                    } else {
                                      textEditingController.text = 1.toString();
                                    }
                                  });
                                },
                                child: Icon(Icons.remove_circle_outline_sharp,
                                    size: 30,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Expanded(
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      //   totalcount = int.parse(value);
                                      //  print(totalcount);
                                      textEditingController.text =
                                          int.parse(value).toString();
                                    });
                                    print(totalcount);
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
                                  });
                                },
                                child: Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: Theme.of(context).primaryColor,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 7.w,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]),
            Positioned(
                bottom: 8.h,
                right: 2.w,
                child: ElevatedButton(
                    onPressed: () {
                      sendForApproval(
                          context,
                          user.role == 'Store Owner'
                              ? 'add-to-cart'
                              : 'sendForApproval',
                          textEditingController.text,
                          widget.id,
                          widget.variantType,
                          widget.variantType == 'single'
                              ? widget.variantSize!
                              : widget.multiVariants![0].variant_size,
                          widget.variantType == 'single'
                              ? widget.variantStyle!
                              : widget.multiVariants![0].variant_style,
                          widget.variantType == 'single'
                              ? widget.variantMaterial!
                              : widget.multiVariants![0].variant_material,
                          widget.variantType == 'single'
                              ? widget.variantColor!
                              : widget.multiVariants![0].variant_color,
                          widget.variantType == 'single'
                              ? widget.weight!
                              : widget.multiVariants![0].variant_weight
                                  .toString(),
                          widget.variantType == 'single'
                              ? widget.price!
                              : widget.multiVariants![0].variant_price
                                  .toString(),
                          widget.variantType == 'single'
                              ? widget.variantSKU!
                              : widget.multiVariants![0].variant_SKU,
                          widget.variantType == 'single'
                              ? ''
                              : widget.multiVariants![0].parentSKU_childSKU);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.all(0),
                      fixedSize: Size(75.w, 25.h),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                    ))),
            Positioned(
              top: 2.h,
              right: 2.w,
              child: CircleAvatar(
                // radius: 18.r,
                backgroundColor: Colors.white,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      whislist.listOfwhislist
                              .any((product) => product.id == widget.id)
                          ? removewishlistItem(widget.id)
                          : whislistAPI(widget.id);
                    },
                    icon: Consumer<WhislistProvider>(
                      builder: (context, whislistprovider, ch) {
                        return Icon(
                          whislist.listOfwhislist
                                  .any((product) => product.id == widget.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                        );
                      },
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // to send the item to add as favourite
  Future<void> whislistAPI(String itemId) async {
    await WhishlistApi.whislistAPI(context, itemId);
  }

// to remove the item from the whislist
  Future<void> removewishlistItem(String itemId) async {
    await WhishlistApi.removewishlistItem(context, itemId);
  }

  // send for approval and add to cart
  Future<void> sendForApproval(
      BuildContext context,
      String endval,
      dynamic totalcount,
      String productid,
      String variantType,
      String variantSize,
      String variantStyle,
      String variantMaterial,
      String variantColor,
      String variantWeight,
      String variantPrice,
      String variantSKU,
      String parentChildSKU) async {
    await CartAPI.sendForApproval(
        context,
        endval,
        totalcount,
        productid,
        variantType,
        variantSize,
        variantStyle,
        variantMaterial,
        variantColor,
        variantWeight,
        variantPrice,
        variantSKU,
        parentChildSKU);
  }
}
