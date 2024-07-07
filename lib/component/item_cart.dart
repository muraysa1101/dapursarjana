import 'package:flutter/material.dart';

class ItemCart extends StatelessWidget {
  final String productName;
  final String productPhoto;
  final int productPrice;
  final void Function()? onDelete;

  const ItemCart({
    Key? key,
    required this.productPrice,
    required this.productName,
    required this.productPhoto,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDelete,
      child: Column(children: [
        Image.network(
          productPhoto,
          fit: BoxFit.fill,
        ),
        Text(productName),
        Text(productPrice.toString()),
      ]),
    );
  }
}
