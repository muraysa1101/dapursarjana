class StoreModel {
  String? id;
  String? storePhone;
  String? storeDesc;
  double? storeLong;
  double? storeLat;
  String? storePhoto;
  String? storeOpenHour;
  String? storeName;
  String? storeAddress;

  StoreModel(
      {this.id,
      this.storePhone,
      this.storeDesc,
      this.storeLong,
      this.storeLat,
      this.storePhoto,
      this.storeOpenHour,
      this.storeName,
      this.storeAddress});

  StoreModel.fromJson(this.id, Map<String, dynamic> json) {
    storeName = json['store_name'];
    storeLat = json['store_lat'];
    storeLong = json['store_long'];
    storePhoto = json['store_photo'];
    storePhone = json['store_phone'];
    storeDesc = json['store_desc'];
    storeOpenHour = json['store_open_hour'];
    storeAddress = json['store_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_name'] = storeName;
    data['store_lat'] = storeLat;
    data['store_long'] = storeLong;
    data['store_photo'] = storePhoto;
    data['store_phone'] = storePhone;
    data['store_desc'] = storeDesc;
    data['store_open_hour'] = storeOpenHour;
    data['store_address'] = storeAddress;
    return data;
  }
}
