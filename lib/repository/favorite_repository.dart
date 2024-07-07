import 'package:dapursarjana/helper/database_helper.dart';
import 'package:dapursarjana/model/favorite_model.dart';

class FavoriteRepository {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> createData(FavoriteModel favoriteModel) {
    return _databaseHelper.openDb().then(
          (db) => db.insert(
            "favorite",
            favoriteModel.toMap(),
          ),
        );
  }

  Future<int> readDataByField(String fieldName, dynamic value) async {
    var sqlRaw = '''
    SELECT * FROM favorite WHERE $fieldName = ?
    ''';

    return _databaseHelper
        .openDb()
        .then(
          (db) => db.rawQuery(sqlRaw, ['$value']),
        )
        .then(
      (data) {
        if (data.length == 0) {
          return 0;
        }
        return 1;
      },
    );
  }

  Future<List<FavoriteModel>> readData() async {
    var sqlRaw = '''
    SELECT * FROM favorite
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
        List<FavoriteModel> dataList = [];
        for (int i = 0; i < data.length; i++) {
          FavoriteModel favoriteModel = FavoriteModel();
          favoriteModel.fromMap(data[i]);
          dataList.add(favoriteModel);
        }
        return dataList;
      },
    );
  }

  Future<void> updateData(FavoriteModel favoriteModel, int id) async {
    return _databaseHelper.openDb().then((db) => db.update(
          'favorite',
          favoriteModel.toMap(),
          where: 'id = $id',
        ));
  }

  Future<void> deleteData(int id) async {
    return _databaseHelper.openDb().then((db) => db.delete(
          'favorite',
          where: 'id = $id',
        ));
  }

  Future<void> deleteDataByField(String fieldName, dynamic value) async {
    return _databaseHelper.openDb().then((db) =>
        db.delete('favorite', where: '$fieldName = ?', whereArgs: ['$value']));
  }
}
