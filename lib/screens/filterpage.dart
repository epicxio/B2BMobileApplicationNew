import 'package:coswan/screens/gridviewhomepage.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterPage extends StatefulWidget {
  final String title;
  const FilterPage({super.key, required this.title});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedType = '';
  String selectedgender = '';
  String selectedSort = '';
  double lowerPriceValue = 1000.0;
  double upperPriceVAlue = 50000.0;
  int ratingValue = 0;
  int selectedrating = 0;

  final txtstyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
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
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                forceMaterialTransparency: true,
                title: Text(
                  'Filter',
                  style: txtstyle,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const  Icon(Icons.arrow_back_ios),
                  onPressed:(){
                    Navigator.pop(context);
                  } ,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Brands',
                      style: txtstyle,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildtype('All', 'All'),
                        _buildtype('Rings', 'ring'),
                        _buildtype('Necklace', 'neckalce'),
                        _buildtype('Chains', 'chains')
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      'Gender',
                      style: txtstyle,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildgender('All', 'All'),
                        SizedBox(
                          width: 20.w,
                        ),
                        _buildgender('Male', 'male'),
                        SizedBox(
                          width: 10.w,
                        ),
                        _buildgender('Female', 'female'),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      'Sort by',
                      style: txtstyle,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSortBy('Popular', 'Popular'),
                        _buildSortBy('Most Recent', 'Most Recent'),
                        _buildSortBy('Price High', 'Price High')
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      'Price Range',
                      style: txtstyle,
                    ),
                    RangeSlider(
                        inactiveColor: Colors.white,
                        min: 0.0,
                        max: 50000,
                        values: RangeValues(lowerPriceValue, upperPriceVAlue),
                        onChanged: (values) {
                          setState(() {
                            lowerPriceValue = values.start;
                            upperPriceVAlue = values.end;
                          });
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lowerPriceValue.toInt().toString(),
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          upperPriceVAlue.toInt().toString(),
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      'Reviews',
                      style: txtstyle,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_halfStar.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                '4.5 and above',
                                style: txtstyle,
                              ),
                            ],
                          ),
                          Radio(
                              value: 1,
                              groupValue: selectedrating,
                              onChanged: (valu) {
                                setState(() {
                                  setState(() {
                                    selectedrating = valu!.toInt();
                                  });
                                });
                              })
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_nostar.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                '4.0 - 4.5',
                                style: txtstyle,
                              ),
                            ],
                          ),
                          Radio(
                              value: 2,
                              groupValue: selectedrating,
                              onChanged: (valu) {
                                setState(() {
                                  selectedrating = valu!.toInt();
                                });
                              })
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_halfStar.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_nostar.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                '3.5 - 4.0',
                                style: txtstyle,
                              ),
                            ],
                          ),
                          Radio(
                              value: 3,
                              groupValue: selectedrating,
                              onChanged: (valu) {
                                setState(() {
                                  selectedrating = valu!.toInt();
                                });
                              })
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_star.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_nostar.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset('assets/icons/ic_nostar.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                '3.0 - 3.5',
                                style: txtstyle,
                              ),
                            ],
                          ),
                          Radio(
                              value: 4,
                              groupValue: selectedrating,
                              onChanged: (valu) {
                                setState(() {
                                  selectedrating = valu!.toInt();
                                });
                              })
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/icons/ic_star.png'),
                            SizedBox(
                              width: 10.w,
                            ),
                            Image.asset('assets/icons/ic_star.png'),
                            SizedBox(
                              width: 10.w,
                            ),
                            Image.asset('assets/icons/ic_nostar.png'),
                            SizedBox(
                              width: 10.w,
                            ),
                            Image.asset('assets/icons/ic_nostar.png'),
                            SizedBox(
                              width: 10.w,
                            ),
                            Image.asset('assets/icons/ic_nostar.png'),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '3.0 - 2.5',
                              style: txtstyle,
                            ),
                          ],
                        ),
                        Radio(
                            value: 5,
                            groupValue: selectedrating,
                            onChanged: (valu) {
                              setState(() {
                                selectedrating = valu!.toInt();
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedType = '';
                                selectedgender = '';
                                selectedSort = '';
                                lowerPriceValue = 1000.0;
                                upperPriceVAlue = 50000.0;
                                ratingValue = 0;
                                selectedrating = 0;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.w, vertical: 10.h)),
                            child: Text(
                              'Reset Filter',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: ((context) => GridViewHomePage(
                                          appbartitletext: widget.title,
                                          customcategoryvalue:
                                              '${APIRoute.route}/products/filter?title=${widget.title}&custom_category=$selectedType&gender=$selectedgender&minPrice=$lowerPriceValue&maxPrice=$upperPriceVAlue'))));
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r)),
                                backgroundColor: Theme.of(context).primaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.w, vertical: 10.h)),
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildtype(
    String title,
    String category,
  ) {
    return ChoiceChip(
      showCheckmark: false,
      label: Text(
        title,
        style: TextStyle(
            color: selectedType == category ? Colors.white : Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      disabledColor: Colors.white,
      selectedColor: Theme.of(context).primaryColor,
      selected: selectedType == category,
      onSelected: (boolVal) {
        setState(() {
          if (boolVal) {
            selectedType = category;
            print(selectedType);
          }
        });
      },
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color.fromRGBO(189, 189, 189, 1)),
          borderRadius: BorderRadius.circular(30.r)),
    );
  }

  Widget _buildgender(
    String title,
    String category,
  ) {
    return ChoiceChip(
      showCheckmark: false,
      label: Text(
        title,
        style: TextStyle(
            color: selectedgender == category ? Colors.white : Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      disabledColor: Colors.white,
      selectedColor: Theme.of(context).primaryColor,
      selected: selectedgender == category,
      onSelected: (boolVal) {
        setState(() {
          if (boolVal) {
            selectedgender = category;
            print(selectedgender);
          }
        });
      },
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color.fromRGBO(189, 189, 189, 1)),
          borderRadius: BorderRadius.circular(30.r)),
    );
  }

  Widget _buildSortBy(
    String title,
    String category,
  ) {
    return ChoiceChip(
      showCheckmark: false,
      label: Text(
        title,
        style: TextStyle(
            color: selectedSort == category ? Colors.white : Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      disabledColor: Colors.white,
      selectedColor: Theme.of(context).primaryColor,
      selected: selectedSort == category,
      onSelected: (boolVal) {
        setState(() {
          if (boolVal) {
            selectedSort = category;
            print(selectedSort);
          }
        });
      },
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color.fromRGBO(189, 189, 189, 1)),
          borderRadius: BorderRadius.circular(30.r)),
    );
  }

  // Future<void> filterAPI() async {
  //   // Navigator.of(context);
  //   final userprovider = Provider.of<UserProvider>(context, listen: false);
  //   try {
  //     final url =
  //         '${APIRoute.route}/products/filter?title=${widget.title}&custom_category=$selectedType&gender=$selectedgender&minPrice=$lowerPriceValue&maxPrice=$upperPriceVAlue';
  //     final uri = Uri.parse(url);
  //     print(url);
  //     final res = await http.get(uri, headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer ${userprovider.token}'
  //     });
  //     if(res.statusCode==200){
  //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> GridViewHomePage(
  //         appbartitletext:widget.title , customcategoryvalue: customcategoryvalue)))
  //     }
  //     print(res.statusCode);
  //     print(res.body);
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
