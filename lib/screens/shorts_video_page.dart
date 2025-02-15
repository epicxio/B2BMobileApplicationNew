import 'package:coswan/models/products_model.dart';
import 'package:coswan/screens/productdetailspage.dart';
import 'package:coswan/services/videos_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/widgets/video_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:expandable_text/expandable_text.dart';

class ShortsVideoPage extends StatefulWidget {
  const ShortsVideoPage({
    super.key,
  });

  @override
  State<ShortsVideoPage> createState() => _ShortsVideoPageState();
}

class _ShortsVideoPageState extends State<ShortsVideoPage> {
  late List<ProductsModel> videodata;
  int snappedPageindex = 0;

  bool dataloading = true;

  @override
  void initState() {
    videoApi().then((value) {
      setState(() {
        videodata = value;
        print(videodata);
        dataloading = false;
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
              body: dataloading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          snappedPageindex = value;
                        });
                      },
                      scrollDirection: Axis.vertical,
                      itemCount: videodata.length,
                      itemBuilder: (context, index) {
                        final shorts = videodata[index];
                        return Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            VideoSlide(
                              video: shorts.videoUrl.toString(),
                              snappedPageIndex: snappedPageindex,
                              currentIndex: index,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height / 4,
                                    //  color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                  radius: 30.r,
                                                  backgroundImage: const AssetImage(
                                                    'assets/images/videoProfile.png',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 45.h,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 15.h,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Coswan Silvers',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ProductDetailsPage(
                                                                    productid: shorts
                                                                        .id
                                                                        .toString(),
                                                                    productimage: shorts
                                                                        .image
                                                                        .toString(),
                                                                    name: shorts
                                                                        .title
                                                                        .toString(),
                                                                    productprice: shorts
                                                                        .variant_price
                                                                        .toString(),
                                                                    productDescription: shorts
                                                                        .description
                                                                        .toString(),
                                                                    variantType: shorts
                                                                        .variant_type,
                                                                    multiVariants:
                                                                        shorts
                                                                            .multipleVariants,
                                                                    productweight: shorts
                                                                        .variant_weight
                                                                        .toString(),
                                                                    wherefrom:
                                                                        'Home',
                                                                    variantColor: shorts
                                                                        .variant_color,
                                                                    variantMaterial:
                                                                        shorts
                                                                            .variant_material,
                                                                    variantSize: shorts
                                                                        .variant_size,
                                                                    variantStyle: shorts
                                                                        .variant_style,
                                                                    variantSKU: shorts
                                                                        .variant_SKU,
                                                                    parentChildSku:
                                                                        shorts
                                                                            .parentSKU_childSKU,
                                                                    variantqunatityStock:
                                                                        shorts
                                                                            .variant_quantity,
                                                                  )));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.r)),
                                                        backgroundColor:
                                                            const Color.fromRGBO(
                                                                178, 144, 50, 1),
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 15.w,
                                                                vertical: 7.h)),
                                                    child: Text(
                                                      'Shop Now',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        SizedBox(
                                          // height: 100.h,
                                          width: 288.w,
                                          child: ExpandableText(
                                            videodata[index].description,
                                            expandText: 'more',
                                            collapseText: 'less',
                                            maxLines: 2,
                                            expandOnTextTap: true,
                                            collapseOnTextTap: true,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  height: 70.h,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Image.asset('assets/icons/ic_comments.png'),
        
                                      // GestureDetector(
                                      //   onTap: () async {
                                      //     print('ddf');
                                      //     // final videoUrl = videodata[index]
                                      //     //         ['videoUrl']
                                      //     //     .toString();
                                      //     // final url = Uri.parse(videoUrl);
                                      //     // final res = await http.get(url);
                                      //     // final bytes = res.bodyBytes;
                                      //     // print('hi');
                                      //     // final temp =
                                      //     //     await getTemporaryDirectory();
                                      //     // final path = '${temp.path}/video.mp4';
                                      //     // File(path).writeAsBytesSync(bytes);
                                      //     // await Share.shareXFiles([XFile(path)],
                                      //     //    subject: 'ToShare');
                                      //   },
                                      //   child: Image.asset(
                                      //       'assets/icons/ic_share.png'),
                                      // ),
                                      // SizedBox(
                                      //   height: 25.h,
                                      // ),
                                      // Image.asset('assets/icons/ic_more.png'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
            )),
      ),
    );
  }

// video api call
  Future<List<ProductsModel>> videoApi() async {
    final response = await ShortsApi.videoApi(context);
    return response;
  }
}
