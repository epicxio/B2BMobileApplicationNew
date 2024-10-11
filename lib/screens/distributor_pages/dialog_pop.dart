import 'dart:io';
import 'package:coswan/services/order_distributor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class DialogPop extends StatefulWidget {
  final String field;
  final String quantity;
  final String pageendPoint;
  final String cartId;
  final String transactionId;
  const DialogPop(
      {super.key,
      required this.field,
      required this.quantity,
      required this.pageendPoint,
      required this.transactionId,
      required this.cartId});

  @override
  State<DialogPop> createState() => _DialogPopState(); 
}

class _DialogPopState extends State<DialogPop> {
  late TextEditingController textEditingController;
  late TextEditingController commentController;
  List<File>? imagepick = [];
  @override
  void initState() {
    textEditingController =
        TextEditingController(text: widget.quantity.toString());
    commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(),
      child: IntrinsicWidth(
        child: widget.field == 'In-Progress'
            ? SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(211, 204, 204, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.field),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.close)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Container(
                            width: 105.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50.r),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (int.parse(
                                              textEditingController.text) >=
                                          1) {
                                        int total = int.parse(
                                            textEditingController.text);
                                        total -= 1;

                                        textEditingController.text =
                                            total.toString();
                                      } else {
                                        textEditingController.text =
                                            1.toString();
                                      }
                                    });
                                  },
                                  child: Icon(Icons.remove_circle_outline_sharp,
                                      size: 30,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Expanded(
                                  // height: 20.h,
                                  // width: 50.w,
                                  child: TextFormField(
                                    ///  initialValue: widget.qunatity.toString(),
                                    onChanged: (value) {
                                      setState(() {
                                        //   totalcount = int.parse(value);
                                        //  print(totalcount);
                                        textEditingController.text =
                                            int.parse(value).toString();
                                      });
                                    },
                                    onFieldSubmitted: (value) {
                                      if (value.isEmpty) {
                                        setState(() {
                                          textEditingController.text = '1';
                                        });
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    controller: textEditingController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 7.w),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      int total =
                                          int.parse(textEditingController.text);
                                      total += 1;
                                      textEditingController.text =
                                          total.toString();
                                      print(total);
                                    });
                                  },
                                  child: Icon(
                                    Icons.add_circle_outline_rounded,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 72.w,
                        ),
                        Text(
                          'Remaining Quantity : ${int.parse(widget.quantity) - int.parse(textEditingController.text)}',
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'comment',
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            height: 63.h,
                            width: 230.w,
                            padding: EdgeInsets.only(right: 10.w),
                            child: TextFormField(
                              controller: commentController,
                              maxLines: 5,
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w400),
                              decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              190, 188, 188, 1)))),
                            ),
                          ),
                        ],
                      ),
                    ),
                     imagepick!.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 110.h,
                            child: Stack(
                              children: [
                                ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: imagepick!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(3.r),
                                              child: SizedBox(
                                                height: 100.h,
                                                width: 100.w,
                                                child: Image.file(
                                                  imagepick![index],
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                           
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(211, 204, 204, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                            CircleAvatar(
                       backgroundColor: Theme.of(context).primaryColor,
                      
                       child: Center(
                         child: IconButton(
                           onPressed: () {
                           pickImageForStatusUpdate();
                           },
                           icon:  Icon(
                             Icons.camera_alt_outlined,
                             size: 30.r,
                           ),
                           color: Colors.white,
                         ),
                       ),
                     ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(2.r))),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(119, 117, 117, 1),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                print(widget.pageendPoint);
                                print(widget.field);

                                orderStatusUpdate(
                                    widget.cartId,
                                    widget.field,
                                    widget.field,
                                    commentController.text,
                                    textEditingController.text);},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(2.r))),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              )),
                             
                        ],
                      ),
                    ),
                   
                  ],
                ),
              )
            : SizedBox(
                height: 190.h,
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(211, 204, 204, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.field),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.close)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'comment',
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SizedBox(
                            height: 63.h,
                            width: 230.w,
                            child: TextFormField(
                              controller: commentController,
                              maxLines: 5,
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w400),
                              decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              190, 188, 188, 1)))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(211, 204, 204, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(2.r))),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(119, 117, 117, 1),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                print(widget.pageendPoint);
                                print(widget.field);

                                orderStatusUpdate(
                                    widget.cartId,
                                    widget.field,
                                    widget.field,
                                    commentController.text,
                                    textEditingController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(2.r))),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

Future<void> pickImageForStatusUpdate() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? selectedImage =
          await imagePicker.pickImage(source: ImageSource.camera);
      if (selectedImage == null) return;
      final tempImage = File(selectedImage.path);
      setState(() {
        imagepick!.add(tempImage);
      });
    } catch (e) {
      rethrow;
    }
  }
  Future<void> orderStatusUpdate(String cartId, String status, String toastmsg,
      String comment, String variantQuantity) async {
    await OrderDistributor.orderStatusUpdate(
        context,
        cartId,
        status,
        toastmsg,
        widget.pageendPoint,
        comment,
        variantQuantity,
        (int.parse(widget.quantity) - int.parse(textEditingController.text))
            .toString(),
        widget.transactionId,
        null);
  }
}
