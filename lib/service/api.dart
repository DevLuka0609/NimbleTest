import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' as rootBundle;
import '../model/pharmacy_data_model.dart';
import '../model/pharmacy_detail_model.dart';

class Service {
  Future<List<PharmacyData>> readJsonData() async {
    //read json file
    final jsondata = await rootBundle.rootBundle
        .loadString('assets/json/pharmacies_list.json');

    //decode json data as list
    final res = convert.jsonDecode(jsondata)["pharmacies"] as List<dynamic>;

    //map json and initialize using DataModel
    return res.map((e) => PharmacyData.fromJson(e)).toList();
  }

  // get data details of Pharmacy from Api
  Future<PharmacyDetail> getPharmacyDetails(String? id) async {
    try {
      var result;
      var url = Uri.parse(
          'https://api-qa-demo.nimbleandsimple.com/pharmacies/info/$id');
      var response = await http.get(url);
      final body = convert.jsonDecode(response.body);
      // print(body);
      if (response.statusCode == 200) {
        result = PharmacyDetail.fromJson(body);
      }
      return result;
    } catch (err) {
      rethrow;
    }
  }

  Future<List<String>> getMedicinList() async {
    try {
      var result;
      var url = Uri.parse(
          'https://s3-us-west-2.amazonaws.com/assets.nimblerx.com/prod/medicationListFromNIH/medicationListFromNIH.txt');
      var response = await http.get(url);
      result = response.body.split(',\n');
      return result;
    } catch (err) {
      rethrow;
    }
  }
}
