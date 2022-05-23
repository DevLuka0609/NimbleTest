class PharmacyData {
  String? name;
  String? id;

  PharmacyData({
    this.name,
    this.id,
  });

  PharmacyData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['pharmacyId'];
  }

  PharmacyData.toJson(Map<String, dynamic> json) {
    json['name'] = name;
    json['pharmacyId'] = id;
  }
}

class PharmacyLocalData {
  String? name;
  String? id;
  bool? orderStatus;
  List<String>? medicine;

  PharmacyLocalData({
    this.name,
    this.id,
    this.orderStatus,
    this.medicine,
  });

  PharmacyLocalData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    orderStatus = json['order_status'];
    var list = [];
    for(var i = 0; i < json['medicine'].length; i ++) {
      list.add(json['medicine'][i]);
    }
    medicine = list.cast<String>();
  }

  PharmacyLocalData.toJson(Map<String, dynamic> json) {
    json['name'] = name;
    json['id'] = id;
    json['order_status'] = orderStatus;
    json['medicine'] = medicine;
  }
}
