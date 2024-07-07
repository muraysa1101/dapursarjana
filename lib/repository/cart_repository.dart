import 'package:dapursarjana/helper/database_helper.dart';
import 'package:dapursarjana/model/cart_model.dart';

class CartRepository {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> createData(CartModel cartModel) {
    return _databaseHelper.openDb().then(
          (db) => db.insert(
            "cart",
            cartModel.toMap(),
          ),
        );
  }

  Future<List<CartModel>> readData() async {
    var sqlRaw = '''
    SELECT * FROM cart
    ''';

    return _databaseHelper
        .openDb()
        .then(
          (db) => db.rawQuery(sqlRaw),
        )
        .then(
      (data) {
        if (data.isEmpty) {
          return [];
        }
        List<CartModel> dataList = [];
        for (int i = 0; i < data.length; i++) {
          CartModel cartModel = CartModel();
          cartModel.fromMap(data[i]);
          dataList.add(cartModel);
        }
        return dataList;
      },
    );
  }

  Future<void> updateData(CartModel cartModel, int id) async {
    return _databaseHelper.openDb().then((db) => db.update(
          'cart',
          cartModel.toMap(),
          where: 'id = $id',
        ));
  }

  Future<void> deleteData(int id) async {
    return _databaseHelper.openDb().then((db) => db.delete(
          'cart',
          where: 'id = $id',
        ));
  }

  Future<void> clearData() async {
    return _databaseHelper.openDb().then((db) => db.delete("cart"));
  }
}
