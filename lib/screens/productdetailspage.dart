import 'package:cached_network_image/cached_network_image.dart';
import 'package:coswan/models/multivariant_model.dart';
import 'package:coswan/models/products_model.dart';
import 'package:coswan/models/review_model.dart';
import 'package:coswan/providers/notificatiion_provider.dart';
import 'package:coswan/screens/cartpage.dart';
import 'package:coswan/providers/cartprovider.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/providers/whislist_provider.dart';
import 'package:coswan/screens/notifiactionview.dart';
import 'package:coswan/screens/reviewpage.dart';
import 'package:coswan/services/cart_api.dart';
import 'package:coswan/services/home_page_product_api.dart';
import 'package:coswan/services/wishlist_api.dart';
import 'package:coswan/widgets/relatedproductscontainer.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productid;
  final String productimage;
  final String name;
  final String? productprice;
  final String productDescription;
  final String? productweight;
  final String? variantType;
  final List<MultivariantModel>? multiVariants;
  final String wherefrom;
  final String? cartIdFromNotification;
  final String? quantityFromNotification;
  final String? variantMaterial;
  final String? variantColor;
  final String? variantSize;
  final String? variantStyle;
  final String? variantSKU;
  final String? parentChildSku;
  final bool? fromcart;
  final int? variantqunatityStock;

  // final String product_status;
  // final List<Map<String, dynamic>> relatedPtroducts;

  const ProductDetailsPage({
    super.key,
    required this.productid,
    required this.productimage,
    required this.name,
    this.productprice,
    required this.productDescription,
    this.productweight,
    this.variantType,
    this.multiVariants,
    required this.wherefrom,
    this.cartIdFromNotification,
    this.quantityFromNotification,
    this.variantMaterial,
    this.variantColor,
    this.variantSize,
    this.variantStyle,
    this.variantSKU,
    this.parentChildSku,
    this.fromcart,
    this.variantqunatityStock,

    // required this.relatedPtroducts,
    // required this.product_status,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ReviewModel? reviewData;
  late TextEditingController textEditingController;
  late TextEditingController textEditingController1;

  late List<ProductsModel> relatedProductsdata;

  bool dataloaded = false;
  late String total;
  String selectedWeight = '';
  String selectedMaterial = '';
  String selectedColor = '';
  String selectedSize = '';
  String selectedStyle = '';
  String? parentChildSkuFromAPI = '';
  String variantSkuFromAPI = '';
  String selectedColorWithCode = '';
  late String variantPrice1;
  int isSelectedVariant = 0;
  bool priceBreakup = false;
  bool productSpecification = false;
  bool askquestion = false;
  bool reviewtile = false;
  int maxquestionlenth = 500;
  Map<String, dynamic> variantsMultiple = {};
  late Map<String, dynamic> getDataAfterPassinAPI;
  // bool variantsMultipleloaded = false;
  List<String> uniqueMaterials = [];
  List<String> uniqueColor = [];
  List<String> uniqueSize = [];
  List<String> uniqueStyle = [];

  bool visbilityforAPISKU = false;
  List<bool> isSelected = [true, false];
  List<Map<String, dynamic>> multivariantsAfterweight = [];
  int stockQuantityFromAPI = 1;
  late int texteditingQuantityForCheckingTheStock;

  @override
  void initState() {
    fetchvariants();
    relatedProductsAPI().then((value) {
      setState(() {
        relatedProductsdata = value;
        dataloaded = true;
        print(widget.variantSKU);
      });
    });
    textEditingController = TextEditingController(
        text: widget.wherefrom == 'Home'
            ? '1'
            : widget.quantityFromNotification.toString());
    textEditingController1 = TextEditingController();
    texteditingQuantityForCheckingTheStock =
        int.parse(textEditingController.text);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    textEditingController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  final cart = Provider.of<CartProvider>(context);
    final wishlist = Provider.of<WhislistProvider>(context).listOfwhislist;
    final user = Provider.of<UserProvider>(context).user;
    // List? colorSplitting = widget.variantColor!.split(',');
    // String? variantColorName = colorSplitting[0];
    // String? variantColorCode = colorSplitting[1];

    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            gradient: gradient,
          ),
          child: Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              forceMaterialTransparency: true,
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              actions: [
               
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()));
                    },
                    child: Provider.of<CartProvider>(
                      context,
                    ).cart.isNotEmpty
                        ? Badge(
                            backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
                            label: Text(
                                '${Provider.of<CartProvider>(context).cart.length}'),
                            child: const Icon(Icons.shopping_cart_outlined),
                          )
                        : const Icon(Icons.shopping_cart_outlined)),
                SizedBox(
                  width: 10.w,
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
                SizedBox(width: 10.w)
              ],
            ),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      // padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 300.h,
                        // height: 250.h,
                        child: CachedNetworkImage(
                          imageUrl: widget.productimage,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              ShimmerEffect(conHeight: 98.h, conWidth: 165.w),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                      //    padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.name,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                       GestureDetector(onTap: () {
                  wishlist.any((product) => product.id == widget.productid)
                      ? removewishlistItem(widget.productid)
                      : whislistAPI(widget.productid);
                }, child: Consumer<WhislistProvider>(
                    builder: (context, whilist, child) {
                  return Icon(
                    wishlist.any((product) => product.id == widget.productid)
                        ? Icons.favorite
                        : Icons.favorite_border,
                  );
                })),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 13.h,
                                  ),
                                  Row(
                                    children: [
                                      Text('SKU : ',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                          widget.wherefrom == 'Home'
                                              ? widget.variantType == 'single'
                                                  ? widget.variantSKU!
                                                  : widget
                                                      .multiVariants![
                                                          isSelectedVariant]
                                                      .variant_SKU
                                              : widget.variantSKU!,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      widget.wherefrom != 'Home'
                                          ? Row(
                                              children: [
                                                Text(
                                                    'Total Stock : ${widget.variantqunatityStock} left',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.orange,
                                                    ))
                                              ],
                                            )
                                          : widget.variantType == 'single'
                                              ? texteditingQuantityForCheckingTheStock <
                                                      widget
                                                          .variantqunatityStock!
                                                  ? Text(
                                                      "In Stock",
                                                      style: TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            13, 165, 28, 1),
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  : Text(
                                                      "Out Of Stock",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                              : texteditingQuantityForCheckingTheStock <=
                                                      stockQuantityFromAPI
                                                  ? Text(
                                                      "In Stock",
                                                      style: TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            13, 165, 28, 1),
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  : Text(
                                                      "Out of Stock",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      widget.wherefrom == 'Home' &&
                                              widget.variantType == 'single'
                                          ? Text(
                                              "(${widget.variantqunatityStock} left)"
                                                  .toString())
                                          : const SizedBox()
                                    ],
                                  ),
                                  // price and toogle row
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Text(
                                      //   widget.wherefrom == 'Home'
                                      //       ? widget.variantType == 'single'
                                      //           ? '₹ ${widget.productprice}'
                                      //           : '₹ ${widget.multiVariants![isSelectedVariant].variant_price}'
                                      //       : widget.productprice!,
                                      //   style: TextStyle(
                                      //     color: Theme.of(context).primaryColor,
                                      //     fontSize: 20.sp,
                                      //     fontWeight: FontWeight.w500,
                                      //   ),
                                      // ),
                                      // ToggleButtons(
                                      //   borderColor: Color.fromRGBO(207, 196, 196, 1),
                                      //   selectedColor: Colors.white,
                                      //   fillColor: Theme.of(context).primaryColor,
                                      //   splashColor: Theme.of(context).primaryColor,
                                      //   color: Colors.black,
                                      //   textStyle: TextStyle(
                                      //     color: Theme.of(context).primaryColor,
                                      //     fontWeight: FontWeight.w600,
                                      //     fontSize: 18.sp,
                                      //   ),
                                      //   isSelected: isSelected,
                                      //   children: [
                                      //     Text('₹'),
                                      //     Text(
                                      //       "\$",
                                      //     )
                                      //   ],
                                      //   onPressed: (newindex) {
                                      //     setState(() {
                                      //       for (int index = 0;
                                      //           index < isSelected.length;
                                      //           index++) {
                                      //         if (index == newindex) {
                                      //           isSelected[index] = true;
                                      //         } else {
                                      //           isSelected[index] = false;
                                      //         }
                                      //       }
                                      //     });
                                      //   },
                                      // )
                                    ],
                                  ),
                                  // rating and reivew row
                                  SizedBox(
                                    height: 9.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2.r),
                                                color: const Color.fromRGBO(
                                                    255, 168, 0, 1),
                                              ),
                                              height: 32.h,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    reviewData?.averageRating
                                                            .toString() ??
                                                        '0',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            RatingBarIndicator(
                                              itemCount: 5,
                                              rating:
                                                  reviewData?.averageRating ??
                                                      1,
                                              direction: Axis.horizontal,
                                              unratedColor:
                                                  const Color.fromRGBO(
                                                      208, 205, 204, 1),
                                              itemSize: 20,
                                              itemBuilder: (context, index) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(
                                                    255, 168, 0, 1),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            Text(
                                              '(${reviewData?.totalReviews.toString() ?? 0})',
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 168, 0, 1)),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // SizedBox(
                                      //   width: 70.w,
                                      // ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReviewPage(
                                                        title: widget.name,
                                                        size: widget.variantType ==
                                                                    'single' ||
                                                                widget.wherefrom ==
                                                                    'Home'
                                                            ? widget
                                                                .variantSize!
                                                            : widget
                                                                .multiVariants![
                                                                    0]
                                                                .variant_size
                                                                .toString(),
                                                        productId:
                                                            widget.productid,
                                                        quantity: widget
                                                            .variantqunatityStock
                                                            .toString(),
                                                        image:
                                                            widget.productimage,
                                                        price: widget.variantType ==
                                                                    'single' ||
                                                                widget.wherefrom !=
                                                                    'Home'
                                                            ? widget
                                                                .productprice!
                                                            : widget
                                                                .multiVariants![
                                                                    0]
                                                                .variant_price
                                                                .toString(),
                                                      )));
                                        },
                                        child: SizedBox(
                                          child: FittedBox(
                                            child: Text(
                                              'Write a Review',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50.r),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  //   if (totalcount <= 1) {
                                                  //     totalcount = 1;
                                                  //   } else {
                                                  //     totalcount -= 1;
                                                  //   }
                                                  //   textEditingController.text =
                                                  //       totalcount.toString();
                                                  if (int.parse(
                                                          textEditingController
                                                              .text) <=
                                                      1) {
                                                    textEditingController.text =
                                                        '1';
                                                  } else {
                                                    int total = int.parse(
                                                        textEditingController
                                                            .text);
                                                    total -= 1;
                                                    textEditingController.text =
                                                        total.toString();
                                                  } // else {
                                                  //   textEditingController.text=1.toString();
                                                  // }
                                                });
                                              },
                                              child: Icon(
                                                  Icons
                                                      .remove_circle_outline_sharp,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            SizedBox(
                                              height: 50.h,
                                              width: 50.w,
                                              child: TextFormField(
                                                onChanged: (value) {
                                                  setState(() {
                                                    textEditingController.text =
                                                        textEditingController
                                                            .text;
                                                    texteditingQuantityForCheckingTheStock =
                                                        int.parse(
                                                            textEditingController
                                                                .text);
                                                  });
                                                },
                                                onFieldSubmitted: (value) {
                                                  if (value.isEmpty) {
                                                    setState(() {
                                                      textEditingController
                                                          .text = '1';
                                                    });
                                                  }
                                                },
                                                textAlign: TextAlign.center,
                                                controller:
                                                    textEditingController,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7.w),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor))),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  // print(totalcount);
                                                  // totalcount += 1;
                                                  // textEditingController.text =
                                                  //     totalcount.toString();

                                                  int total = int.parse(
                                                      textEditingController
                                                          .text);
                                                  total += 1;
                                                  textEditingController.text =
                                                      total.toString();
                                                });
                                              },
                                              child: Icon(
                                                Icons
                                                    .add_circle_outline_rounded,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.sp,
                                      ),
                                      Text(
                                        '${textEditingController.text} Items Selected',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14.sp,
                                  ),
                                  Text(
                                    'Product Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp),
                                  ),
                                  // product description  from the server
                                  Text(
                                    widget.productDescription,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 18.sp,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                              'assets/icons/Ic_lifeTimeIcon.png'),
                                          SizedBox(
                                            width: 12.w,
                                          ),
                                          Text(
                                            "Life Time Exchange",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                              'assets/icons/ic_certifiedIcon.png'),
                                          SizedBox(
                                            width: 9.w,
                                          ),
                                          Text(
                                            "925 Sterling Silver",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                          'assets/icons/ic_30daysIcon.png'),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Text(
                                        "30 days return",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 29.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Have Questions? Chat With us",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 13.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // redirect to whats app functionality
                                          whatsapp();
                                        },
                                        child: CircleAvatar(
                                          // radius: 20.r,
                                          backgroundColor: Colors.white,
                                          child: Image.asset(
                                              "assets/icons/ic_whatsapp.png"),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Gross Weight ( in Gms)",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Weight and price of the jewellery item may vary subject to the stock available",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 21.h,
                                  ),
                                  /*
                                  i used the varaible wherfrom to denote the page where it is coming  from(wherefrom == home || others )
                                  because use same button to handle API calls and to handle the variant efficiently 
                                  for example : some time  we can variant type to handle to type multivariants and some cases 
                                  even though it is mutlivariant the data are coming from outside of the multivarianats list 
                                  so for that case i used to the variable to handle it.
                                
                                   */

                                  widget.wherefrom == 'Home'
                                      ? widget.variantType == 'single'
                                          ? Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              // height: 200.h,
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  color: Colors.white),
                                              child: Wrap(
                                                spacing: 30,
                                                runSpacing: 15,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Weight in gms',
                                                        style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: 8.h,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .symmetric(
                                                                    vertical:
                                                                        8.h,
                                                                    horizontal:
                                                                        10.w),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3.r),
                                                            color: const Color
                                                                .fromRGBO(255,
                                                                204, 124, 1)),
                                                        child: Text(
                                                          '${widget.productweight} gram',
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      Text(
                                                        '${widget.variantqunatityStock} left',
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Material',
                                                        style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: 8.h,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .symmetric(
                                                                    vertical:
                                                                        8.h,
                                                                    horizontal:
                                                                        15.w),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3.r),
                                                            color:
                                                                Colors.white),
                                                        child: Text(
                                                          '${widget.variantMaterial}',
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Color',
                                                        style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: 8.h,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .symmetric(
                                                                    vertical:
                                                                        8.h,
                                                                    horizontal:
                                                                        15.w),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      3.r),
                                                          color: Color(
                                                              _hexcolor(widget
                                                                  .variantColor!
                                                                  .split(
                                                                      ',')[1])),
                                                        ),
                                                        child: Text(
                                                          widget.variantColor!
                                                              .split(',')[0],
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Style',
                                                          style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          height: 8.h,
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .symmetric(
                                                                      vertical:
                                                                          8.h,
                                                                      horizontal:
                                                                          15.w),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3.r),
                                                              color:
                                                                  Colors.white),
                                                          child: Text(
                                                            '${widget.variantStyle}',
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ]),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Size',
                                                        style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: 8.h,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .symmetric(
                                                                    vertical:
                                                                        8.h,
                                                                    horizontal:
                                                                        15.w),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3.r),
                                                            color:
                                                                Colors.white),
                                                        child: Text(
                                                          '${widget.variantSize!} mm',
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          : variantsMultiple.isEmpty
                                              ? const SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      3.r),
                                                        ),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,

                                                        // to show the list of weights
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Weight in gms',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            SizedBox(
                                                              height: 8.h,
                                                            ),
                                                            Wrap(
                                                              spacing: 10,
                                                              runSpacing: 10,
                                                              children: List.generate(
                                                                  variantsMultiple[
                                                                          'variant_weight']
                                                                      .length,
                                                                  (index) {
                                                                // final multiweight =
                                                                variantsMultiple[
                                                                        'variant_weight']
                                                                    [index];
                                                                return Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      ChoiceChip(
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                        showCheckmark:
                                                                            false,
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        selected:
                                                                            (selectedWeight ==
                                                                                variantsMultiple['variant_weight'][index].toString()),
                                                                        disabledColor:
                                                                            Colors.white,
                                                                        onSelected:
                                                                            (val) {
                                                                          setState(
                                                                              () {
                                                                            isSelectedVariant =
                                                                                index;
                                                                            selectedWeight =
                                                                                variantsMultiple['variant_weight'][index].toString();

                                                                            variantSkuFromAPI =
                                                                                '';
                                                                            parentChildSkuFromAPI =
                                                                                '';
                                                                            selectedMaterial =
                                                                                '';
                                                                            selectedColor =
                                                                                '';
                                                                            selectedColorWithCode =
                                                                                '';
                                                                            selectedStyle =
                                                                                '';
                                                                            selectedSize =
                                                                                '';
                                                                            stockQuantityFromAPI =
                                                                                1;
                                                                            fetchDataAfterSelectingTheWeight();
                                                                            // parentChildSku =
                                                                            //     multiweight
                                                                            //         .parentSKU_childSKU;
                                                                          });
                                                                        },
                                                                        selectedColor: const Color
                                                                            .fromRGBO(
                                                                            255,
                                                                            204,
                                                                            124,
                                                                            1),
                                                                        label: Text(
                                                                            '${variantsMultiple['variant_weight'][index]} gm',
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w500)),
                                                                        side: (selectedWeight ==
                                                                                variantsMultiple['variant_weight'][index].toString())
                                                                            ? BorderSide.none
                                                                            : BorderSide(color: Theme.of(context).primaryColor),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(3.r),
                                                                        ),
                                                                      ),
                                                                      // Text(
                                                                      //   '${widget.variantType == 'single' ? widget.variantqunatityStock : widget.multiVariants![isSelectedVariant].variant_quantity} left',
                                                                      //   style: TextStyle(
                                                                      //     fontWeight:
                                                                      //         FontWeight
                                                                      //             .w500,
                                                                      //     fontSize: 12.sp,
                                                                      //   ),
                                                                      // ),
                                                                    ]);
                                                              }),
                                                            ),
                                                          ],
                                                        )),
                                                    //material Material
                                                    SizedBox(height: 25.h),
                                                    variantsMultiple.isEmpty
                                                        ? const SizedBox()
                                                        : (selectedWeight
                                                                    .isEmpty &&
                                                                multivariantsAfterweight
                                                                    .isEmpty)
                                                            ? Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3.r),
                                                                ),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,

                                                                // to show the list of Material
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Material',
                                                                      style: TextStyle(
                                                                          fontSize: 13
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          8.h,
                                                                    ),
                                                                    Wrap(
                                                                      spacing:
                                                                          10,
                                                                      runSpacing:
                                                                          10,
                                                                      children: List.generate(
                                                                          variantsMultiple['variant_material']
                                                                              .length,
                                                                          (index) {
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                              duration: Durations.long1,
                                                                              content: Text(
                                                                                'Please select the weight',
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                              backgroundColor: Colors.red,
                                                                            ));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(10.w),
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(3.r),
                                                                                border: Border.all(color: Theme.of(context).primaryColor)),
                                                                            child:
                                                                                Text(
                                                                              variantsMultiple['variant_material'][index],
                                                                              style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }),
                                                                    ),
                                                                  ],
                                                                ))
                                                            // variantsMultiple
                                                            : Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3.r),
                                                                ),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,

                                                                // to show the list of Material
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Material',
                                                                      style: TextStyle(
                                                                          fontSize: 13
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          8.h,
                                                                    ),
                                                                    Wrap(
                                                                      spacing:
                                                                          10,
                                                                      runSpacing:
                                                                          10,
                                                                      children: List.generate(
                                                                          uniqueMaterials
                                                                              .length,
                                                                          (index) {
                                                                        return Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              ChoiceChip(
                                                                                backgroundColor: Colors.white,
                                                                                showCheckmark: false,
                                                                                padding: const EdgeInsets.all(10),
                                                                                selected: (selectedMaterial == uniqueMaterials[index]),
                                                                                disabledColor: Colors.white,
                                                                                onSelected: (val) {
                                                                                  setState(() {
                                                                                    isSelectedVariant = index;

                                                                                    selectedMaterial = uniqueMaterials[index].toString();
                                                                                    print(selectedMaterial);
                                                                                    print('ddddddddddddddddddddddasfasfdafasdf');

                                                                                    variantSkuFromAPI = '';
                                                                                    parentChildSkuFromAPI = '';

                                                                                    selectedColor = '';
                                                                                    selectedColorWithCode = '';
                                                                                    selectedStyle = '';
                                                                                    selectedSize = '';
                                                                                    stockQuantityFromAPI = 1;
                                                                                    fetchDataAfterSelectingTheWeight();
                                                                                  });
                                                                                },
                                                                                selectedColor: const Color.fromRGBO(255, 204, 124, 1),
                                                                                label: Text(uniqueMaterials[index], style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w500)),
                                                                                side: (selectedMaterial == uniqueMaterials[index]) ? BorderSide.none : BorderSide(color: Theme.of(context).primaryColor),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(3.r),
                                                                                ),
                                                                              ),
                                                                            ]);
                                                                      }),
                                                                    ),
                                                                  ],
                                                                )),
                                                    SizedBox(
                                                      height: 25.h,
                                                    ),

                                                    // color
                                                    variantsMultiple.isEmpty
                                                        ? const SizedBox()
                                                        : selectedMaterial
                                                                .isEmpty
                                                            ? Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3.r),
                                                                ),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,

                                                                // to show the list of color
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Colors',
                                                                      style: TextStyle(
                                                                          fontSize: 13
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          8.h,
                                                                    ),
                                                                    Wrap(
                                                                      spacing:
                                                                          10,
                                                                      runSpacing:
                                                                          10,
                                                                      children: List.generate(
                                                                          variantsMultiple['variant_color']
                                                                              .length,
                                                                          (index) {
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                              duration: Durations.long1,
                                                                              content: Text(
                                                                                'Please select the Material',
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                              backgroundColor: Colors.red,
                                                                            ));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(10.w),
                                                                            decoration: BoxDecoration(
                                                                                color: Color(_hexcolor(variantsMultiple['variant_color'][index].toString().split(',')[1])),
                                                                                borderRadius: BorderRadius.circular(3.r),
                                                                                border: Border.all(color: Theme.of(context).primaryColor)),
                                                                            child:
                                                                                Text(variantsMultiple['variant_color'][index].toString().split(',')[0]),
                                                                          ),
                                                                        );
                                                                      }),
                                                                    ),
                                                                  ],
                                                                ))
                                                            : Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3.r),
                                                                ),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,

                                                                // to show the list of colors
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Colors',
                                                                      style: TextStyle(
                                                                          fontSize: 13
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          8.h,
                                                                    ),
                                                                    Wrap(
                                                                      spacing:
                                                                          10,
                                                                      runSpacing:
                                                                          10,
                                                                      children: List.generate(
                                                                          uniqueColor
                                                                              .length,
                                                                          (index) {
                                                                        return Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              ChoiceChip(
                                                                                backgroundColor: Color(_hexcolor(uniqueColor[index].split(',')[1])),
                                                                                showCheckmark: false,
                                                                                padding: const EdgeInsets.all(10),
                                                                                selected: (selectedColor == uniqueColor[index].split(',')[0]),
                                                                                disabledColor: Color(_hexcolor(uniqueColor[index].split(',')[1])),
                                                                                onSelected: (val) {
                                                                                  setState(() {
                                                                                    selectedColor = uniqueColor[index].split(',')[0];
                                                                                    selectedColorWithCode = uniqueColor[index];
                                                                                    print(selectedColor);
                                                                                    variantSkuFromAPI = '';
                                                                                    parentChildSkuFromAPI = '';
                                                                                    selectedStyle = '';
                                                                                    fetchDataAfterSelectingTheWeight();
                                                                                  });
                                                                                },
                                                                                selectedColor: const Color.fromRGBO(255, 204, 124, 1),
                                                                                // Color(_hexcolor( variantsMultiple[
                                                                                //         'variant_color'][
                                                                                //     index]
                                                                                // .split(
                                                                                //     ',')[1])),
                                                                                label: Text(uniqueColor[index].split(',')[0], style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w500)),
                                                                                side: (selectedColor == uniqueColor[index].split(',')[0]) ? BorderSide.none : BorderSide(color: Theme.of(context).primaryColor),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(3.r),
                                                                                ),
                                                                              ),
                                                                            ]);
                                                                      }),
                                                                    ),
                                                                  ],
                                                                )),

                                                    SizedBox(
                                                      height: 25.h,
                                                    ),
                                                    variantsMultiple.isEmpty
                                                        ? const SizedBox()
                                                        :
                                                        //style
                                                        selectedColor.isEmpty
                                                            ? Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3.r),
                                                                ),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,

                                                                // to show the list of style
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Style',
                                                                      style: TextStyle(
                                                                          fontSize: 13
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          8.h,
                                                                    ),
                                                                    Wrap(
                                                                      spacing:
                                                                          10,
                                                                      runSpacing:
                                                                          10,
                                                                      children: List.generate(
                                                                          variantsMultiple['variant_style']
                                                                              .length,
                                                                          (index) {
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                              duration: Durations.long1,
                                                                              content: Text(
                                                                                'Please select the Color',
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                              backgroundColor: Colors.red,
                                                                            ));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(10.w),
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(3.r),
                                                                                border: Border.all(color: Theme.of(context).primaryColor)),
                                                                            child:
                                                                                Text(variantsMultiple['variant_style'][index]),
                                                                          ),
                                                                        );
                                                                      }),
                                                                    ),
                                                                  ],
                                                                ))
                                                            : Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3.r),
                                                                ),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,

                                                                // to show the list of Style
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Style',
                                                                      style: TextStyle(
                                                                          fontSize: 13
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          8.h,
                                                                    ),
                                                                    Wrap(
                                                                      spacing:
                                                                          10,
                                                                      runSpacing:
                                                                          10,
                                                                      children: List.generate(
                                                                          uniqueStyle
                                                                              .length,
                                                                          (index) {
                                                                        return Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              ChoiceChip(
                                                                                backgroundColor: Colors.white,
                                                                                showCheckmark: false,
                                                                                padding: const EdgeInsets.all(10),
                                                                                selected: (selectedStyle == uniqueStyle[index]),
                                                                                disabledColor: Colors.white,
                                                                                onSelected: (val) {
                                                                                  setState(() {
                                                                                    isSelectedVariant = index;

                                                                                    selectedStyle = uniqueStyle[index];

                                                                                    selectedSize = '';
                                                                                    variantSkuFromAPI = '';
                                                                                    parentChildSkuFromAPI = '';
                                                                                    stockQuantityFromAPI = 1;
                                                                                    fetchDataAfterSelectingTheWeight();
                                                                                  });
                                                                                },
                                                                                selectedColor: const Color.fromRGBO(255, 204, 124, 1),
                                                                                label: Text(uniqueStyle[index], style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w500)),
                                                                                side: (selectedStyle == uniqueStyle[index]) ? BorderSide.none : BorderSide(color: Theme.of(context).primaryColor),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(3.r),
                                                                                ),
                                                                              ),
                                                                            ]);
                                                                      }),
                                                                    ),
                                                                  ],
                                                                )),

                                                    SizedBox(height: 25.h),
                                                    // size
                                                    variantsMultiple.isEmpty
                                                        ? const SizedBox()
                                                        : selectedStyle.isEmpty
                                                            ? Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3.r),
                                                                ),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,

                                                                // to show the list of size
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Size',
                                                                      style: TextStyle(
                                                                          fontSize: 13
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          8.h,
                                                                    ),
                                                                    Wrap(
                                                                      spacing:
                                                                          10,
                                                                      runSpacing:
                                                                          10,
                                                                      children: List.generate(
                                                                          variantsMultiple['variant_size']
                                                                              .length,
                                                                          (index) {
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                              duration: Durations.long1,
                                                                              content: Text(
                                                                                'Please select the Style',
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                              backgroundColor: Colors.red,
                                                                            ));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(10.w),
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(3.r),
                                                                                border: Border.all(color: Theme.of(context).primaryColor)),
                                                                            child:
                                                                                Text('${variantsMultiple['variant_size'][index]} mm'),
                                                                          ),
                                                                        );
                                                                      }),
                                                                    ),
                                                                  ],
                                                                ))
                                                            : Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3.r),
                                                                ),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,

                                                                // to show the list of size
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Size',
                                                                      style: TextStyle(
                                                                          fontSize: 13
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          8.h,
                                                                    ),
                                                                    Wrap(
                                                                      spacing:
                                                                          10,
                                                                      runSpacing:
                                                                          10,
                                                                      children: List.generate(
                                                                          uniqueSize
                                                                              .length,
                                                                          (index) {
                                                                        return Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              ChoiceChip(
                                                                                backgroundColor: Colors.white,
                                                                                showCheckmark: false,
                                                                                padding: const EdgeInsets.all(10),
                                                                                selected: (selectedSize == uniqueSize[index].toString()),
                                                                                disabledColor: Colors.white,
                                                                                onSelected: (val) {
                                                                                  setState(() {
                                                                                    isSelectedVariant = index;

                                                                                    selectedSize = uniqueSize[index].toString();
                                                                                    variantSkuFromAPI = '';
                                                                                    parentChildSkuFromAPI = '';
                                                                                    stockQuantityFromAPI = 1;
                                                                                    // to set the sku for parent and variant
                                                                                    fetchsku();
                                                                                  });
                                                                                },
                                                                                selectedColor: const Color.fromRGBO(255, 204, 124, 1),
                                                                                label: Text('${uniqueSize[index].toString()} mm', style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w500)),
                                                                                side: (selectedSize == uniqueSize[index].toString()) ? BorderSide.none : BorderSide(color: Theme.of(context).primaryColor),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(3.r),
                                                                                ),
                                                                              ),
                                                                              variantSkuFromAPI.isEmpty ? SizedBox() : Text('${stockQuantityFromAPI} left')
                                                                            ]);
                                                                      }),
                                                                    ),
                                                                  ],
                                                                )),
                                                  ],
                                                )
                                      : Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200.h,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              color: Colors.white),
                                          child: Wrap(
                                            spacing: 30,
                                            runSpacing: 15,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Weight in gms',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .symmetric(
                                                                vertical: 8.h,
                                                                horizontal:
                                                                    10.w),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3.r),
                                                        color: const Color
                                                            .fromRGBO(
                                                            255, 204, 124, 1)),
                                                    child: Text(
                                                      '${widget.productweight} gram',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  // Text(
                                                  //   '${widget.variantqunatityStock} left',
                                                  //   style: TextStyle(
                                                  //       fontSize: 12.sp,
                                                  //       fontWeight:
                                                  //           FontWeight.w500),
                                                  // )
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Material',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .symmetric(
                                                                vertical: 8.h,
                                                                horizontal:
                                                                    15.w),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3.r),
                                                        color: Colors.white),
                                                    child: Text(
                                                      '${widget.variantMaterial}',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Color',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .symmetric(
                                                                vertical: 8.h,
                                                                horizontal:
                                                                    15.w),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3.r),
                                                      color: Color(_hexcolor(
                                                          widget.variantColor!
                                                              .split(',')[1])),
                                                    ),
                                                    child: Text(
                                                      widget.variantColor!
                                                          .split(',')[0],
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Style',
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .symmetric(
                                                                  vertical: 8.h,
                                                                  horizontal:
                                                                      15.w),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      3.r),
                                                          color: Colors.white),
                                                      child: Text(
                                                        '${widget.variantStyle}',
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ]),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Size',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .symmetric(
                                                                vertical: 8.h,
                                                                horizontal:
                                                                    15.w),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3.r),
                                                        color: Colors.white),
                                                    child: Text(
                                                      '${widget.variantSize!} mm',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                  SizedBox(
                                    height: 10.h,
                                  ),

                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //       color: const Color.fromRGBO(204, 204, 204, 1),
                                  //     ),
                                  //   ),
                                  //   child: ExpansionTile(
                                  //     // tilePadding: EdgeInsets.symmetric(horizontal: 12.w),
                                  //     backgroundColor: Colors.white,
                                  //     title: Text(
                                  //       'Price Breakup',
                                  //       style: TextStyle(
                                  //           fontSize: 13.sp, fontWeight: FontWeight.w600),
                                  //     ),
                                  //     subtitle: Text(
                                  //       '(Gold rate, Making Charges etc)',
                                  //       style: TextStyle(
                                  //           fontSize: 12.sp,
                                  //           fontWeight: FontWeight.w400,
                                  //           color: const Color.fromRGBO(129, 125, 125, 1)),
                                  //     ),
                                  //     trailing: Icon(
                                  //       priceBreakup
                                  //           ? Icons.keyboard_arrow_up_outlined
                                  //           : Icons.keyboard_arrow_down_outlined,
                                  //     ),
                                  //     onExpansionChanged: (value) {
                                  //       setState(() {
                                  //         priceBreakup = value;
                                  //         // !priceBreakup;
                                  //       });
                                  //     },
                                  //     childrenPadding: EdgeInsets.only(
                                  //         //top: 9.,
                                  //         left: 12.w,
                                  //         right: 14.w),
                                  //     children: [
                                  //       Column(
                                  //         children: [
                                  //           Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.spaceBetween,
                                  //             children: [
                                  //               Text(
                                  //                 'Gold (22k)',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //               Text(
                                  //                 '₹45678 / gm',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               )
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 10.h,
                                  //           ),
                                  //           Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.spaceBetween,
                                  //             children: [
                                  //               Text(
                                  //                 'Gold Weight (Grams)',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //               Text(
                                  //                 '7.345 gm',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               )
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 10.h,
                                  //           ),
                                  //           Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.spaceBetween,
                                  //             children: [
                                  //               Text(
                                  //                 'Gold value',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //               Text(
                                  //                 '₹45678.00',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               )
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 10.h,
                                  //           ),
                                  //           Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.spaceBetween,
                                  //             children: [
                                  //               Text(
                                  //                 'Making Charges',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //               Text(
                                  //                 '₹45678.00',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               )
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 10.h,
                                  //           ),
                                  //           Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.spaceBetween,
                                  //             children: [
                                  //               Text(
                                  //                 'Sub Total',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //               Text(
                                  //                 '₹12345678.00',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               )
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 10.h,
                                  //           ),
                                  //           Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.spaceBetween,
                                  //             children: [
                                  //               Text(
                                  //                 'GST',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //               Text(
                                  //                 '₹545678.89 ',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               )
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 11.h,
                                  //           ),
                                  //           SizedBox(
                                  //             width: 359.w,
                                  //             child: const Divider(
                                  //               color: Color.fromRGBO(191, 187, 187, 1),
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             height: 11.h,
                                  //           ),
                                  //           Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.spaceBetween,
                                  //             children: [
                                  //               Text(
                                  //                 'Grand Total',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //               Text(
                                  //                 '₹5456748.89',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               )
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 17.h,
                                  //           )
                                  //         ],
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //       color: const Color.fromRGBO(204, 204, 204, 1),
                                  //     ),
                                  //   ),
                                  //   child: ExpansionTile(
                                  //     childrenPadding: EdgeInsets.only(
                                  //         //top: 9.,
                                  //         left: 13.w,
                                  //         right: 14.w),
                                  //     backgroundColor: Colors.white,
                                  //     trailing: Icon(productSpecification
                                  //         ? Icons.keyboard_arrow_up_sharp
                                  //         : Icons.keyboard_arrow_down_sharp),
                                  //     onExpansionChanged: (productBoolvalue) {
                                  //       setState(() {
                                  //         productSpecification = productBoolvalue;
                                  //       });
                                  //     },
                                  //     title: Text(
                                  //       'Product Specifications',
                                  //       style: TextStyle(
                                  //           fontSize: 13.sp, fontWeight: FontWeight.w600),
                                  //     ),
                                  //     children: [
                                  //       Column(
                                  //         children: [
                                  //           Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.spaceBetween,
                                  //             children: [
                                  //               Text(
                                  //                 'Product Code',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //               Text(
                                  //                 'CSS-205-0302',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               )
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 10.h,
                                  //           ),
                                  //           Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.spaceBetween,
                                  //             children: [
                                  //               Text(
                                  //                 'Gross Weight',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //               Text(
                                  //                 '30.gm',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               )
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 10.h,
                                  //           ),
                                  //           Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.spaceBetween,
                                  //             children: [
                                  //               Text(
                                  //                 'Net Weight',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //               Text(
                                  //                 '32.76gm',
                                  //                 style: TextStyle(
                                  //                     fontSize: 12.sp,
                                  //                     fontWeight: FontWeight.w500),
                                  //               )
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 16.h,
                                  //           )
                                  //         ],
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 19.h,
                                  // ),

                                  // ask question and text fields
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      color: const Color.fromRGBO(
                                          204, 204, 204, 1),
                                    )),
                                    child: ExpansionTile(
                                      backgroundColor: Colors.white,
                                      onExpansionChanged: (val) {
                                        setState(() {
                                          reviewtile = val;
                                        });
                                      },
                                      title: Text(
                                        'Reviews',
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      children: [
                                        reviewData?.reviews != null
                                            ? SizedBox(
                                                height: 315.h,
                                                child: ListView.builder(
                                                    itemCount: reviewData!
                                                        .reviews.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var data = reviewData!
                                                          .reviews[index];
                                                      return ListTile(
                                                        subtitle: SizedBox(
                                                            width: 200.w,
                                                            child: Text(
                                                              data.comment,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )),
                                                        title: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 100.w,
                                                              child: Text(
                                                                  data.storename,
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  ),
                                                            ),
                                                            RatingBarIndicator(
                                                              itemCount: 5,
                                                              rating: reviewData
                                                                      ?.reviews[
                                                                          index]
                                                                      .stars ??
                                                                  1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              unratedColor:
                                                                  const Color
                                                                      .fromRGBO(
                                                                      208,
                                                                      205,
                                                                      204,
                                                                      1),
                                                              itemSize: 20,
                                                              itemBuilder: (context,
                                                                      index) =>
                                                                  const Icon(
                                                                Icons.star,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        255,
                                                                        168,
                                                                        0,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }))
                                            : const SizedBox()
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      color: const Color.fromRGBO(
                                          204, 204, 204, 1),
                                    )),
                                    child: ExpansionTile(
                                      childrenPadding: EdgeInsets.symmetric(
                                          horizontal: 14.w),
                                      backgroundColor: Colors.white,
                                      trailing: Icon(askquestion
                                          ? Icons.keyboard_arrow_up_sharp
                                          : Icons.keyboard_arrow_down_sharp),
                                      onExpansionChanged: (askvalue) {
                                        setState(() {
                                          askquestion = askvalue;
                                        });
                                      },
                                      title: Text(
                                        'Ask a Question',
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all()),
                                              //height: 151.h,
                                              child: Column(
                                                children: [
                                                  TextField(
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          500)
                                                    ],
                                                    controller:
                                                        textEditingController1,
                                                    //  keyboardType: TextInputType.text,
                                                    onChanged: (textstr) {
                                                      setState(() {
                                                        if (textEditingController1
                                                                .text ==
                                                            '') {
                                                          maxquestionlenth =
                                                              500;
                                                        } else {
                                                          maxquestionlenth = 500 -
                                                              textEditingController1
                                                                  .text.length;
                                                        }
                                                      });
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .all(10),
                                                            hintText:
                                                                'Enter your question here',
                                                            border: InputBorder
                                                                .none),
                                                    maxLines: 5,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w,
                                                            vertical: 10.h),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromRGBO(
                                                              210, 201, 201, 1),
                                                      border: Border.all(
                                                        color: const Color
                                                            .fromRGBO(
                                                            210, 201, 201, 1),
                                                      ),
                                                    ),
                                                    width: double.infinity,
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          '${maxquestionlenth}/500',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13.sp),
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 19.h,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    askquestion = false;
                                                  });
                                                  HomePageCategoryAPI
                                                      .askQuestion(
                                                          context,
                                                          textEditingController1
                                                              .text,
                                                          widget.productid);
                                                           textEditingController1.text = '';
                                                  
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor),
                                                child: Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 17.h,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 19.h,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Related Products',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 19.h,
                                  ),
                                  SizedBox(
                                      height: 260.h,
                                      child: !dataloaded
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  relatedProductsdata.length,
                                              itemBuilder: (context, index) {
                                                final related =
                                                    relatedProductsdata[index];
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductDetailsPage(
                                                                  productid: related
                                                                      .id
                                                                      .toString(),
                                                                  productimage:
                                                                      related
                                                                          .image
                                                                          .toString(),
                                                                  name: related
                                                                      .title
                                                                      .toString(),
                                                                  productprice: related
                                                                      .variant_price
                                                                      .toString(),
                                                                  productDescription: related
                                                                      .description
                                                                      .toString(),
                                                                  variantType:
                                                                      related
                                                                          .variant_type,
                                                                  multiVariants:
                                                                      related
                                                                          .multipleVariants,
                                                                  productweight: related
                                                                      .variant_weight
                                                                      .toString(),
                                                                  wherefrom:
                                                                      'Home',
                                                                  variantColor:
                                                                      related
                                                                          .variant_color,
                                                                  variantMaterial:
                                                                      related
                                                                          .variant_material,
                                                                  variantSize:
                                                                      related
                                                                          .variant_size,
                                                                  variantStyle:
                                                                      related
                                                                          .variant_style,
                                                                  variantSKU:
                                                                      related
                                                                          .variant_SKU,
                                                                  parentChildSku:
                                                                      related
                                                                          .parentSKU_childSKU,
                                                                  variantqunatityStock:
                                                                      related
                                                                          .variant_quantity,
                                                                )));
                                                  },
                                                  child: RelatedProducts(
                                                      id: related.id,
                                                      image: related.image
                                                          .toString(),
                                                      name: related.title
                                                          .toString(),
                                                      price: related
                                                                  .variant_type ==
                                                              'single'
                                                          ? related
                                                              .variant_price
                                                              .toString()
                                                          : related
                                                              .multipleVariants[
                                                                  0]
                                                              .variant_price
                                                              .toString(),
                                                      gold: related
                                                          .parentSKU_childSKU
                                                          .toString()),
                                                );
                                              })),
                                  SizedBox(
                                    height: 5.h,
                                  )
                                ],
                              ),
                            ),
                          ]),
                    ),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 202.h,
                            child:
                                // user.role=='Store Owner'
                                // ElevatedButton(
                                //   onPressed: () {
                                //    // sendForApproval(context, 'updateCartItem', totalcount);
                                //   },
                                //   style: ElevatedButton.styleFrom(
                                //       backgroundColor: Theme.of(context).primaryColor,
                                //       shape: BeveledRectangleBorder(
                                //           side: const BorderSide(
                                //               color: Color.fromRGBO(210, 159, 73, 1)),
                                //           borderRadius: BorderRadius.circular(3.r))),
                                //   child: const Text(
                                //     "Update",
                                //     style: TextStyle(color: Colors.white),
                                //   ),
                                //)
                                widget.wherefrom == 'cart'
                                    ? const SizedBox()
                                    : ElevatedButton(
                                        onPressed: widget.variantType ==
                                                    'multiple' &&
                                                widget.wherefrom == 'Home' &&
                                                variantSkuFromAPI.isEmpty
                                            ? null
                                            : () {
                                                widget.wherefrom == 'Home'
                                                    ? sendForApproval(
                                                        context,
                                                        user.role == 'Store Owner'
                                                            ? 'add-to-cart'
                                                            : 'sendForApproval',
                                                        textEditingController
                                                            .text,
                                                        widget.productid,
                                                        widget.variantType!,
                                                        widget.variantType ==
                                                                'single'
                                                            ? widget
                                                                .variantSize!
                                                            : selectedSize,
                                                        widget.variantType ==
                                                                'single'
                                                            ? widget
                                                                .variantStyle!
                                                            : selectedStyle,
                                                        widget.variantType ==
                                                                'single'
                                                            ? widget
                                                                .variantMaterial!
                                                            : selectedMaterial,
                                                        widget.variantType ==
                                                                'single'
                                                            ? widget
                                                                .variantColor!
                                                            : selectedColorWithCode,
                                                        widget.variantType ==
                                                                'single'
                                                            ? widget
                                                                .productweight!
                                                                .toString()
                                                            : selectedWeight
                                                                .toString(),
                                                        widget.variantType ==
                                                                'single'
                                                            ? widget
                                                                .productprice!
                                                            : variantPrice1
                                                                .toString(),
                                                        widget.variantType ==
                                                                'single'
                                                            ? widget.variantSKU!
                                                            : variantSkuFromAPI,
                                                        widget.variantType ==
                                                                'single'
                                                            ? ''
                                                            : parentChildSkuFromAPI!)
                                                    : updateFromStoreOwner(
                                                        widget
                                                            .cartIdFromNotification
                                                            .toString(),
                                                        widget.productid,
                                                        textEditingController
                                                            .text,
                                                        widget.parentChildSku ??
                                                            '',
                                                        widget.variantSKU!);
                                              },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    color: Color.fromRGBO(
                                                        210, 159, 73, 1)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.r))),
                                        child: Text(
                                          widget.wherefrom == 'Home'
                                              ? "Add to Cart"
                                              : "Update",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                          ),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    )
                  ],
                ),
                Visibility(
                    visible: visbilityforAPISKU,
                    child: Container(
                      color: const Color.fromARGB(255, 176, 174, 174)
                          .withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  // redirect to whats app
  Future<void> whatsapp() async {
    try {
      const String phone =
          "+91 8680921000"; // International format with country code

      const String url = "https://wa.me/$phone";

      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Install whatsapp')));
    }
  }

// related products API
  Future<List<ProductsModel>> relatedProductsAPI() async {
    final response =
        await HomePageProdutsAPI.homePageAPI(context, 'products/new-arrived');
    return response;
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
      String parentchildSku) async {
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
        parentchildSku);
  }
// variants call

  void fetchvariants() async {
    if (widget.variantType != 'single' && widget.wherefrom == 'Home') {
      variantsMultiple =
          await HomePageCategoryAPI.getVariants(context, widget.productid);
      setState(() {});
    }

    reviewData = await HomePageCategoryAPI.review(context, widget.productid);
    setState(() {});
  }

// fetch product data after selecting the weight
  void fetchDataAfterSelectingTheWeight() async {
    visbilityforAPISKU = true;
    Map<String, dynamic> responsedata = await HomePageCategoryAPI.getSKU(
        context,
        widget.productid,
        selectedSize,
        selectedWeight,
        selectedMaterial,
        selectedColor,
        selectedStyle);
    multivariantsAfterweight =
        List<Map<String, dynamic>>.from(responsedata['multipleVariants']);
    print('\n');
    uniqueMaterials =
        getUniqueValues(multivariantsAfterweight, 'variant_material');
    uniqueColor = getUniqueValues(multivariantsAfterweight, 'variant_color');
    uniqueSize = getUniqueValues(multivariantsAfterweight, 'variant_size');
    uniqueStyle = getUniqueValues(multivariantsAfterweight, 'variant_style');

    setState(() {});
    print(uniqueMaterials);
    print('dddddddddddddddddddddddddddd');
    print(multivariantsAfterweight.length);

    visbilityforAPISKU = false;
    setState(() {});
  }

// get product after fetching data

  void fetchsku() async {
    visbilityforAPISKU = true;
    getDataAfterPassinAPI = await HomePageCategoryAPI.getSKU(
        context,
        widget.productid,
        selectedSize,
        selectedWeight,
        selectedMaterial,
        selectedColor,
        selectedStyle);

// // for handling the add to car button
    if (getDataAfterPassinAPI.isNotEmpty) {
      variantSkuFromAPI =
          getDataAfterPassinAPI['multipleVariants'][0]['variant_SKU'];
      parentChildSkuFromAPI = getDataAfterPassinAPI['multipleVariants'][0]
              ['parentSKU_childSKU'] ??
          '';
      variantPrice1 = getDataAfterPassinAPI['multipleVariants'][0]
              ['variant_price']
          .toString();
      if (selectedSize.isNotEmpty) {
        stockQuantityFromAPI = getDataAfterPassinAPI['multipleVariants'][0]
                ['variant_quantity']
            .toInt();
        print(stockQuantityFromAPI);
      }
      print(variantSkuFromAPI);
      print(parentChildSkuFromAPI);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('OOps Out of Stock,Please select different Variant'),
          backgroundColor: Colors.red));
    }
    visbilityforAPISKU = false;
    setState(() {});
  }

  /// to convert hex color
  int _hexcolor(String color) {
    String newColor = color.replaceAll('#', '');
    newColor = "0xff$newColor";
    int finalColor = int.parse(newColor);
    print(finalColor);
    return finalColor;
  }

  // to send the item to add as favourite
  Future<void> whislistAPI(String itemId) async {
    await WhishlistApi.whislistAPI(context, itemId);
  }

// to remove the item from the whislist
  Future<void> removewishlistItem(String itemId) async {
    await WhishlistApi.removewishlistItem(context, itemId);
  }

// notification update for store owner to purchase manager
  Future<void> updateFromStoreOwner(
      String cartIdFromNotification,
      String productid,
      String quantity,
      String parentSKUchildSKU,
      String variantSKU) async {
    await CartAPI.updateFromStoreOwner(context, cartIdFromNotification,
        productid, quantity, parentSKUchildSKU, variantSKU);
  }

  // Function to filter out duplicates based on multiple fields
  // list --> to set --> to list
  List<String> getUniqueValues(
      List<Map<String, dynamic>> variants, String attributeName) {
    return variants
        .map((variant) => variant[attributeName].toString())
        .toSet()
        .toList();
  }
}
