import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemProduct extends StatelessWidget {
  final String productName;
  final String productPhoto;
  final int productPrice;
  final void Function()? onTap;

  const ItemProduct({
    Key? key,
    required this.productPrice,
    required this.productName,
    required this.productPhoto,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(children: [
        Expanded(
          child: Image.network(
            productPhoto,
            fit: BoxFit.fill,
          ),
        ),
        Text(productName),
        Text(productPrice.toString()),
      ]),
    );
  }
}
