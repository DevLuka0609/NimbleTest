class PharmacyValue {
  String? id;
  String? pharmacyChainId;
  String? name;
  bool? active;
  String? localId;
  bool? testPharmacy;
  Address? address;
  String? primaryPhoneNumber;
  String? defaultTimeZone;
  String? pharmacistInCharge;
  String? postalCodes;
  List<dynamic>? deliverableStates;
  String? pharmacyHours;
  String? deliverySubsidyAmount;
  String? pharmacySystem;
  bool? acceptInvalidAddress;
  String? pharmacyType;
  String? pharmacyLoginCode;
  bool? checkoutPharmacy;
  bool? marketplacePharmacy;
  bool? importActive;

  PharmacyValue(
    this.id,
    this.pharmacyChainId,
    this.name,
    this.active,
    this.localId,
    this.testPharmacy,
    this.address,
    this.primaryPhoneNumber,
    this.defaultTimeZone,
    this.pharmacistInCharge,
    this.postalCodes,
    this.deliverableStates,
    this.pharmacyHours,
    this.deliverySubsidyAmount,
    this.pharmacySystem,
    this.acceptInvalidAddress,
    this.pharmacyType,
    this.pharmacyLoginCode,
    this.checkoutPharmacy,
    this.marketplacePharmacy,
    this.importActive,
  );

  PharmacyValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacyChainId = json['pharmacyChainId'];
    name = json['name'];
    active = json['active'];
    localId = json['localId'];
    testPharmacy = json['testPharmacy'];
    address = Address.fromJson(json['address']);
    primaryPhoneNumber = json['primaryPhoneNumber'];
    defaultTimeZone = json['defaultTimeZone'];
    pharmacistInCharge = json['pharmacistInCharge'];
    postalCodes = json['postalCodes'];
    var list = [];
    for(var i = 0; i < json['deliverableStates'].length; i ++) {
      list.add(json['deliverableStates'][i]);
    }
    deliverableStates = list;
    pharmacyHours = json['pharmacyHours'];
    deliverySubsidyAmount = json['deliverySubsidyAmount'];
    pharmacySystem = json['pharmacySystem'];
    acceptInvalidAddress = json['acceptInvalidAddress'];
    pharmacyType = json['pharmacyType'];
    pharmacyLoginCode = json['pharmacyLoginCode'];
    checkoutPharmacy = json['checkoutPharmacy'];
    marketplacePharmacy = json['marketplacePharmacy'];
    importActive = json['importActive'];
  }

  PharmacyValue.toJson(Map<String, dynamic> json) {
    json['id'] = id;
    json['pharmacyChainId'] = pharmacyChainId;
    json['name'] = name;
    json['active'] = active;
    json['localId'] = localId;
    json['testPharmacy'] = testPharmacy;
    json['address'] = address;
    json['primaryPhoneNumber'] = primaryPhoneNumber;
    json['defaultTimeZone'] = defaultTimeZone;
    json['pharmacistInCharge'] = pharmacistInCharge;
    json['postalCodes'] = postalCodes;
    json['deliverableStates'] = deliverableStates;
    json['pharmacyHours'] = pharmacyHours;
    json['deliverySubsidyAmount'] = deliverySubsidyAmount;
    json['pharmacySystem'] = pharmacySystem;
    json['acceptInvalidAddress'] = acceptInvalidAddress;
    json['pharmacyType'] = pharmacyType;
    json['pharmacyLoginCode'] = pharmacyLoginCode;
    json['checkoutPharmacy'] = checkoutPharmacy;
    json['marketplacePharmacy'] = marketplacePharmacy;
    json['importActive'] = importActive;
  }
}

class Address {
  String? streetAddress1;
  String? city;
  String? usTerritory;
  String? postalCode;
  double? latitude;
  double? longitude;
  String? addressType;
  String? externalId;
  bool? isValid;
  String? googlePlaceId;

  Address(
    this.streetAddress1,
    this.city,
    this.usTerritory,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.addressType,
    this.externalId,
    this.isValid,
    this.googlePlaceId,
  );

  Address.fromJson(Map<String, dynamic> json) {
    streetAddress1 = json['streetAddress1'];
    city = json['city'];
    usTerritory = json['usTerritory'];
    postalCode = json['postalCode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    addressType = json['addressType'];
    externalId = json['externalId'];
    isValid = json['isValid'];
    googlePlaceId = json['googlePlaceId'];
  }

  Address.toJson(Map<String, dynamic> json) {
    json['streetAddress1'] = streetAddress1;
    json['city'] = city;
    json['usTerritory'] = usTerritory;
    json['postalCode'] = postalCode;
    json['latitude'] = latitude;
    json['longitude'] = longitude;
    json['addressType'] = addressType;
    json['externalId'] = externalId;
    json['isValid'] = isValid;
    json['googlePlaceId'] = googlePlaceId;
  }
}
