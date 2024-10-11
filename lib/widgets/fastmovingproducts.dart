import 'package:cached_network_image/cached_network_image.dart';
import 'package:coswan/providers/whislist_provider.dart';
import 'package:coswan/services/wishlist_api.dart';
import 'package:coswan/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FastMovingProducts extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String price;
  final String weight;

  // final String variantType;
  // final List<MultivariantModel> multiVariants;

  const FastMovingProducts({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.weight,
    required this.id,
  });

  @override
  State<FastMovingProducts> createState() => _FastMovingProductsState();
}

class _FastMovingProductsState extends State<FastMovingProducts> {
  int quantity = 1;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    final whislist = Provider.of<WhislistProvider>(context);
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
        height: 265.h,
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
                padding: EdgeInsets.only(left: 15.w, right: 25.w),
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
                    Text(
                      'Weight:${widget.weight.toString()} gm',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    // Text(
                    //   "₹ ${widget.price.toString()}",
                    //   style: TextStyle(
                    //     fontSize: 12.sp,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                  ],
                ),
              )
            ]),
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
                )),
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
}
