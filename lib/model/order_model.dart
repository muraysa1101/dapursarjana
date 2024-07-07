class OrderModel {
  String? id;
  String? orderAddress;
  String? orderConsignee;
  int? orderTotalPrice;
  String? userId;

  OrderModel(
      {this.id,
      this.orderAddress,
      this.orderConsignee,
      this.orderTotalPrice,
      this.userId});

  OrderModel.fromJson(this.id, Map<String, dynamic> json) {
    userId = json['user_id'];
    orderAddress = json['order_address'];
    orderConsignee = json['order_consignee'];
    orderTotalPrice = json['order_total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['order_address'] = orderAddress;
    data['order_consignee'] = orderConsignee;
    data['order_total_price'] = orderTotalPrice;
    return data;
  }
}
