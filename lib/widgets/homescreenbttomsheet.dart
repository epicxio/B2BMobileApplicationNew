import 'package:cached_network_image/cached_network_image.dart';
import 'package:coswan/models/category_model.dart';
import 'package:coswan/screens/gridviewhomepage.dart';
import 'package:coswan/utils/route.dart';
import 'package:coswan/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenBottomSheetInFAB extends StatelessWidget {
  final List<CategoryModel> categoryData;
  const HomeScreenBottomSheetInFAB({
    super.key,
    required this.categoryData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding:  EdgeInsets.all(15.w),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(144, 110, 16, 1))),
      child: Column(
        children: [
          SizedBox(
            height: 19.h,
          ),
          Text(
            'Coswan Silver India Find Leading Jewellery \nManufacturers & Wholesalers',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              
              color: const Color.fromRGBO(61, 75, 96, 1),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 100.h,
                    crossAxisSpacing: 5.w,
                    mainAxisSpacing: 8.h,
                    crossAxisCount: 2),
                itemCount: categoryData.length,
                itemBuilder: (context, index) {
                  final data = categoryData[index];
                  return bottomFabChildrens(
                      context, data.categoryImage, data.categoryName);
                }),
          )
          // Row(
          //   children: [
          //     bottomFabChildrens(context, 'assets/images/fabpoojaitem.png'),
          //     SizedBox(
          //       width: 10.w,
          //     ),
          //     bottomFabChildrens(context, 'assets/images/imagefab2.png')
          //   ],
          // ),
          // SizedBox(
          //   height: 11.h,
          // ),
          // Row(
          //   children: [
          //     bottomFabChildrens(context, 'assets/images/imagefab3.png'),
          //     SizedBox(
          //       width: 10.w,
          //     ),
          //     bottomFabChildrens(context, 'assets/images/imagefab4.png')
          //   ],
          // ),
          // SizedBox(
          //   height: 11.h,
          // ),
          // Row(
          //   children: [
          //     bottomFabChildrens(context, 'assets/images/imagefab5.png'),
          //     SizedBox(
          //       width: 10.w,
          //     ),
          //     bottomFabChildrens(context, 'assets/images/imagefab6.png')
          //   ],
          // )
        ],
      ),
    );
  }

  Widget bottomFabChildrens(
      BuildContext context, String imagedata, String titleAndEndpoint) {
    return Container(
      height: 97.h,
      width: 204.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: const Color.fromRGBO(213, 180, 153, 1),
          )),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CachedNetworkImage(
              height: 100.h,
              width: 75.h,
              imageUrl: imagedata,
              fit: BoxFit.fill,
              placeholder: (context, url) => ShimmerEffect(
                conHeight: 80.h,
                conWidth: 75.h,
              ),
              errorWidget: (context, url, error) => ShimmerEffect(
                conHeight: 80.h,
                conWidth: 75.h,
              ),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GridViewHomePage(
                        appbartitletext: titleAndEndpoint,
                        customcategoryvalue:
                            '${APIRoute.route}/products/custom_category?custom_category=$titleAndEndpoint',
                      )));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  'Manufacturers & \nWholesalers',
                  style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8.h,
                ),
                SizedBox(
                  width: 115.w,
                  child: Text('Silver Articles & Jewellery',
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(3.r)),
                  height: 25.h,
                  width: 74.h,
                  child: Center(
                    child: Text(
                      'Search Now',
                      style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }
}
