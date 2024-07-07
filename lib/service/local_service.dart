import 'package:dapursarjana/model/cart_model.dart';
import 'package:dapursarjana/model/favorite_model.dart';
import 'package:dapursarjana/repository/cart_repository.dart';
import 'package:dapursarjana/repository/favorite_repository.dart';

class LocalService {
  final CartRepository _cartRepository = CartRepository();
  final FavoriteRepository _favoriteRepository = FavoriteRepository();

//cart
  Future<int> createDataCart(CartModel cartModel) async {
    return _cartRepository.createData(cartModel);
  }

  Future<List<CartModel>> readDataCart() async {
    return _cartRepository.readData();
  }

  Future<void> updateDataCart(CartModel cartModel, int id) async {
    return _cartRepository.updateData(cartModel, id);
  }

  Future<void> deleteDataCart(int id) async {
    return _cartRepository.deleteData(id);
  }

  Future<void> clearDataCart() async {
    return _cartRepository.clearData();
  }

//favorite
  Future<int> createDataFavorite(FavoriteModel favoriteModel) async {
    return _favoriteRepository.createData(favoriteModel);
  }

  Future<List<FavoriteModel>> readDataFavorite() async {
    return _favoriteRepository.readData();
  }

  Future<void> updateDataFavorite(FavoriteModel favoriteModel, int id) async {
    return _favoriteRepository.updateData(favoriteModel, id);
  }

  Future<void> deleteDataFavorite(int id) async {
    return _favoriteRepository.deleteData(id);
  }

  Future<int> readDataByField(String fieldName, dynamic value) async {
    return _favoriteRepository.readDataByField(fieldName, value);
  }

  Future<void> deleteDataFavoriteByField(
      String fieldName, dynamic value) async {
    return _favoriteRepository.deleteDataByField(fieldName, value);
  }
}
