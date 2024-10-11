import 'package:coswan/providers/distributor_order_provider.dart';
import 'package:coswan/screens/distributor_pages/dialog_pop.dart';
import 'package:coswan/screens/distributor_pages/order_details_page.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OrderStatusContainer extends StatefulWidget {
  final String statusvalue;
  final String pageendPoint;
  const OrderStatusContainer(
      {super.key, required this.pageendPoint, required this.statusvalue});

  @override
  State<OrderStatusContainer> createState() => _OrderStatusContainerState();
}

class _OrderStatusContainerState extends State<OrderStatusContainer> {
  @override
  Widget build(BuildContext context) {
    final txtstyle = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);
    const satusBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(130, 130, 130, 1)));
    final orderDistributor =
        Provider.of<DistributorOrderProvider>(context).newOrder;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Provider.of<DistributorOrderProvider>(context).dataloading

          //  Provider.of<DistributorOrderProvider>(context).dataloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orderDistributor.length,
              itemBuilder: ((context, index) {
                final data = orderDistributor[index];

                return orderDistributor.isEmpty
                    ? const SizedBox()
                    : SizedBox(
                        //height: 150.h,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Image.network(
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/coswanlogo.png',
                                              height: 74.h,
                                              width: 83.w,
                                            );
                                          },
                                          data.image.toString(),
                                          height: 80.h,
                                          width: 83.w,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 37.h,
                                      ),
                                      Text(
                                        'Status',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.title,
                                        style: txtstyle,
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      SizedBox(
                                        width: 250.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₹ ${data.variant_price}',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              'OrderID : ${data.order_Id}',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      SizedBox(
                                        width: 250.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h,
                                                  horizontal: 10.w),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(50.r),
                                              ),
                                              child: Text(
                                                data.storeName ??
                                                    'Unknown Store', // Provide a default value
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderDetailsPage(
                                                              transactionId: data
                                                                  .transactionId,
                                                              role: data.role,
                                                              status:
                                                                  data.status,
                                                              weight: data
                                                                  .variant_weight
                                                                  .toString(),
                                                              size: data
                                                                  .variant_size
                                                                  .toString(),
                                                              orderID: data
                                                                  .order_Id
                                                                  .toString(),
                                                              address:
                                                                  data.address,
                                                              date: data.date,
                                                              email: data.email,
                                                              price: data
                                                                  .variant_price
                                                                  .toString(),
                                                              quantity: data
                                                                  .variant_quantity
                                                                  .toString(),
                                                              cartID:
                                                                  data.cartId,
                                                              title: data.title,
                                                              image: data.image,
                                                              tobeDone: widget
                                                                  .statusvalue,
                                                              pageendPoint: widget
                                                                  .pageendPoint,
                                                                  remainingQuantity:data.remainingQuantity ,
                                                            )));
                                              },
                                              child: SizedBox(
                                                child: FittedBox(
                                                  child: Text(
                                                    'View Details',
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      SizedBox(
                                        width: 250.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Weight : ${data.variant_weight} grams',
                                              style: txtstyle,
                                            ),
                                            Text(
                                              'Qty : ${data.variant_quantity} Pcs',
                                              style: txtstyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 8.h,
                                      // ),
                                      // Text(
                                      //   'Size:',
                                      //   style: txtstyle,
                                      // ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      SizedBox(
                                        width: 250.w,
                                        height: 35.h,
                                        child: widget.statusvalue ==
                                                    'completed' ||
                                                widget.statusvalue ==
                                                    'cancelled'
                                            ? Text(captilizeFirstLetter(
                                                widget.statusvalue))
                                            : DropDownTextField(
                                                clearOption: false,
                                                padding: EdgeInsets.all(5.w),
                                                listPadding: ListPadding(
                                                    top: 10.h, bottom: 10.h),
                                                key: ValueKey(data.cartId),
                                                textFieldDecoration:
                                                    InputDecoration(
                                                       contentPadding:
                                                            EdgeInsets.only(
                                                                left: 10.w,
                                                                bottom: 18.h),
                                                        hintText:
                                                            'Select From List ',
                                                        hintStyle: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: const Color
                                                                .fromRGBO(132,
                                                                128, 128, 1)),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        border:
                                                            InputBorder.none),
                                                searchDecoration:
                                                    InputDecoration(
                                                        floatingLabelStyle:
                                                            TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                        focusedBorder:
                                                            satusBorder,
                                                        enabledBorder:
                                                            satusBorder),
                                                isEnabled: true,
                                                dropDownList: [
                                                  DropDownValueModel(
                                                      name: widget.statusvalue,
                                                      value:
                                                          widget.statusvalue),
                                                  const DropDownValueModel(
                                                      name: 'Cancelled',
                                                      value: 'Cancelled')
                                                ],
                                                onChanged: (field) {
                                                  print(field.name);
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          DialogPop(
                                                            transactionId: data
                                                                .transactionId,
                                                            field: field.value,
                                                            quantity: data
                                                                .variant_quantity
                                                                .toString(),
                                                            pageendPoint: widget
                                                                .pageendPoint,
                                                            cartId: data.cartId,
                                                          ));
                                                },
                                              ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Divider(
                                height: 0.h,
                              ),
                            ],
                          ),
                        ),
                      );
              })),
    );
  }

  String captilizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
