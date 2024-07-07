class ItemOrderModel {
  String? id;
  String? orderId;
  int? price;
  String? productId;

  ItemOrderModel({this.id, this.orderId, this.price, this.productId});

  ItemOrderModel.fromJson(this.id, Map<String, dynamic> json) {
    orderId = json['order_id'];
    price = json['price'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['price'] = price;
    data['product_id'] = productId;
    return data;
  }
}
