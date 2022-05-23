import 'package:flutter/material.dart';
import 'package:pharmacies/model/pharmacy_data_model.dart';
import 'package:pharmacies/model/pharmacy_detail_model.dart';
import '../service/api.dart';

class DetailPage extends StatefulWidget {
  final PharmacyLocalData item;
  const DetailPage({Key? key, required this.item}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Service _service = Service();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 26, 25, 25),
          iconTheme: const IconThemeData(color: Color(0xff4B39EF)),
          automaticallyImplyLeading: true,
          title: const Text(
            "Medication Details",
            style: TextStyle(
                fontSize: 23, color: Color.fromARGB(255, 241, 179, 5)),
          ),
          centerTitle: true,
          elevation: 4,
        ),
        backgroundColor: const Color.fromARGB(255, 37, 36, 36),
        body: FutureBuilder<PharmacyDetail>(
          future: _service.getPharmacyDetails(widget.item.id),
          builder:
              (BuildContext context, AsyncSnapshot<PharmacyDetail> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData) {
              var hours =
                  snapshot.data!.value.pharmacyHours.toString().split('\\n');
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      snapshot.data!.value.name.toString(),
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      snapshot.data!.details.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.zero,
                        child: Card(
                          color: const Color.fromARGB(255, 61, 57, 57),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Address",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  snapshot.data!.value.address!.streetAddress1
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  snapshot.data!.value.address!.city.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.zero,
                        child: Card(
                          color: const Color.fromARGB(255, 61, 57, 57),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Phone Number",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  snapshot.data!.value.primaryPhoneNumber
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.45,
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.zero,
                    child: Card(
                      color: const Color.fromARGB(255, 61, 57, 57),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Pharmacy Hours",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: hours.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            hours[index],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    padding: EdgeInsets.zero,
                    child: ListView.builder(
                        itemCount: widget.item.medicine == null
                            ? 0
                            : widget.item.medicine!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.item.medicine![index] + " ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 100)
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
