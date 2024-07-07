import 'package:dapursarjana/util.dart';
import 'package:flutter/material.dart';
import 'package:dapursarjana/model/store_model.dart';
import 'package:dapursarjana/screen/info_store_tab_screen.dart';
import 'package:dapursarjana/screen/product_tab_screen.dart';

class DetailStoreScreen extends StatefulWidget {
  final StoreModel store;

  const DetailStoreScreen({Key? key, required this.store}) : super(key: key);

  @override
  _DetailStoreScreenState createState() => _DetailStoreScreenState();
}

class _DetailStoreScreenState extends State<DetailStoreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.store.storeName ?? ""),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("7FFF00"),
          hexStringToColor("FFFF00"),
          hexStringToColor("7FFF00"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Colors.blueAccent,
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: SizedBox.expand(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(1000)),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.network(widget.store.storePhoto ?? ""),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.store.storeName ?? "",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.place_outlined,
                                size: 14,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Expanded(
                                  child: Text(widget.store.storeAddress ?? "")),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_outlined,
                                size: 14,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(widget.store.storeOpenHour ?? ""),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TabBar(
                labelColor: Colors.blue,
                controller: _tabController,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.inventory),
                  ),
                  Tab(
                    icon: Icon(Icons.store),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ProductTabScreen(
                      store: widget.store,
                    ),
                    InfoStoreTabScreen(
                      store: widget.store,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
