import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coswan/models/banner_carousel.dart';
import 'package:coswan/models/category_model.dart';
import 'package:coswan/models/products_model.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/screens/whislist.dart';
import 'package:coswan/providers/cartprovider.dart';
import 'package:coswan/screens/cartpage.dart';
import 'package:coswan/screens/notifiactionview.dart';
import 'package:coswan/screens/productdetailspage.dart';
import 'package:coswan/providers/notificatiion_provider.dart';
import 'package:coswan/providers/whislist_provider.dart';
import 'package:coswan/services/cart_api.dart';
import 'package:coswan/services/fcm_update_api.dart';
import 'package:coswan/services/home_page_product_api.dart';
import 'package:coswan/services/notification_api.dart';
import 'package:coswan/services/push_notification_service.dart';
import 'package:coswan/services/wishlist_api.dart';
import 'package:coswan/utils/route.dart';
import 'package:coswan/utils/shimmer_view.dart';
import 'package:coswan/widgets/bottombar.dart';
import 'package:coswan/widgets/homepagesdrawer.dart';
import 'package:coswan/widgets/homescreenbttomsheet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coswan/widgets/fastmovingproducts.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/screens/gridviewhomepage.dart';
import 'package:coswan/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  late TextEditingController searchfieldEditor;
  late List<ProductsModel> basedonHistorydata;
  late List<ProductsModel> fastmovingdata;
  late List<ProductsModel> topSellersdata;
  late List<ProductsModel> recommededForYoudata;
  late List<BannerCarouselModel> carouselSliderdata;
  late List<CategoryModel> categoryData;
  int bottombarIndex = 0;
  bool dataloading = true;
  Timer? timer;
  // late List<Map<String, dynamic>> productdata;
  late final ScrollController _scrollController2;
  late final ScrollController _scrollController;
  late final ScrollController _scrollController3;
  late final ScrollController _scrollController4;
  //bool _drawerOpen = false;
  final List<String> carouselimage = [];
  int fastMovingIndex = 0;
  int carouselIndex = 0;
  int basedonhistory = 0;
  int recommnedeindex = 0;
  int topsellersindex = 0;
  bool isdraweropen = false;
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(3.r)),
    borderSide: const BorderSide(
      color: Color.fromRGBO(203, 213, 225, 1),
    ),
  );
  // firebase analytics
  @override
  void initState() {
    fetchDataInit();
    final pushNotificationService = PushNotificationService();
    // push notification service
    pushNotificationService.initNotificationPermission();
    pushNotificationService.firebaseinitwhileAppActiveState(context);
    pushNotificationService.setInteractMsg(context);
    // pushNotificationService.tokenRefresh();
    pushNotificationService.getFCMToken().then((value) {
      print(value);
    });
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

// scroll controllers are used to controll the listview builder offset  i.e used to move the dot indicator
    _scrollController = ScrollController();
    _scrollController2 = ScrollController();
    _scrollController3 = ScrollController();
    _scrollController4 = ScrollController();
    // Add listeners to scroll controllers
    _scrollController.addListener(_updateFastMovingIndex);
    _scrollController2.addListener(_updateBasedOnHistory);
    _scrollController3.addListener(_updateRecommendedIndex);
    _scrollController4.addListener(_updateTopSellersIndex);

    // to set the analytics collection true
    analytics.setAnalyticsCollectionEnabled(true);
    searchfieldEditor = TextEditingController();
    FcmUpdateAPI.fcmUpdateAPI(context);
    super.initState();
  }

  @override
  void dispose() {
    searchfieldEditor.dispose();
    _scrollController.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    _scrollController4.dispose();

    super.dispose();
  }

  void _updateFastMovingIndex() {
    if (mounted) {
      setState(() {
        fastMovingIndex = (_scrollController.offset / 150.0).round();
      });
    }
  }

  void _updateBasedOnHistory() {
    if (mounted) {
      setState(() {
        basedonhistory = (_scrollController2.offset / 150.0).round();
      });
    }
  }

  void _updateRecommendedIndex() {
    if (mounted) {
      setState(() {
        recommnedeindex = (_scrollController3.offset / 150.0).round();
      });
    }
  }

  void _updateTopSellersIndex() {
    if (mounted) {
      setState(() {
        topsellersindex = (_scrollController4.offset / 150.0).round();
      });
    }
  }

  void onTapChanged(int newIndex) {
    setState(() {
      bottombarIndex = newIndex;
    });
  }

