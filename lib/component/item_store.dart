import 'package:flutter/material.dart';

class ItemStore extends StatelessWidget {
  final String storeName;
  final String storePlace;
  final String storePhoto;
  final void Function()? onTap;

  const ItemStore(
      {Key? key,
      required this.storeName,
      required this.storePlace,
      required this.storePhoto,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Image.network(storePhoto),
        title: Text(storeName),
        onTap: onTap,
        subtitle: Text(storePlace));
  }
}
