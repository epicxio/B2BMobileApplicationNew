class AddressModel {
  final String id;
  final String fullName;
  final String houseNo;
  final String phoneNumber;
  final String state;
  final String city;
  final String landmark;
  final String roadName;
  final int pincode;
  final String addressType;
   

  AddressModel(
      {required this.id,
      required this.fullName,
      required this.houseNo,
      required this.phoneNumber,
      required this.state,
      required this.city,
      required this.landmark,
      required this.roadName,
      required this.pincode,
       
      required this.addressType});

  Map<String, dynamic> toMap(String userId) {
    return <String, dynamic>{
      'userId': userId,
      'fullName': fullName,
      'houseNo': houseNo,
      'phoneNumber': phoneNumber,
      'state': state,
      'city': city,
      'landmark': landmark,
      'roadName': roadName,
      'pincode': pincode,
      'addressType': addressType,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['_id'] ?? '',
      fullName: map['fullName'] ?? '',
      houseNo: map['houseNo'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      landmark: map['landmark'] ?? '',
      roadName: map['roadName'] ?? '',
      pincode: map['pincode'] ?? 0,
      addressType: map['addressType'] ?? '',
    );
  }
  factory AddressModel.fromMapForCurrentAddressSelected(
      Map<String, dynamic> map) {
  final addressMap = (map['address'] as Map<String, dynamic>?) ?? {};
    return AddressModel(
      id: map['_id'] ?? '',
      fullName: addressMap['fullName'] ?? '',
      houseNo: addressMap['houseNo'] ?? '',
      phoneNumber: addressMap['phoneNumber'] ?? '',
      state: addressMap['state'] ?? '',
      city: addressMap['city'] ?? '',
      landmark: addressMap['landmark'] ?? '',
      roadName: addressMap['roadName'] ?? '',
      pincode: addressMap['pincode'] ?? 0, 
      addressType: addressMap['addressType'] ?? '',
    );
  }

  // String toJson() => json.encode(toMap( USerId));

  // factory AddressModel.fromJson(String source) =>
  //     AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
