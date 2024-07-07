import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dapursarjana/model/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProductByStoreId(String storeId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("product")
        .where("store_id", isEqualTo: storeId)
        .get();
    List<ProductModel> listProduct = <ProductModel>[];
    for (int i = 0; i < querySnapshot.size; i++) {
      var data = querySnapshot.docs[i];
      ProductModel productModel = ProductModel(
        id: data.id,
        productName: data.get("product_name"),
        productDesc: data.get("product_desc"),
        productPhoto: data.get("product_photo"),
        productPrice: data.get("product_price"),
        storeId: data.get("store_id"),
      );
      listProduct.add(productModel);
    }
    return listProduct;
  }

  Future<ProductModel> getProductById(String productId) async {
    var documentSnapshot = await _firestore.doc("product/$productId").get();
    return ProductModel.fromJson(documentSnapshot.id, documentSnapshot.data()!);
  }
}
