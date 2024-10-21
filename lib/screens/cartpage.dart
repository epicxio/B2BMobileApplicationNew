import 'package:coswan/models/cart_model.dart';
import 'package:coswan/screens/productdetailspage.dart';
import 'package:coswan/providers/cartprovider.dart';
import 'package:coswan/screens/addresselectionpage.dart';
import 'package:coswan/services/cart_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/widgets/cart_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //bool checked = false;
  int totalSelected = 0;
  List<int> selectedCheckboxIndices = [];
  int totalcount = 0;
  List<String> selectedCartId = [];
  List<CartModel> checkOutItems = [];
  String totalPrice = '';

  @override
  void initState() {
    CartAPI.fetchCartData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;

    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Container(
            decoration: const BoxDecoration(
              gradient: gradient,
            ),
            child:
                //  cart.isEmpty
                //     ? Center(
                //         child: CircularProgressIndicator(),
                //       )
                // :
                SafeArea(
              child: Scaffold(
                extendBody: true,
                resizeToAvoidBottomInset: false,

                appBar: AppBar(
                  forceMaterialTransparency: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'My  Cart Items',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  centerTitle: true,
                  actions: [
                    // Text(
                    //   '$totalSelected items selected',
                    //   style: TextStyle(
                    //       color: Theme.of(context).primaryColor,
                    //       fontSize: 16.sp,
                    //       fontWeight: FontWeight.w500),
                    // ),
                    SizedBox(
                      width: 23.h,
                    )
                  ],
                ),
                //bottom bar of the cart page
                bottomNavigationBar: Container(
                  padding: const EdgeInsets.only(left: 23, right: 23, top: 20),
                  height: 100.h,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r))),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: checkOutItems.isEmpty
                                ? null
                                : () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddresselectionPage(
                                                    checkoutproduct:
                                                        checkOutItems)));
                                  },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r))),
                            child: Center(
                              child: Text(
                                'Proceed to Order',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                backgroundColor: Colors.transparent,
                body: cart.isEmpty
                    ? const Center(
                        child: Text('No items in cart'),
                      )
                    : ListView.separated(

                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 5.h,
                        ),
                        itemCount: cart.length,
                        separatorBuilder: (context,index){
                          return  SizedBox(height: 15.h);

                        },
                        itemBuilder: (context, index) {
                          final cartIndex = cart[index];
                          //  int totalcount = cart[index]['quantity'];
                          bool isSelected =
                              selectedCheckboxIndices.contains(index);
                          //   textEditingController  = TextEditingController(text: cart[index]['quantity'].toString());
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => ProductDetailsPage(
                                        variantqunatityStock:
                                            cartIndex.product_quantity,
                                        productid:
                                            cartIndex.productId.toString(),
                                        productimage:
                                            cartIndex.image.toString(),
                                        name: cartIndex.title.toString(),
                                        // productSku: cartIndex.sku.toString(),
                                        productprice:
                                            cartIndex.variant_price.toString(),
                                        productDescription:
                                            cartIndex.description.toString(),
                                        productweight:
                                            cartIndex.variant_weight.toString(),
                                        wherefrom: 'cart',
                                        variantColor:
                                            cartIndex.variant_color.toString(),
                                        variantMaterial: cartIndex
                                            .variant_material
                                            .toString(),
                                        variantSKU:
                                            cartIndex.variant_SKU.toString(),
                                        variantSize:
                                            cartIndex.variant_size.toString(),
                                        parentChildSku: cartIndex
                                            .parentSKU_childSKU
                                            .toString(),
                                        variantStyle:
                                            cartIndex.variant_style.toString(),
                                        variantType:
                                            cartIndex.variant_type.toString(),
                                        quantityFromNotification: cartIndex
                                            .variant_quantity
                                            .toString(),
                                      ))));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: SizedBox(
                                // height: 210.h,
                                child: Slidable(
                                  endActionPane: ActionPane(
                                      extentRatio: 0.25,
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          borderRadius: BorderRadius.circular(10.r),
                                          backgroundColor: Colors.red,
                                          icon: Icons.delete_outline,
                                          label: 'delete',
                                          onPressed: (dire) {
                                            selectedCheckboxIndices.clear();
                                            checkOutItems.clear();
                                            removeCartItem(cartIndex.id.toString());
                                          },
                                        )
                                      ]),
                                  child: Stack(
                                    children: [
                                      CartContainer(
                                        index: index,
                                        productId:
                                            cartIndex.productId.toString(),
                                        image: cartIndex.image.toString(),
                                        price:
                                            cartIndex.variant_price.toString(),
                                        qunatity:
                                            cartIndex.variant_quantity.toInt(),
                                        status: cartIndex.status.toString(),  
                                        title: cartIndex.title.toString(),
                                        weight:
                                            cartIndex.variant_weight.toString(),
                                        cartId: cartIndex.id.toString(),
                                        parentSKUchildSKU:
                                            cartIndex.parentSKU_childSKU,
                                        variantSKU: cartIndex.variant_SKU,
                                      ),

                                      //  To delete  the products in the cart

                                      Positioned(
                                        top: 1,
                                        right: 1,
                                        child: Checkbox(
                                            // checkbox to select the product
                                            value: isSelected,
                                            onChanged: cartIndex.status !=
                                                    'Approved'
                                                ? null
                                                : (value) {
                                                    setState(() {
                                                      if (value!) {
                                                        // selecting the multiple products for checkout
                                                        checkOutItems
                                                            .add(cartIndex);
                                                        print(checkOutItems);

                                                        // If checkbox is selected, add index to selectedCheckboxIndices
                                                        selectedCartId
                                                            .add(cartIndex.id);
                                                        selectedCheckboxIndices
                                                            .add(index);
                                                        print(selectedCartId);
                                                        totalSelected++;
                                                        //   totalPriceAPI();
                                                      } else {
                                                        /// deselecting the multiple produts from checkout
                                                        checkOutItems.remove(
                                                            cart[index]);
                                                        print(checkOutItems);

                                                        // If checkbox is unselected, remove index from selectedCheckboxIndices

                                                        selectedCartId.remove(
                                                            cartIndex.id);
                                                        print(selectedCartId);
                                                        // totalPriceAPI();
                                                        selectedCheckboxIndices
                                                            .remove(index);
                                                        totalSelected--;
                                                      }
                                                    });
                                                  }),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            )),
      ),
    );
  }

// to remove the item from the cart
  Future<void> removeCartItem(String itemId) async {
    await CartAPI.removeCartItem(context, itemId);
  }
}
