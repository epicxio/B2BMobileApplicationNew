import 'package:cached_network_image/cached_network_image.dart';
import 'package:coswan/screens/productdetailspage.dart';
import 'package:coswan/providers/whislist_provider.dart';
import 'package:coswan/services/wishlist_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WhishListPage extends StatefulWidget {
  const WhishListPage({super.key});

  @override
  State<WhishListPage> createState() => _WhishListPageState();
}

class _WhishListPageState extends State<WhishListPage> {
  late WhislistProvider whishlist;
  final txtstyle = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400);
  @override
  void initState() {
    whishlist = Provider.of<WhislistProvider>(context, listen: false);
    WhishlistApi.fetchWhishlistData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<WhislistProvider>(
      context,
    ).listOfwhislist;
    final navigator = Navigator.of(context);
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
              title: const Text(
                'My Wishlist',
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  navigator.pop();
                },
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: favorite.length,
                  itemBuilder: (context, index) {
                    final favourite = favorite[index];
                    return GestureDetector(
                      onTap: () {
                        navigator.push(MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                                  productid: favourite.id,
                                  productimage: favourite.image,
                                  name: favourite.title,
                                  productprice: favourite.variant_price.toString(),
                                  productDescription: favourite.description,
                                  productweight:
                                      favourite.variant_weight.toString(),
                                  wherefrom: 'Home',
                                  parentChildSku: favourite.parentSKU_childSKU,
                                  variantColor: favourite.variant_color,
                                  multiVariants: favourite.multipleVariants,
                                  variantMaterial: favourite.variant_material,
                                  variantSKU: favourite.variant_SKU,
                                  variantSize: favourite.variant_size,
                                  variantStyle: favourite.variant_style,
                                  variantType: favourite.variant_type,
                                  variantqunatityStock: favourite.variant_quantity,
                                )));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        padding:
                            EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                        // EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Row(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(2.r),
                                    // borderRadius: BorderRadius.circular(10.r),
                                    child: CachedNetworkImage(
                                      imageUrl: favourite.image,
                                      height: 120.h,
                                      width: 101.w,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) => ShimmerEffect(
                                          conHeight: 98.h, conWidth: 165.w),
                                    ),
                                   
                                  ),
                                ]),
                            SizedBox(
                              width: 14.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 280.w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 200.w,
                                        
                                        child: Text(
                                          favourite.title,
                                           overflow: TextOverflow.ellipsis,
                                           maxLines: 1,softWrap: true,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.r),
                                        child: GestureDetector(
                                          onTap: () {
                                            removewishlistItem(favourite.id);
                                          },
                                          child: SizedBox(
                                            child: SvgPicture.asset('assets/icons/ic_whislistRemove.svg')
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  'Weight : ${favourite.variant_type == 'single' ? favourite.variant_weight : favourite.multipleVariants[0].variant_weight} gms',
                                  style: txtstyle,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  '₹ ${favourite.variant_type == 'single' ? favourite.variant_price : favourite.multipleVariants[0].variant_price}',
                                  style: txtstyle,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                               
                              ],
                            )
                          ],
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

// to remove the item from the whislist
  Future<void> removewishlistItem(String itemId) async {
    await WhishlistApi.removewishlistItem(context, itemId);
  }
}
