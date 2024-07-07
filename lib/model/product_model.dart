class ProductModel {
  String? id;
  String? productDesc;
  String? storeId;
  int? productPrice;
  String? productName;
  String? productPhoto;

  ProductModel(
      {this.id,
      this.storeId,
      this.productName,
      this.productPrice,
      this.productPhoto,
      this.productDesc});

  ProductModel.fromJson(this.id, Map<String, dynamic> json) {
    storeId = json['store_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productPhoto = json['product_photo'];
    productDesc = json['product_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['product_name'] = productName;
    data['product_price'] = productPrice;
    data['product_desc'] = productDesc;
    data['product_photo'] = productPhoto;
    return data;
  }
}
