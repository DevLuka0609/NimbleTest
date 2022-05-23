import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pharmacies/model/pharmacy_data_model.dart';
import 'package:pharmacies/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api.dart';

class OrderPage extends StatefulWidget {
  final PharmacyLocalData item;
  final int orderIndex;
  const OrderPage({Key? key, required this.item, required this.orderIndex})
      : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final Service _service = Service();
  List<Object> updatedData = [];
  List<String> newmedicine = [];
  int count = 0;
  List<bool> _selected = [];
  List<String> items = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    initSeletedList();
  }

  void initSeletedList() async {
    await _service.getMedicinList().then((value) => {
          setState(() {
            items = value;
            _selected = List.generate(items.length, (i) => false);
            _isLoading = true;
          }),
        });
  }

  void confirmOrder() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    var originalData =
        json.decode(_prefs.getString('localData') ?? '') as List<dynamic>;
    for (var i = 0; i < originalData.length; i++) {
      if (widget.orderIndex == i) {
        updatedData.add({
          "name": originalData[i]['name'],
          "id": originalData[i]['id'],
          "order_status": true,
          "medicine": newmedicine,
        });
      } else if (originalData[i]['order_status'] == true) {
        updatedData.add({
          "name": originalData[i]['name'],
          "id": originalData[i]['id'],
          "order_status": true,
          "medicine": originalData[i]['medicine'],
        });
      } else {
        updatedData.add({
          "name": originalData[i]['name'],
          "id": originalData[i]['id'],
          "order_status": false,
          "medicine": originalData[i]['medicine'],
        });
      }
    }
    _prefs.setString('localData', json.encode(updatedData));
    print("Local storage updated successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 25, 25),
        iconTheme: const IconThemeData(color: Color(0xff4B39EF)),
        automaticallyImplyLeading: true,
        title: const Text(
          "Order",
          style:
              TextStyle(fontSize: 23, color: Color.fromARGB(255, 241, 179, 5)),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              widget.item.name.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          _isLoading
              ? Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selected[index] = !_selected[index];
                            });
                            if (_selected[index] == true) {
                              setState(() {
                                newmedicine.add(items[index]);
                              });
                            } else {
                              setState(() {
                                newmedicine.remove(items[index]);
                              });
                            }
                          },
                          child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            color: _selected[index]
                                ? Colors.green
                                : Colors.white70,
                            child: Container(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Text(
                                            items[index],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                )
              : const Expanded(
                  child: Center(child: CircularProgressIndicator())),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 30),
            child: TextButton(
              onPressed: () {
                confirmOrder();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                fixedSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: const BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
              child: const Text(
                "Confirm Order",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
