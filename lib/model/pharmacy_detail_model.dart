import 'package:pharmacies/model/pharmacy_value_model.dart';

class PharmacyDetail {
  late String responseCode;
  late String details;
  late String generatedTs;
  late PharmacyValue value;

  PharmacyDetail(
    this.responseCode,
    this.details,
    this.generatedTs,
    this.value,
  );

  PharmacyDetail.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    details = json['details'];
    generatedTs = json['generatedTs'];
    value = PharmacyValue.fromJson(json['value']);
  }

  PharmacyDetail.toJson(Map<String, dynamic> json) {
    json['responseCode'] = responseCode;
    json['details'] = details;
    json['generatedTs'] = generatedTs;
    json['value'] = value;
  }
}
