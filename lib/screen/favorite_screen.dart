import 'package:flutter/material.dart';
import 'package:dapursarjana/component/item_product.dart';
import 'package:dapursarjana/model/favorite_model.dart';
import 'package:dapursarjana/service/local_service.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<FavoriteModel>>(
        future: LocalService().readDataFavorite(),
        builder: (context, snapshot) {
          if ((snapshot.connectionState == ConnectionState.none &&
                  snapshot.hasData == false) ||
              (snapshot.connectionState == ConnectionState.waiting)) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Ada masalah ${snapshot.error.toString()}"),
            );
          } else if (snapshot.data?.isEmpty ?? true) {
            return const Center(
              child: Text("Data masih kosong, silakan ditambahkan"),
            );
          }

          var listFavorite = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: const Text(
                  "All Favorite",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        crossAxisCount: 2,
                      ),
                      padding: const EdgeInsets.only(
                        top: 10,
                        right: 20,
                        left: 20,
                        bottom: 20,
                      ),
                      itemCount: listFavorite.length,
                      itemBuilder: (context, index) => ItemProduct(
                        productPrice: listFavorite[index].price!,
                        productName: listFavorite[index].productName!,
                        productPhoto: listFavorite[index].photo!,
                        onTap: () {
                          LocalService()
                              .deleteDataFavorite(listFavorite[index].id!);
                          setState(() {
                            listFavorite.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
