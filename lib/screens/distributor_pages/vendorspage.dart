import 'package:coswan/providers/vendor_provider.dart';
import 'package:coswan/services/vendor_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({super.key});

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage> {
  bool isloading = true;
  @override
  void initState() {
    // vendorsAPI().then((value) {
    //   setState(() {
    //     vendorsData = value;
    //     isloading = false;
    //     print(vendorsData);
    //   });
    // });
    setState(() {
      VendorApi.vendorAPI(context);
      isloading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vendorsData = Provider.of<VendorProvider>(context).vendorlist;
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(gradient: gradient),
          child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              forceMaterialTransparency: true,
              title: Text(
                'My Vendors',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
            ),
            body: isloading
                ? const  Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.h),
                    child: ListView.separated(
                        itemCount: vendorsData.length,
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10.h,
                            ),
                        itemBuilder: (context, index) {
                          final vendor = vendorsData[index];
                          return Container(
                            
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 12.h),
                            // height: 200.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(206, 148, 56, 1))),
                            child: Column(
                              
                              children: [
                                Row(
                                 // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Image.asset(
                                    //   'assets/images/LakshmiPicture.png',
                                    //   width: 100.w,
                                    //   height: 100.h,
                                    // ),

                                    ProfilePicture(
                                      fontsize: 50.sp,
                                      name: vendor.storename,
                                      radius: 50,
                                      img: null,
                                      random: true,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vendor.storename,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 7.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            SizedBox(
                                              width: 200.w,
                                              child: Text(
                                                vendor.address,
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_city,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Text(
                                              vendor.city,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            vendorsAPIDelete(vendor.id);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w, vertical: 5.h),
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          253, 3, 14, 1)),
                                                  borderRadius:
                                                      BorderRadius.circular(3.r)),
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      255, 227, 195, 1)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                  'assets/icons/ic_vendorDelete.png'),
                                              SizedBox(
                                                width: 10.h,
                                              ),
                                              Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        184, 41, 47, 1),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          )),
                                      SizedBox(
                                        width: 14.w,
                                      ),
                                      ElevatedButton(
                                          onPressed: null,
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w, vertical: 5.h),
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          15, 157, 12, 1)),
                                                  borderRadius:
                                                      BorderRadius.circular(3.r)),
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      15, 157, 12, 1)),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  'assets/icons/ic_phoneCall.png'),
                                              SizedBox(
                                                width: 10.h,
                                              ),
                                              Text(
                                                'Call',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          )),
                                      SizedBox(
                                        width: 14.w,
                                      ),
                                      ElevatedButton(
                                          onPressed: null,
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w, vertical: 5.h),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(3.r)),
                                              backgroundColor:
                                                  Theme.of(context).primaryColor),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  'assets/icons/ic_vendorChat.png'),
                                              SizedBox(
                                                width: 10.h,
                                              ),
                                              Text(
                                                'Chat',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> vendorsAPIDelete(String vendorId) async {
    await VendorApi.vendorsAPIDelete(context, vendorId);
  }
}
