class FavoriteModel {
  int? id;
  String? productId;
  String? productName;
  String? photo;
  int? price;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'product_id': productId,
      'product_name': productName,
      'photo': photo,
      'price': price,
    };
    return map;
  }

  fromMap(Map<String, dynamic> valueDB) {
    id = valueDB['id'];
    productId = valueDB['product_id'];
    productName = valueDB['product_name'];
    photo = valueDB['photo'];
    price = valueDB['price'];
  }
}
