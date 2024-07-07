import 'package:dapursarjana/util.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:dapursarjana/constants.dart';
import 'package:dapursarjana/model/store_model.dart';
import 'package:dapursarjana/screen/edit_store_screen.dart';

class InfoStoreTabScreen extends StatefulWidget {
  final StoreModel store;

  const InfoStoreTabScreen({Key? key, required this.store}) : super(key: key);

  @override
  _InfoStoreTabScreenState createState() => _InfoStoreTabScreenState();
}

class _InfoStoreTabScreenState extends State<InfoStoreTabScreen> {
  late String role;

  @override
  void initState() {
    role = GetStorage().read(Constants.KEY_ROLE);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.store.storeName!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.store.storeDesc!),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.place,
                  color: Colors.black,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    widget.store.storeAddress!,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.black,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.store.storeOpenHour!,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            if (role == "admin")
              Center(
                child: TextButton(
                  onPressed: () async {
                    Navigator.of(context).push<bool>(MaterialPageRoute(
                      builder: (context) {
                        return EditStoreScreen(store: widget.store);
                      },
                    )).then((value) {
                      if (value == true) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: const Text(
                    "Edit Store",
                  ),
                ),
              ),
            Center(
              child: TextButton(
                onPressed: () async {
                  final availableMaps = await MapLauncher.installedMaps;
                  await availableMaps.first.showMarker(
                    coords: Coords(
                      widget.store.storeLat!,
                      widget.store.storeLong!,
                    ),
                    title: widget.store.storeName!,
                  );
                },
                child: const Text(
                  "Open in Maps",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
