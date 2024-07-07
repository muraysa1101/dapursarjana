import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dapursarjana/constants.dart';
import 'package:dapursarjana/model/cart_model.dart';
import 'package:dapursarjana/model/item_order_model.dart';
import 'package:dapursarjana/model/order_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _box = GetStorage();

  Future<String> submitCheckoutData(
      OrderModel orderModel, List<CartModel> listCart) async {
    CollectionReference orderCollection = _firestore.collection("order");
    CollectionReference itemOrderCollection =
        _firestore.collection("item_order");

    return await _firestore.runTransaction<String>((transaction) async {
      orderModel.userId = _box.read(Constants.KEY_ID);
      final order = orderCollection.doc();
      transaction.set(order, orderModel.toJson());
      for (var item in listCart) {
        final itemOrderModel = ItemOrderModel(
            orderId: order.id, productId: item.productId, price: item.price);
        final itemOrder = itemOrderCollection.doc();
        transaction.set(itemOrder, itemOrderModel.toJson());
      }
      return Constants.SUCCESS_RESPONSE;
    });
  }
}
