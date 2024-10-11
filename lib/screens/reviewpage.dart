import 'dart:io';
import 'package:coswan/services/review_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/widgets/ereceiptproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ReviewPage extends StatefulWidget {
  final String image;
  final String title;
  final String size;
  final String quantity;
  final String productId;

  final String price;
  const ReviewPage({
    super.key,
    required this.image,
    required this.title,
    required this.size,
    required this.quantity,
    required this.price,
    required this.productId,
  });

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late TextEditingController txtcontoller;
  double orderrate = 0;
  List<File>? imageFile = [];
  List<File>? videoFile = [];

  @override
  void initState() {
    txtcontoller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    txtcontoller.dispose();
    super.dispose();
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
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios)),
              title: const Text(
                'Leave Review',
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r))),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (orderrate > 0.5) {
                        ReviewApi.review(
                          context,
                          orderrate.toString(),
                          txtcontoller.text,
                          widget.productId,
                          imageFile!.isNotEmpty ? imageFile![0] : null,
                          videoFile!.isNotEmpty ? videoFile![0] : null,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Choose Your Rating',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                            duration: Durations.extralong2,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r))),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: EReceiptProductList(
                            image: widget.image,
                            price: widget.price,
                            quantity: widget.quantity,
                            size: widget.size,
                            title: widget.title,
                          )),
                      SizedBox(
                        height: 8.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Divider(
                          color: const Color.fromRGBO(230, 222, 222, 1),
                          height: 10.h,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'How is your Order?',
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Your overall rating ${_rating()} ',
                        style: TextStyle(
                            color: const Color.fromRGBO(166, 163, 163, 1),
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      RatingBar.builder(
                        itemCount: 5,
                        glowColor: Theme.of(context).primaryColor,
                        allowHalfRating: true,
                        initialRating: orderrate,
                        onRatingUpdate: (valu) {
                          setState(() {
                            orderrate = valu;
                            print(orderrate);
                          });
                        },
                        itemBuilder: (context, index) {
                          return Icon(
                            Icons.stars_rounded,
                            color: Theme.of(context).primaryColor,
                          );
                        },
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Divider(
                          color: const Color.fromRGBO(230, 222, 222, 1),
                          height: 10.h,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                  Text(
                    'Add detailed review',
                    style:
                        TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizedBox(
                    width: 385.w,
                    height: 150.h,
                    child: TextFormField(
                      controller: txtcontoller,
                      maxLines: 10,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(222, 222, 222, 1),
                            ),
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(222, 222, 222, 1),
                              ),
                              borderRadius: BorderRadius.circular(3.r)),
                          hintText: 'Enter comments here',
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                     onTap: () {
                          pickImage();
                        },
                    child: SizedBox(
                      child: Column(
                        children: [
                          Row( 
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.camera_alt_outlined),
                              SizedBox(
                                width: 10.w,
                              ),
                              FittedBox(
                                child: Text(
                                  'Add Photo',
                                  style: TextStyle(
                                      fontSize: 17.sp, fontWeight: FontWeight.w500),
                                ),
                              ),
                              // SizedBox(
                              //   width: 145.w,
                              // ),
                              // Image.asset('assets/icons/ic_videoReview.png'),
                              // SizedBox(
                              //   width: 10.w,
                              // ),
                              // GestureDetector(
                              //   onTap: () {
                              //     pickvideo();
                              //   },
                              //   child: Text(
                              //     'Add Video',
                              //     style: TextStyle(
                              //         fontSize: 17.sp, fontWeight: FontWeight.w500),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: imageFile!.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: imageFile!.length,
                                itemBuilder: (context, index) {
                                  return Image.file(
                                    imageFile![index],
                                    width: 100.w,
                                    height: 100.h,
                                    fit: BoxFit.fill,
                                  );
                                })
                            : null,
                      ),
                      SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: videoFile!.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: videoFile!.length,
                                itemBuilder: (context, index) {
                                  File file = videoFile![index];
                                  return FutureBuilder(
                                      future: _initializeVideoPlayer(file),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return AspectRatio(
                                            aspectRatio: snapshot
                                                .data!.value.aspectRatio,
                                            child: VideoPlayer(snapshot.data!),
                                          );
                                        } else {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      });
                                })
                            : null,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<VideoPlayerController> _initializeVideoPlayer(File file) async {
    final controller = VideoPlayerController.file(file);
    await controller.initialize();
    // controller.setLooping(true); // Optional: Loop the video
    //  controller.play(); // Optional: Auto-play the video
    return controller;
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final selectedImages = await picker.pickImage(
        source: ImageSource.camera,
      );
      if (selectedImages == null) return;
      final tempImage = File(selectedImages.path);

      setState(() {
        imageFile!.add(tempImage);
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> pickvideo() async {
    try {
      final ImagePicker picker = ImagePicker();
      final selectedvideos = await picker.pickVideo(
        source: ImageSource.camera,
      );
      if (selectedvideos == null) return;
      final tempvideo = File(selectedvideos.path);
      print(tempvideo);

      setState(() {
        videoFile!.add(tempvideo);
        print(videoFile);
      });
    } catch (e) {
      rethrow;
    }
  }

  String? _rating() {
    if (orderrate == 0) {
      return '';
    }  if ( orderrate > 0  && orderrate <= 2) {
      return ": Poor";
    } else if ( orderrate >2&& orderrate <= 3) {
      return ": Average";
    } else if ( orderrate>3 && orderrate <= 4) {
      return " : Good";
    } else if ( orderrate > 4) {
      return ": Excellent";
    }
  
    return ''; // Return null for any other case
  }
  
}
