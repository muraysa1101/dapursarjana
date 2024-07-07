import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dapursarjana/model/cart_model.dart';
import 'package:dapursarjana/model/favorite_model.dart';
import 'package:dapursarjana/model/product_model.dart';
import 'package:dapursarjana/model/store_model.dart';
import 'package:dapursarjana/service/local_service.dart';
import 'package:dapursarjana/service/product_service.dart';
import 'package:dapursarjana/service/store_service.dart';

class DetailProductScreen extends StatefulWidget {
  final String productId;
  final String storeId;

  const DetailProductScreen({
    Key? key,
    required this.productId,
    required this.storeId,
  }) : super(key: key);

  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  StoreService _storeService = StoreService();
  ProductService _productService = ProductService();
  LocalService _localService = LocalService();
  bool _isLoading = false;
  bool _isFavorite = false;
  late ProductModel _product;
  late StoreModel _store;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _localService.readDataByField("product_id", widget.productId).then((value) {
      if (value > 0) {
        setState(() {
          _isFavorite = true;
        });
      } else {
        setState(() {
          _isFavorite = false;
        });
      }
    });
    _storeService.getStoreById(widget.storeId).then((value) {
      setState(() {
        _store = value;
      });

      _productService.getProductById(widget.productId).then((value) {
        setState(() {
          _product = value;
          _isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _isLoading ? "Loading" : _product.productName!,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.2,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: SizedBox.expand(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network(_product.productPhoto!),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _product.productName ?? "",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Rp. ${_product.productPrice}",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_isFavorite) {
                            _localService
                                .deleteDataFavoriteByField(
                                    "product_id", _product.id)
                                .then((value) {
                              setState(() {
                                _isFavorite = false;
                              });
                            });
                          } else {
                            FavoriteModel favoriteModel = FavoriteModel();
                            favoriteModel.price = _product.productPrice;
                            favoriteModel.productName = _product.productName;
                            favoriteModel.productId = _product.id;
                            favoriteModel.photo = _product.productPhoto;
                            _localService
                                .createDataFavorite(favoriteModel)
                                .then((value) {
                              setState(() {
                                _isFavorite = true;
                              });
                            });
                          }
                        },
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        alignment: Alignment.center,
                        child: SizedBox.expand(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(_store.storePhoto!),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 20,
                        foregroundImage: NetworkImage(_store.storePhoto!),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _store.storeName!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(_store.storeDesc!),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Product Description",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _product.productDesc!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextButton(
          onPressed: () {
            CartModel cartModel = CartModel();
            cartModel.price = _product.productPrice;
            cartModel.productName = _product.productName;
            cartModel.productId = _product.id;
            cartModel.photo = _product.productPhoto;
            _localService.createDataCart(cartModel).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Success add to cart")));
            }).catchError((error) {
              log(error.toString());
            });
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Add to Cart",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
