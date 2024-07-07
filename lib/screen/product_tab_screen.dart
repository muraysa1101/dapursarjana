import 'package:dapursarjana/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dapursarjana/component/item_product.dart';
import 'package:dapursarjana/model/product_model.dart';
import 'package:dapursarjana/model/store_model.dart';
import 'package:dapursarjana/screen/detail_product_screen.dart';
import 'package:dapursarjana/service/product_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

class ProductTabScreen extends StatefulWidget {
  final StoreModel store;

  const ProductTabScreen({Key? key, required this.store}) : super(key: key);

  @override
  _ProductTabScreenState createState() => _ProductTabScreenState();
}

class _ProductTabScreenState extends State<ProductTabScreen> {
  Widget singleProducts() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 180,
      width: 140,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 204, 185, 11),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/dapursarjana-7fc76.appspot.com/o/djAyamKatsu.png?alt=media&token=2047ef84-fc71-4b42-9f75-fa2f99dae0e4'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'DJ AYAM KATSU',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '\Rp. 16.000',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 3),
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                '1 Pcs',
                                style: TextStyle(fontSize: 10),
                              )),
                              Expanded(
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  size: 20,
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.remove,
                                color: Colors.red,
                                size: 15,
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 111, 76, 208),
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.green,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      drawer: Drawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/dapursarjana-7fc76.appspot.com/o/katsuback.jpg?alt=media&token=0a7b9679-b244-4c95-b70e-30dae1970b96',
                  ),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 120, bottom: 20),
                            child: Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(50),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'DS',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      shadows: [
                                        BoxShadow(
                                            color: Colors.green,
                                            blurRadius: 3,
                                            offset: Offset(3, 3))
                                      ]),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '100% Halal',
                            style: TextStyle(
                              height: 4,
                              fontSize: 25,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Menu Paket Nasi'),
                  Text(
                    "View All",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  singleProducts(),
                  singleProducts(),
                  singleProducts(),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Menu Paket Tanpa Nasi'),
                  Text(
                    "View All",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  singleProducts(),
                  singleProducts(),
                  singleProducts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
