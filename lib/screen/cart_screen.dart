import 'package:flutter/material.dart';
import 'package:dapursarjana/component/item_product.dart';
import 'package:dapursarjana/model/cart_model.dart';
import 'package:dapursarjana/screen/checkout_screen.dart';
import 'package:dapursarjana/service/local_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final LocalService localService = LocalService();
    return FutureBuilder<List<CartModel>>(
      future: LocalService().readDataCart(),
      builder: (context, snapshot) {
        if ((snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == false) ||
            (snapshot.connectionState == ConnectionState.waiting)) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Cart"),
              ),
              body: const Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Cart"),
            ),
            body: Center(
              child: Text("Ada masalah ${snapshot.error.toString()}"),
            ),
          );
        }

        if (snapshot.data?.isEmpty ?? true) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Cart"),
            ),
            body: const Center(
              child: Text("Data kosong, silahkan ditambahkan."),
            ),
          );
        }
        var listCart = snapshot.data!;

        return Scaffold(
          body: StatefulBuilder(
            builder: (BuildContext context, setState) {
              //return Text("halo");
              return ListView.builder(
                  itemCount: listCart.length,
                  itemBuilder: (context, index) {
                    //return Text("test");
                    return SizedBox(
                      height: 250,
                      child: ItemProduct(
                        productPrice: listCart[index].price!,
                        productName: listCart[index].productName!,
                        productPhoto: listCart[index].photo!,
                        onTap: () {
                          LocalService().deleteDataCart(listCart[index].id!);
                          setState(
                            () {
                              listCart.removeAt(index);
                            },
                          );
                        },
                      ),
                    );
                  });
            },
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      )),
                  onPressed: () {
                    int totalPrice = listCart.map((e) => e.price).toList().fold(
                        0,
                        (previousValue, nextValue) =>
                            previousValue + nextValue!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(
                          listCart: listCart,
                          totalPrice: totalPrice,
                        ),
                      ),
                    ).then((value) {
                      localService.readDataCart().then((value) {
                        setState(() {
                          listCart = value;
                        });
                      });
                    });
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add_shopping_cart,
                        size: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Checkout"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
