import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dapursarjana/model/store_model.dart';
import 'package:dapursarjana/util.dart';

class StoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<StoreModel>> getAllStore(
      {double? lat, double? long, double? maxDistanceInMeter}) async {
    QuerySnapshot querySnapshot = await _firestore.collection("store").get();
    List<StoreModel> listStore = <StoreModel>[];
    for (int i = 0; i < querySnapshot.size; i++) {
      var data = querySnapshot.docs[i];
      StoreModel storeModel = StoreModel(
        id: data.id,
        storeAddress: data.get("store_address"),
        storeDesc: data.get("store_desc"),
        storeLat: data.get("store_lat"),
        storeLong: data.get("store_long"),
        storeName: data.get("store_name"),
        storeOpenHour: data.get("store_open_hour"),
        storePhone: data.get("store_phone"),
        storePhoto: data.get("store_photo"),
      );
      listStore.add(storeModel);
    }

    //filter based on distance
    if (lat != null && long != null && maxDistanceInMeter != null) {
      return listStore
          .where((element) =>
              calculateDistance(
                  element.storeLat!, element.storeLong!, lat, long) <=
              maxDistanceInMeter)
          .toList();
    } else {
      return listStore;
    }
  }

  Future<StoreModel> getStoreById(String storeId) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore.doc("store/$storeId").get();
    return StoreModel.fromJson(documentSnapshot.id, documentSnapshot.data()!);
  }

  Future<void> updateStore(String storeId, StoreModel store) async {
    await _firestore.collection("store").doc(storeId).update(store.toJson());
  }
}
