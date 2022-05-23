import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pharmacies/constants/constant.dart';
import 'package:pharmacies/constants/function.dart';
import 'package:pharmacies/model/pharmacy_data_model.dart';
import 'package:pharmacies/model/pharmacy_detail_model.dart';
import 'package:pharmacies/pages/detail_page.dart';
import 'package:pharmacies/pages/order_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Service _service = Service();
  List<PharmacyDetail> detailList = [];
  List<PharmacyLocalData> items = [];
  List<double> distanceList = [];
  List<int> indexList = [];
  List<Object> initPharmData = [];
  int orderIndex = -1;
  bool isNothing = false;

  @override
  void initState() {
    super.initState();
    setupLocalStorage().then((value) => {
          setState(() {
            items = value;
          }),
          getNearestPharmacy(value),
        });
  }

  /* Setup the local storage only one time when API has called at first time. */
  Future<List<PharmacyLocalData>> setupLocalStorage() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    Service _service = Service();
    // If local storage is not set up, this will be setup here!
    if (_prefs.getString('localData') == null) {
      var pharmList = await _service.readJsonData();
      for (var i = 0; i < pharmList.length; i++) {
        initPharmData.add({
          "name": pharmList[i].name,
          "id": pharmList[i].id,
          "order_status": false,
          "medicine": [],
        });
      }
      _prefs.setString('localData', json.encode(initPharmData));
      print("Local storage initiallized successfully!");
    }
    var result =
        json.decode(_prefs.getString('localData') ?? '') as List<dynamic>;
    return result.map((e) => PharmacyLocalData.fromJson(e)).toList();
  }

  /* This function is to get the closest pharmacy from the list of distances between of pharmacie's locations and user location.
  If one has selected, it can't be selected anymore. */
  void getNearestPharmacy(List<PharmacyLocalData> data) async {
    for (var i = 0; i < data.length; i++) {
      var pharma = await _service.getPharmacyDetails(data[i].id);
      detailList.add(pharma);
      var lat = pharma.value.address!.latitude;
      var lon = pharma.value.address!.longitude;
      if (data[i].orderStatus == true) {
        // If it already selected before, then it's distance will set max value among of them.
        distanceList.add(double.infinity);
      } else {
        // If it is first time selecting, then it will be added distance list.
        distanceList.add(getDistanceFromLatLonInKm(lat, lon));
      }
    }
    if (distanceList.reduce((value, element) => min(value, element)) ==
        double.infinity) {
      setState(() {
        isNothing = true;
      });
    } else {
      setState(() {
        isNothing = false;
      });
    }
    setState(() {
      orderIndex = distanceList.indexOf(
          distanceList.reduce((value, element) => min(value, element)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 26, 25, 25),
          iconTheme: const IconThemeData(color: Color(0xff4B39EF)),
          automaticallyImplyLeading: true,
          title: const Text(
            "Nimble",
            style: TextStyle(fontSize: 33, color: Color.fromARGB(255, 241, 179, 5)),
          ),
          centerTitle: true,
          elevation: 4,
        ),
        backgroundColor: const Color.fromARGB(255, 37, 36, 36),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(item: items[index]),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                              color: Colors.black54,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Container(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text(
                                          items[index].name.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: items[index].orderStatus == true
                                            ? const Icon(checkmark, color: Colors.green,)
                                            : null,
                                      ),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 30),
                child: TextButton(
                  onPressed: orderIndex == -1 || isNothing == true
                      ? null
                      : (() => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderPage(
                                  item: items[orderIndex],
                                  orderIndex: orderIndex,
                                ),
                              ),
                            )
                          }),
                  style: TextButton.styleFrom(
                    backgroundColor: orderIndex == -1 || isNothing == true
                        ? Colors.grey
                        : Colors.black,
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side:
                          const BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                  child: Text(
                    "Start Order",
                    style: TextStyle(
                        color: orderIndex == -1 || isNothing == true
                            ? Colors.white54
                            : Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
