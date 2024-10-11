import 'package:coswan/models/cart_model.dart';
import 'package:coswan/services/address_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AddDeliveryAddress extends StatefulWidget {
  final List<CartModel> checkoutproduct;
  const AddDeliveryAddress({super.key, required this.checkoutproduct});

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  Position? currentLocation;

  String currentAddress = '';
  String state = '';
  String city = '';
  bool loading = true;
  bool cityLoading = true;
  bool isSelectedHome = false;
  bool isSelectedWork = false;
  late List<String> stateFromAPI;
  late List<String> cityFromAPI;
  late String typeOfAddress;
  late TextEditingController fullName;
  late TextEditingController houseNo;
  late TextEditingController phoneNo;
  late TextEditingController landMark;
  late TextEditingController roadName;
  late TextEditingController pinCode;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final errorborder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.r),
      borderSide: const BorderSide(color: Colors.red));
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(3.r)),
    borderSide: const BorderSide(
      color: Color.fromRGBO(203, 213, 225, 1),
    ),
  );

  @override
  void initState() {
    fetch();
    fullName = TextEditingController();
    houseNo = TextEditingController();
    phoneNo = TextEditingController();
    landMark = TextEditingController();
    roadName = TextEditingController();
    pinCode = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fullName.dispose();
    houseNo.dispose();
    phoneNo.dispose();
    landMark.dispose();
    roadName.dispose();
    pinCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromRGBO(203, 213, 225, 1)),
        borderRadius: BorderRadius.circular(3.r));
    return Container(
       color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(gradient: gradient),
          child: Scaffold(
             extendBody: true,
            //  resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              forceMaterialTransparency: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Add Delivery Address',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name or Shop Name',
                        style:
                            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                          height: 42.h,
                          child: TextFormField(
                            controller: fullName,
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                                hintText: 'shop',
                                contentPadding: const EdgeInsets.all(10),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: border,
                                focusedBorder: border),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'House No., Building Name',
                        style:
                            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                          height: 42.h,
                          child: TextFormField(
                            controller: houseNo,
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                                hintText: 'house',
                                contentPadding: const EdgeInsets.all(10),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: border,
                                focusedBorder: border),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Phone Number',
                        style:
                            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                          height: 42.h,
                          child: TextFormField(
                            controller: phoneNo,
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w400),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                hintText: 'phone',
                                contentPadding: const EdgeInsets.all(10),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: border,
                                focusedBorder: border),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'State',
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              SizedBox(
                                width: 170.w,
                                height: 42.h,
                                child: DropdownSearch<String>(
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      constraints: BoxConstraints(maxHeight: 5.h),
                                      isDense: true,
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'State',
                                      //   hintStyle: TextStyle(color: Colors.black),
                                      contentPadding: const EdgeInsets.all(10),
                                      focusedBorder: border,
                                      enabledBorder: border,
                                      errorBorder: errorborder,
                                      focusedErrorBorder: errorborder,
                                      errorStyle: TextStyle(height: 0.h),
                                    ),
                                  ),
                                  items: loading ? [] : stateFromAPI,
                                  onChanged: (value) {
                                    setState(() {
                                      state = value.toString();
                                      city = '';
                                      fetchcity(state);
                                    });
                                  },
                                  selectedItem: state,
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                            constraints:
                                                BoxConstraints(maxHeight: 50.h))),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'City',
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              SizedBox(
                                width: 170.w,
                                height: 42.h,
                                child: DropdownSearch<String>(
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      constraints: BoxConstraints(maxHeight: 5.h),
                                      isDense: true,
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'city',
                                      contentPadding: const EdgeInsets.all(10),
                                      focusedBorder: border,
                                      enabledBorder: border,
                                      errorBorder: errorborder,
                                      focusedErrorBorder: errorborder,
                                      errorStyle: TextStyle(height: 0.h),
                                    ),
                                  ),
                                  items: cityLoading ? [] : cityFromAPI,
                                  onChanged: (value) {
                                    setState(() {
                                      city = value.toString();
                                    });
                                  },
                                  selectedItem: city,
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                            constraints:
                                                BoxConstraints(maxHeight: 50.h))),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Add Nearby Famous Shop/Mall/Landmark',
                        style:
                            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                          height: 42.h,
                          child: TextFormField(
                            controller: landMark,
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                                hintText: 'landmark',
                                contentPadding: const EdgeInsets.all(10),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: border,
                                focusedBorder: border),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Road name, Area, Colony',
                        style:
                            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                          height: 42.h,
                          child: TextFormField(
                            controller: roadName,
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                                hintText: 'Road',
                                contentPadding: const EdgeInsets.all(10),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: border,
                                focusedBorder: border),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Pincode',
                        style:
                            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 42.h,
                        child: TextFormField(
                          controller: pinCode,
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w400),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Pincode',
                              contentPadding: const EdgeInsets.all(10),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: border,
                              focusedBorder: border),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Type of address',
                        style:
                            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      Row(children: [
                        ChoiceChip(
                          showCheckmark: false,
                          avatar: Icon(
                            Icons.home_outlined,
                            color: isSelectedHome ? Colors.white : Colors.black,
                          ),
                          label: Text(
                            'Home',
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                          selectedColor: Theme.of(context).primaryColor,
                          selected: isSelectedHome,
                          onSelected: (boolVal) {
                            setState(() {
                              isSelectedHome = boolVal;
                              isSelectedWork = !boolVal;
                              if (isSelectedHome) {
                                typeOfAddress = 'Home';
                              } else {
                                typeOfAddress = 'Work';
                              }
                              print(typeOfAddress);
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                        SizedBox(
                          width: 21.w,
                        ),
                        ChoiceChip(
                          showCheckmark: false,
                          avatar: Icon(
                            Icons.work,
                            color: isSelectedWork ? Colors.white : Colors.black,
                          ),
                          label: Text(
                            'Work',
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                          disabledColor: Colors.white,
                          selectedColor: Theme.of(context).primaryColor,
                          selected: isSelectedWork,
                          onSelected: (boolVal) {
                            setState(() {
                              isSelectedWork = boolVal;
                              isSelectedHome = !boolVal;
                              if (isSelectedWork) {
                                typeOfAddress = 'Work';
                              } else {
                                typeOfAddress = 'Home';
                              }
        
                              print(typeOfAddress);
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                      ]),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: null // () {
                            //   Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => const AllowLocation()));
                            // },
                            ,
                            child: GestureDetector(
                              onTap: () {
                                _getCurrentLocation();
                              },
                              child: Container(
                                width: 200.w,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 12.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.r),
                                    color: Colors.white),
                                child: Row(
                                  children: [
                                    const Icon(Icons.my_location),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      'Use my Location',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            addAddressAPI(
                                fullName.text,
                                houseNo.text,
                                phoneNo.text,
                                state,
                                city,
                                landMark.text,
                                roadName.text,
                                typeOfAddress,
                                int.parse(pinCode.text),
                                widget.checkoutproduct);
                          },
                          style: ElevatedButton.styleFrom(
                              maximumSize: Size(378.w, 46.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r)),
                              backgroundColor: Theme.of(context).primaryColor),
                          child: Center(
                            child: Text(
                              'Save address',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ))
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

  void fetch() async {
    stateFromAPI = await AddressApi.addressStateAPI(context);
    loading = false;
    setState(() {});
  }

  void fetchcity(String state) async {
    cityLoading = true;
    setState(() {});
    cityFromAPI = await AddressApi.addressCityAPI( context,state);
    cityLoading = false;
    setState(() {});
  }

  Future<void> addAddressAPI(fullName, houseNo, phoneNo, state, city, landMark,
      roadName, typeOfAddress, pinCode, checkoutproduct) async {
    await AddressApi.addAddressAPI(context, fullName, houseNo, phoneNo, state,
        city, landMark, roadName, typeOfAddress, pinCode, checkoutproduct);
  }

  _getCurrentLocation() async {
    bool servicePermission = false;
    late LocationPermission permission;
    //lets check we have a permission to access location
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      Fluttertoast.showToast(msg: 'Location Service is disabled');
    }
    // to enable the service
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'you denied the permission');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'you denied the permission forever');
    }
    Position currentpos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentLocation = currentpos;
      print(currentLocation);
    });

    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          currentpos.latitude, currentpos.longitude);
      //   print(placeMarks);
      Placemark place = placeMarks[0];
      setState(() {
        houseNo.text = place.name ?? '';
        landMark.text = place.street ?? '';
        state = place.administrativeArea ?? '';
        city = place.subAdministrativeArea ?? '';
        roadName.text = place.thoroughfare ?? '';
        pinCode.text = place.postalCode ?? '';
      });
      //   print(place);
    } catch (e) {}
  }
}
