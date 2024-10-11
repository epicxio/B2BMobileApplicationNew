import 'package:cached_network_image/cached_network_image.dart';
import 'package:coswan/providers/whislist_provider.dart';
import 'package:coswan/services/wishlist_api.dart';
import 'package:coswan/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RelatedProducts extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String price;
  final String gold;

  const RelatedProducts({
    super.key,
     required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.gold,
  });

  @override
  State<RelatedProducts> createState() => _RelatedProductsState();
}

class _RelatedProductsState extends State<RelatedProducts> {
  @override
  Widget build(BuildContext context) {
       final whislist = Provider.of<WhislistProvider>(context);
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5.r)),
        width: 190.w,
        //height: .h,
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.r),
                  topRight: Radius.circular(5.r)
                  ),
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  height: 166.h,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      ShimmerEffect(conHeight: 98.h, conWidth: 165.w),
                ),
              ),
              // Image.network(
              //   loadingBuilder: (context, child, progress) {
              //     if (progress == null) return child;
              //     return Center(
              //       child: Padding(
              //         padding: const EdgeInsets.all(
              //             76.0), // Adjust the padding as needed
              //         child: SizedBox(
              //           height: 20.0, // Specify the height you want
              //           width: 20.0, // Specify the width you want
              //           child: CircularProgressIndicator(),
              //         ),
              //       ),
              //    );
              //   },
              //   image,
              //   height: 166.h,
              //   width: double.infinity,
              //   fit: BoxFit.fill,
              // ),
              SizedBox(
                height: 7.h,
              ),
              // Container(
              //  width: double.infinity,
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     border: Border(
              //       left: BorderSide(color: Theme.of(context).primaryColor),
              //       right: BorderSide(color: Theme.of(context).primaryColor),
              //       bottom: BorderSide(
              //         color: Theme.of(context).primaryColor,
              //       ),
              //     ),
              //     borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(5.r),
              //       bottomRight: Radius.circular(5.r),
              //     )),
              // padding: EdgeInsets.only(left: 15.w, right: 25.w),
              // child:
              Padding(
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
                    // SizedBox(
                    //   height: 4.h,
                    // ),
                    // Text(
                    //   "₹ ${widget.price}",
                    //   style: TextStyle(
                    //     fontSize: 12.sp,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    SizedBox(
                      height: 9.h,
                    ),
                    RatingBarIndicator(
                      itemCount: 5,
                      rating: 3.3,
                      direction: Axis.horizontal,
                      unratedColor: const Color.fromRGBO(208, 205, 204, 1),
                      itemSize: 20,
                      itemBuilder: (context, i) => const Icon(
                        Icons.star,
                        color: Color.fromRGBO(255, 168, 0, 1),
                      ),
                    ),
                  ],
                ),
              ),
              //      )
            ]),
            Positioned(
               top: 1.h,
              right: 1.w,
              child:IconButton(
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
                            : 
                             Icons.favorite_border,
                      );
                    },
                  ),
                  color: Theme.of(context).primaryColor,
                )
            ),
            // Positioned(
            //   bottom: 10.h,
            //   right: 10.w,
            //   child: Icon(
            //     Icons
            //         .shopping_cart_outlined, // Change this to your preferred icon
            //     color: Theme.of(context).primaryColor,
            //   ),
            // ),
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