// double to exit

  DateTime? lastTimePressed;
  void onexitFromHome() {
    DateTime now = DateTime.now();
    if (lastTimePressed == null ||
        now.difference(lastTimePressed!) > const Duration(seconds: 3)) {
      lastTimePressed = now;
      Fluttertoast.showToast(
        msg: "Press back again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) {
        onexitFromHome();
      },
      child: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          bottom: false,
          child: Container(
            decoration: const BoxDecoration(gradient: gradient),
            child: Scaffold(
                extendBody: true,
              //  extendBodyBehindAppBar: true,
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,

              // appbar
              appBar: AppBar(
                elevation: 1,
                forceMaterialTransparency: true,
                backgroundColor: Colors.transparent,
                title: SizedBox(
                  height:
                      34, // search field for the user to find the particular products
                  child: TextField(
                    controller: searchfieldEditor,
                    onSubmitted: (textvalue) {
                      if (textvalue.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GridViewHomePage(
                                    appbartitletext: searchfieldEditor.text,
                                    customcategoryvalue:
                                        '${APIRoute.route}/products/search?query=${searchfieldEditor.text}')));
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {
                          analytics.logEvent(
                            name: 'Search history',
                            parameters: {
                              'usedID': user.id,
                              'text': searchfieldEditor.text
                            },
                          );
                          if (searchfieldEditor.text.isNotEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GridViewHomePage(
                                        appbartitletext: searchfieldEditor.text,
                                        customcategoryvalue:
                                            '${APIRoute.route}/products/search?query=${searchfieldEditor.text}')));
                          }
                        },
                        icon: const Icon(Icons.search),
                      ),
                      contentPadding: const EdgeInsets.all(5),
                      hintText: 'Search for Jewellery',
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: border,
                      enabledBorder: border,
                      prefixIconColor: Theme.of(context).primaryColor,
                      suffixIconColor: Theme.of(context).primaryColor,
                      suffixIconConstraints:
                          BoxConstraints.tight(const Size(60, 34)),
                    ),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                actions: [
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WhishListPage()));
                    },
                    child: Consumer<WhislistProvider>(
                        builder: (context, wishlist, ch) {
                      return wishlist.listOfwhislist.isNotEmpty
                          ? Badge(
                              label: Text('${wishlist.listOfwhislist.length}'),
                              backgroundColor: Theme.of(context).primaryColor,
                              child: const Icon(Icons.favorite_border),
                            )
                          : const Icon(Icons.favorite_border);
                    }),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartPage()));
                  }, child:
                      Consumer<CartProvider>(builder: (context, cartModal, ch) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      setState(() {});
                    });

                    return cartModal.cart.isNotEmpty
                        ? Badge(
                            backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
                            label: Text('${cartModal.cart.length}'),
                            child: const Icon(Icons.shopping_cart_outlined),
                          )
                        : const Icon(Icons.shopping_cart_outlined);
                  })),
                  SizedBox(
                    width: 14.w,
                  ),
                  GestureDetector(onTap: () {
                    //   APIRoute().triggerNotificaton();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const NotificationView())));
                  }, child: Consumer<NotificationProvider>(
                      builder: (context, notification, ch) {
                    return Provider.of<NotificationProvider>(context)
                                .notificationCount >
                            0
                        ? Badge(
                            backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
                            label: Text(
                                '${Provider.of<NotificationProvider>(context).notificationCount}'),
                            child: const Icon(Icons.notifications_outlined))
                        : const Icon(Icons.notifications_outlined);
                  })),
                  SizedBox(
                    width: 24.w,
                  )
                ],
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              ),
              //drawer of the sideview
              drawer: const HomePageDrawer(),

              //Floating action button to display the bottom sheet
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: SizedBox(
                width: 79.h,
                height: 79.h,
                child: FloatingActionButton(
                  onPressed: () {
                    // showPopover(
                    //     context: context,
                    //     bodyBuilder: (context) => HomeScreenBottomSheetInFAB());
                    showModalBottomSheet(
                      constraints: BoxConstraints(maxHeight: 520.h),
                      context: context,
                      builder: (context) {
                        return HomeScreenBottomSheetInFAB(
                          categoryData: categoryData,
                        );
                      },
                    );
                  },
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Image.asset('assets/images/floatbtnimage.png'),
                ),
              ),

              // bottom Navigation bar is from the widgets folder
              bottomNavigationBar: BottomBarWidgetpage(
                index: bottombarIndex,
                onTapChanged: onTapChanged,
              ),
              body: SafeArea(
                child: dataloading
                    ? const ShimmerView()
                    : RefreshIndicator(
                        triggerMode: RefreshIndicatorTriggerMode.anywhere,
                        onRefresh: onRefresh,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width - 20,
                                height: 112.h,
                                child: //custom_catoegory u
                                    ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: categoryData.length,
                                        itemBuilder: (context, index) {
                                          final data = categoryData[index];
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: customCategory(
                                                data.categoryImage.toString(),
                                                data.categoryName,
                                                context,
                                                data.categoryName),
                                          );
                                        })
                                // customCategory(
                                //     'assets/images/Ring.jpg', "Rings", context, "ring"),
                                // customCategory('assets/images/Necklace.jpg', "Necklace",
                                //     context, "chain"),
                                // customCategory('assets/images/pooja.png',
                                //     "Pooja items", context, "poojaitems"),

                                ),
                            SizedBox(
                              height: 25.h,
                            ),
                            CarouselSlider(
                              // carouselController:  ,         //carosuel slider of the home page
                              items: generateImagetiles(),

                              options: CarouselOptions(
                                  enableInfiniteScroll: true,
                                  viewportFraction: 1,
                                  autoPlayCurve: Curves.linear,
                                  enlargeCenterPage: false,
                                  height: 160.h,
                                  autoPlay: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      carouselIndex = index;
                                    });
                                  }),
                            ),

                            // Center(
                            //   child: AnimatedSmoothIndicator(
                            //     activeIndex: carouselIndex,
                            //     count: generateImagetiles().length,
                            //     effect: SwapEffect(
                            //       radius: 10.r,
                            //       activeDotColor:
                            //           Theme.of(context).primaryColor,
                            //       dotColor: const Color.fromRGBO(
                            //           255, 255, 255, 1),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Fast Moving Products",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  'Check out of the products that our customers  love the most',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 11.h,
                                ),
                                SizedBox(
                                  width: 354.w,
                                  child:
                                      Image.asset('assets/images/divider.png'),
                                ),

                                //fast moving products and the list  view builder here
                                SizedBox(
                                    height: 250.h,
                                    child: ListView.builder(
                                      padding: EdgeInsets.only(
                                          left: 15.w, right: 15.w),
                                      controller: _scrollController,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: fastmovingdata.length,
                                      itemBuilder: (context, index) {
                                        final fastmoving =
                                            fastmovingdata[index];
                                        return GestureDetector(
                                          onTap: () {
                                            analytics.logEvent(
                                              name: 'View Product',
                                              parameters: {
                                                'usedID': user.id,
                                                'productId': fastmoving.id,
                                                'title': fastmoving.title
                                              },
                                            );
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailsPage(
                                                          productid: fastmoving
                                                              .id
                                                              .toString(),
                                                          productimage:
                                                              fastmoving.image
                                                                  .toString(),
                                                          name: fastmoving.title
                                                              .toString(),
                                                          productprice:
                                                              fastmoving
                                                                  .variant_price
                                                                  .toString(),
                                                          productDescription:
                                                              fastmoving
                                                                  .description
                                                                  .toString(),
                                                          productweight:
                                                              fastmoving
                                                                  .variant_weight
                                                                  .toString(),
                                                          variantType:
                                                              fastmoving
                                                                  .variant_type,
                                                          multiVariants: fastmoving
                                                              .multipleVariants,
                                                          wherefrom: 'Home',
                                                          variantColor:
                                                              fastmoving
                                                                  .variant_color,
                                                          variantMaterial:
                                                              fastmoving
                                                                  .variant_material,
                                                          variantSize:
                                                              fastmoving
                                                                  .variant_size,
                                                          variantStyle:
                                                              fastmoving
                                                                  .variant_style,
                                                          variantSKU: fastmoving
                                                              .variant_SKU,
                                                          parentChildSku: fastmoving
                                                              .parentSKU_childSKU,
                                                          variantqunatityStock:
                                                              fastmoving
                                                                  .variant_quantity,
                                                        )));
                                          },
                                          child: FastMovingProducts(
                                            id: fastmoving.id.toString(),
                                            image: fastmoving.image.toString(),
                                            name: fastmoving.title.toString(),
                                            price: fastmoving.variant_type ==
                                                    'single'
                                                ? fastmoving.variant_price
                                                    .toString()
                                                : fastmoving.multipleVariants[0]
                                                    .variant_price
                                                    .toString(),
                                            weight: fastmoving.variant_type ==
                                                    'single'
                                                ? fastmoving.variant_weight
                                                    .toString()
                                                : fastmoving.multipleVariants[0]
                                                    .variant_weight
                                                    .toString(),
                                          ),
                                        );
                                      },
                                    )),
                                SizedBox(
                                  height: 16.h,
                                ),
                                AnimatedSmoothIndicator(
                                  activeIndex: fastMovingIndex,
                                  count: fastmovingdata.length,
                                  effect: SwapEffect(
                                      activeDotColor:
                                          Theme.of(context).primaryColor),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                Text(
                                  "Based on History",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  'Check out of the products that suits you best',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 11.h,
                                ),
                                SizedBox(
                                  width: 354.w,
                                  child:
                                      Image.asset('assets/images/divider.png'),
                                ),
                                SizedBox(
                                  //based on history list view builder here
                                  height: 250.h,
                                  child: ListView.builder(
                                      padding: EdgeInsets.only(
                                          left: 15.w, right: 15.w),
                                      controller: _scrollController2,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: basedonHistorydata.length,
                                      itemBuilder: (context, index) {
                                        final history =
                                            basedonHistorydata[index];
                                        return GestureDetector(
                                          onTap: () {
                                            analytics.logEvent(
                                              name: 'View Product',
                                              parameters: {
                                                'usedID': user.id,
                                                'productId': history.id,
                                                'title': history.title
                                              },
                                            );
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        ProductDetailsPage(
                                                          productid: history.id
                                                              .toString(),
                                                          productimage: history
                                                              .image
                                                              .toString(),
                                                          name: history.title
                                                              .toString(),
                                                          productprice: history
                                                              .variant_price
                                                              .toString(),
                                                          productDescription:
                                                              history
                                                                  .description
                                                                  .toString(),
                                                          variantType: history
                                                              .variant_type,
                                                          multiVariants: history
                                                              .multipleVariants,
                                                          productweight: history
                                                              .variant_weight
                                                              .toString(),
                                                          wherefrom: 'Home',
                                                          variantColor: history
                                                              .variant_color,
                                                          variantMaterial: history
                                                              .variant_material,
                                                          variantSize: history
                                                              .variant_size,
                                                          variantStyle: history
                                                              .variant_style,
                                                          variantSKU: history
                                                              .variant_SKU,
                                                          parentChildSku: history
                                                              .parentSKU_childSKU,
                                                          variantqunatityStock:
                                                              history
                                                                  .variant_quantity,
                                                        ))));
                                          },
                                          child: FastMovingProducts(
                                            id: history.id.toString(),
                                            image: history.image.toString(),
                                            name: history.title.toString(),
                                            price:
                                                history.variant_type == 'single'
                                                    ? history.variant_price
                                                        .toString()
                                                    : history
                                                        .multipleVariants[0]
                                                        .variant_price
                                                        .toString(),
                                            weight: history.variant_type ==
                                                    'single'
                                                ? history.variant_weight
                                                    .toString()
                                                : history.multipleVariants[0]
                                                    .variant_weight
                                                    .toString(),
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                AnimatedSmoothIndicator(
                                  activeIndex: basedonhistory,
                                  effect: SwapEffect(
                                      activeDotColor:
                                          Theme.of(context).primaryColor),
                                  count: basedonHistorydata.length,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  "Recommended For You", //recommended  for you products and the list  view builder here
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  'Check out of the products that our customers  love the most',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 11.h,
                                ),
                                SizedBox(
                                  width: 354.w,
                                  child:
                                      Image.asset('assets/images/divider.png'),
                                ),
                                SizedBox(
                                  height: 250.h,
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(
                                        left: 15.w, right: 15.w),
                                    controller: _scrollController3,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: recommededForYoudata.length,
                                    itemBuilder: (context, index) {
                                      final recommended =
                                          recommededForYoudata[index];
                                      return GestureDetector(
                                        onTap: () {
                                          analytics.logEvent(
                                            name: 'View Product',
                                            parameters: {
                                              'usedID': user.id,
                                              'productId': recommended.id,
                                              'title': recommended.title
                                            },
                                          );
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailsPage(
                                                productid:
                                                    recommended.id.toString(),
                                                productimage: recommended.image
                                                    .toString(),
                                                name: recommended.title
                                                    .toString(),
                                                productprice: recommended
                                                    .variant_price
                                                    .toString(),
                                                variantType:
                                                    recommended.variant_type,
                                                multiVariants: recommended
                                                    .multipleVariants,
                                                productDescription: recommended
                                                    .description
                                                    .toString(),
                                                productweight: recommended
                                                    .variant_weight
                                                    .toString(),
                                                wherefrom: 'Home',
                                                variantColor:
                                                    recommended.variant_color,
                                                variantMaterial: recommended
                                                    .variant_material,
                                                variantSize:
                                                    recommended.variant_size,
                                                variantStyle:
                                                    recommended.variant_style,
                                                variantSKU:
                                                    recommended.variant_SKU,
                                                parentChildSku: recommended
                                                    .parentSKU_childSKU,
                                                variantqunatityStock:
                                                    recommended
                                                        .variant_quantity,
                                              ),
                                            ),
                                          );
                                        },
                                        child: FastMovingProducts(
                                          id: recommended.id.toString(),
                                          image: recommended.image.toString(),
                                          name: recommended.title.toString(),
                                          price: recommended.variant_type ==
                                                  'single'
                                              ? recommended.variant_price
                                                  .toString()
                                              : recommended.multipleVariants[0]
                                                  .variant_price
                                                  .toString(),
                                          weight: recommended.variant_type ==
                                                  'single'
                                              ? recommended.variant_weight
                                                  .toString()
                                              : recommended.multipleVariants[0]
                                                  .variant_weight
                                                  .toString(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                AnimatedSmoothIndicator(
                                  activeIndex: recommnedeindex,
                                  count: recommededForYoudata.length,
                                  effect: SwapEffect(
                                      activeDotColor:
                                          Theme.of(context).primaryColor),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  "Top Sellers",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  'Check out of the products that our customers  love the most',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 11.h,
                                ),
                                SizedBox(
                                  width: 354.w,
                                  child:
                                      Image.asset('assets/images/divider.png'),
                                ),
                                SizedBox(
                                  height: 250.h,
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(
                                        left: 15.w, right: 15.w),
                                    controller: _scrollController4,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: topSellersdata.length,
                                    itemBuilder: (context, index) {
                                      final topSellers = topSellersdata[index];
                                      return GestureDetector(
                                        onTap: () {
                                          analytics.logEvent(
                                            name: 'View Product',
                                            parameters: {
                                              'usedID': user.id,
                                              'productId': topSellers.id,
                                              'title': topSellers.title
                                            },
                                          );
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailsPage(
                                                      productid: topSellers.id
                                                          .toString(),
                                                      productimage: topSellers
                                                          .image
                                                          .toString(),
                                                      name: topSellers.title
                                                          .toString(),
                                                      productprice: topSellers
                                                          .variant_price
                                                          .toString(),
                                                      productDescription:
                                                          topSellers.description
                                                              .toString(),
                                                      productweight: topSellers
                                                          .variant_weight
                                                          .toString(),
                                                      variantType: topSellers
                                                          .variant_type,
                                                      multiVariants: topSellers
                                                          .multipleVariants,
                                                      wherefrom: 'Home',
                                                      variantColor: topSellers
                                                          .variant_color,
                                                      variantMaterial:
                                                          topSellers
                                                              .variant_material,
                                                      variantSize: topSellers
                                                          .variant_size,
                                                      variantStyle: topSellers
                                                          .variant_style,
                                                      variantSKU: topSellers
                                                          .variant_SKU,
                                                      parentChildSku: topSellers
                                                          .parentSKU_childSKU,
                                                      variantqunatityStock:
                                                          topSellers
                                                              .variant_quantity,
                                                    )),
                                          );
                                        },
                                        child: FastMovingProducts(
                                          id: topSellers.id.toString(),
                                          image: topSellers.image.toString(),
                                          name: topSellers.title.toString(),
                                          price: topSellers.variant_type ==
                                                  'single'
                                              ? topSellers.variant_price
                                                  .toString()
                                              : topSellers.multipleVariants[0]
                                                  .variant_price
                                                  .toString(),
                                          weight: topSellers.variant_type ==
                                                  'single'
                                              ? topSellers.variant_weight
                                                  .toString()
                                              : topSellers.multipleVariants[0]
                                                  .variant_weight
                                                  .toString(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),

                                AnimatedSmoothIndicator(
                                  activeIndex: topsellersindex,
                                  count: topSellersdata.length,
                                  effect: SwapEffect(
                                      activeDotColor:
                                          Theme.of(context).primaryColor),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> generateImagetiles() {
    final user = Provider.of<UserProvider>(context).user;
    return carouselimage
        .asMap()
        .entries
        .map(
          (image) => GestureDetector(
            onTap: () {
              int imageindex = image.key;
              print(imageindex);
              setState(() {});
              analytics.logEvent(
                name: 'View Product',
                parameters: {
                  'usedID': user.id,
                  'productId': carouselSliderdata[imageindex].id.toString(),
                  'title': carouselSliderdata[imageindex].bannerName.toString(),
                },
              );
              carouselSliderdata[imageindex].associatedWith == 'Category'
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GridViewHomePage(
                            appbartitletext: carouselSliderdata[imageindex]
                                .associatedDocument
                                .categoryName,
                            customcategoryvalue:
                                '${APIRoute.route}/products/custom_category?custom_category=${carouselSliderdata[imageindex].associatedDocument.categoryName}',
                          )))
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                            productid: carouselSliderdata[imageindex]
                                .associatedDocument
                                .id
                                .toString(),
                            productimage: carouselSliderdata[imageindex]
                                .associatedDocument
                                .image
                                .toString(),
                            name: carouselSliderdata[imageindex]
                                .associatedDocument
                                .title
                                .toString(),
                            productprice: carouselSliderdata[imageindex]
                                .associatedDocument
                                .variant_price
                                .toString(),
                            productDescription: carouselSliderdata[imageindex]
                                .associatedDocument
                                .description
                                .toString(),
                            variantType: carouselSliderdata[imageindex]
                                .associatedDocument
                                .variant_type,
                            multiVariants: carouselSliderdata[imageindex]
                                .associatedDocument
                                .multipleVariants,
                            productweight: carouselSliderdata[imageindex]
                                .associatedDocument
                                .variant_weight
                                .toString(),
                            wherefrom: 'Home',
                            variantColor: carouselSliderdata[imageindex]
                                .associatedDocument
                                .variant_color,
                            variantMaterial: carouselSliderdata[imageindex]
                                .associatedDocument
                                .variant_material,
                            variantSize: carouselSliderdata[imageindex]
                                .associatedDocument
                                .variant_size,
                            variantStyle: carouselSliderdata[imageindex]
                                .associatedDocument
                                .variant_style,
                            variantSKU: carouselSliderdata[imageindex]
                                .associatedDocument
                                .variant_SKU,
                            parentChildSku: carouselSliderdata[imageindex]
                                .associatedDocument
                                .parentSKU_childSKU,
                            variantqunatityStock: carouselSliderdata[imageindex]
                                .associatedDocument
                                .variant_quantity,
                          )));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Container(
                color: Colors.white,
                width: 370.w,
                child: CachedNetworkImage(
                  imageUrl: image.value,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      ShimmerEffect(conHeight: 114.h, conWidth: 165.w),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  Widget customCategory(
      String img, String name, BuildContext context, String valQ) {
    return Column(
      children: [
        // Shimmer(conHeight: 85.h, conWidth: 85.w),
        // Shimmer(conHeight: 35.h, conWidth: 75.w),
        SizedBox(
          width: 85.w,
          height: 85.h,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => GridViewHomePage(
                        appbartitletext: name,
                        customcategoryvalue:
                            '${APIRoute.route}/products/custom_category?custom_category=$valQ',
                      ))));
              // print('ringsssssss');
              //   final ringp =
              // getproduct(context, name1, valQ);
              // Navigator.push(context, MaterialPageRoute(builder: ((context) => GridViewHomePage(relatedproduct: ringp, productdata: ringp)))
            },
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    ShimmerEffect(conHeight: 98.h, conWidth: 165.w),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 7.h,
        ),
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
        ),
      ],
    );
  }

// api calls in init state
  void fetchDataInit() async {
    if (mounted) {
      if (dataloading) {
        carouselimage.clear();
          Provider.of<NotificationProvider>(context, listen: false).clearData();
     Provider.of<CartProvider>(context, listen: false).clearData();
   Provider.of<WhislistProvider>(context, listen: false).clearData();
        setState(() {});

        //dynamic category

        categoryData = await categoryAPI();

        // for carousel image Api calling and get the data

        carouselSliderdata =
            await HomePageProdutsAPI.homePageBannersAPI(context);
        //   print(value);
        for (int i = 0; i < carouselSliderdata.length; i++) {
          if (carouselSliderdata[i].bannerImage.isNotEmpty) {
            carouselimage.add(carouselSliderdata[i].bannerImage.toString());
          }
        }

        setState(() {});

        //                       api call for  fastMovingproducts

        fastmovingdata = await productsAPI('products/fast-moving');
        // setState(() {});

        //                          api call for basedonhistory

        basedonHistorydata = await productsAPI('products/history-based');
        // setState(() {});

        //                    api call for  recommendedforyou

        recommededForYoudata =
            await productsAPI('products/recommanded-products');

        //                       api call for topsellers

        topSellersdata = await productsAPI('products/top-sellers');
        setState(() {
          // cartAPI to display cart data

          CartAPI.fetchCartData(context);
          // WhislistAPI to display Whilist  data
          WhishlistApi.fetchWhishlistData(context);
          //   timer = Timer.periodic(Duration(seconds: 2), (timer) {
          NotificationAPI.notificationApi(context);
          // });
        });

        setState(() {
          dataloading = false;
        });
      }
    }
  }

// home api for the home page grids and the carousel
  Future<List<ProductsModel>> productsAPI(String endval) async {
    final response = await HomePageProdutsAPI.homePageAPI(context, endval);
    return response;
  }

  Future<List<CategoryModel>> categoryAPI() async {
    final response = await HomePageCategoryAPI.homePageAPIDynamic(context);
    return response;
  }

  Future<void> onRefresh() async {
    dataloading = true;

    fetchDataInit();
  }
}
