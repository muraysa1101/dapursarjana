import 'package:flutter/material.dart';

import 'package:dapursarjana/component/item_store.dart';
import 'package:dapursarjana/model/store_model.dart';
import 'package:dapursarjana/screen/detail_store_screen.dart';
import 'package:dapursarjana/service/store_service.dart';
import 'package:dapursarjana/util.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  List<StoreModel> _listStore = <StoreModel>[];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getLatestPosition().then((position) {
      StoreService()
          .getAllStore(
              lat: position.latitude,
              long: position.longitude,
              maxDistanceInMeter: 5000000)
          .then((value) {
        setState(() {
          _listStore = value;
          _isLoading = false;
        });
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
      });
    }).catchError((error) {
      showSnackbar(context, error);
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "List Store",
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                hexStringToColor("7FFF00"),
                hexStringToColor("FFFF00"),
                hexStringToColor("7FFF00"),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: _listStore.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return ItemStore(
                    storeName: _listStore[index].storeName!,
                    storePlace: _listStore[index].storeAddress!,
                    storePhoto: _listStore[index].storePhoto!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailStoreScreen(
                            store: _listStore[index],
                          ),
                        ),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                  );
                },
              ),
            ),
    );
  }
}
