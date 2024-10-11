import 'package:coswan/models/products_model.dart';
import 'package:coswan/screens/filterpage.dart';
import 'package:coswan/screens/whislist.dart';
import 'package:coswan/providers/whislist_provider.dart';
import 'package:coswan/services/grid_view_and_custom_category.dart';
import 'package:coswan/widgets/gridfiltersbtmsheet.dart';
import 'package:coswan/providers/cartprovider.dart';
import 'package:coswan/screens/cartpage.dart';
import 'package:coswan/screens/productdetailspage.dart';
import 'package:coswan/widgets/gridviewcontainer.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GridViewHomePage extends StatefulWidget {
  const GridViewHomePage(
      {super.key,
      //required this.relatedproduct,
      //  required this.productdata,
      required this.appbartitletext,
      required this.customcategoryvalue});

  @override
  State<GridViewHomePage> createState() => _GridViewHomePageState();
  final String appbartitletext;
  final String customcategoryvalue;
  //
  // final List<Map<String, dynamic>> relatedproduct;
}

class _GridViewHomePageState extends State<GridViewHomePage> {
  late List<ProductsModel> productdata;
  bool dataloaded = false;
  @override
  void initState() {
    fetchInitData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              forceMaterialTransparency: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                widget.appbartitletext,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor),
              ),
              actions: [
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
                  width: 15.w,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()));
                    },
                    child: Provider.of<CartProvider>(context).cart.isNotEmpty
                        ? Badge(
                            backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
                            label: Text(
                                '${Provider.of<CartProvider>(context).cart.length}'),
                            child: const Icon(Icons.shopping_cart_outlined),
                          )
                        : const Icon(Icons.shopping_cart_outlined)),
                SizedBox(
                  width: 15.w,
                )
              ],
            ),
            backgroundColor: Colors.transparent,
            bottomNavigationBar: Container(
              width: double.minPositive,
              color: Theme.of(context).primaryColor,
              height: 54.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FilterPage(
                                  title: widget.appbartitletext,
                                )));
                      },
                      child: Row(
                        children: [
                          Image.asset('assets/icons/ic_list.png'),
                          SizedBox(
                            width: 9.h,
                          ),
                          Text(
                            'Filters',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            constraints: const BoxConstraints(
                              maxHeight: double.maxFinite,
                            ),
                            context: context,
                            builder: (context) => GridModalSheet(
                                  title: widget.appbartitletext,
                                ));
                      },
                      child: SizedBox(
                        child: Row(
                          children: [
                            Image.asset('assets/icons/ic_sort.png'),
                            SizedBox(
                              width: 9.w,
                            ),
                            Text(
                              'Sort',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: !dataloaded
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : productdata.isEmpty
                    ? Center(
                        child: Text(
                        'No Products in the category',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ))
                    : SafeArea(
                        child: RefreshIndicator(
                          onRefresh: onRefresh,
                          triggerMode: RefreshIndicatorTriggerMode.anywhere,
                          child: GridView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              shrinkWrap: true,
                              itemCount: productdata.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 285.h,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                final product = productdata[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsPage(
                                                  productid:
                                                      product.id.toString(),
                                                  productimage:
                                                      product.image.toString(),
                                                  name:
                                                      product.title.toString(),
                                                  productprice: product
                                                      .variant_price
                                                      .toString(),
                                                  productDescription: product
                                                      .description
                                                      .toString(),
                                                  variantType:
                                                      product.variant_type,
                                                  multiVariants:
                                                      product.multipleVariants,
                                                  productweight: product
                                                      .variant_weight
                                                      .toString(),
                                                  wherefrom: 'Home',
                                                  variantColor:
                                                      product.variant_color,
                                                  variantMaterial:
                                                      product.variant_material,
                                                  variantSize:
                                                      product.variant_size,
                                                  variantStyle:
                                                      product.variant_style,
                                                  variantSKU:
                                                      product.variant_SKU,
                                                  parentChildSku: product
                                                      .parentSKU_childSKU,
                                                  variantqunatityStock:
                                                      product.variant_quantity,
                                                )));
                                  },
                                  child: GridViewContainer(
                                    id: product.id.toString(),
                                    image: product.image.toString(),
                                    name: product.title.toString(),
                                    price: product.variant_price.toString(),
                                    weight: product.variant_weight.toString(),
                                    variantType: product.variant_type,
                                    multiVariants: product.multipleVariants,
                                    variantColor: product.variant_color,
                                    variantMaterial: product.variant_material,
                                    variantqunatityStock:
                                        product.variant_quantity.toString(),
                                    variantPrice:
                                        product.variant_price.toString(),
                                    variantSize: product.variant_size,
                                    variantStyle: product.variant_style,
                                    variantSKU: product.variant_SKU,
                                    parentChildSKU: product.parentSKU_childSKU,
                                  ),
                                );
                              }),
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  // data loading
  fetchInitData() async {
    productdata = await getproduct(widget.customcategoryvalue);
    setState(() {
      dataloaded = true;
    });
  }

// to refresh  the page
  Future<void> onRefresh() async {
    dataloaded = false;
    setState(() {});
    productdata = await getproduct(widget.customcategoryvalue);
    setState(() {
      dataloaded = true;
    });
  }

  Future<List<ProductsModel>> getproduct(String urlString) async {
    final response = await QueryParamsApi.getproduct(context, urlString);
    return response;
  }
}
