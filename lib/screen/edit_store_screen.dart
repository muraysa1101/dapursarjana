import 'package:flutter/material.dart';
import 'package:dapursarjana/model/store_model.dart';
import 'package:dapursarjana/service/store_service.dart';
import 'package:dapursarjana/util.dart';

class EditStoreScreen extends StatelessWidget {
  final StoreModel store;
  const EditStoreScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Store"),
      ),
      body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            children: [
              const Text("Store name"),
              TextFormField(
                initialValue: store.storeName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "tidak boleh kosong";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  store.storeName = newValue;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Store Desc"),
              TextFormField(
                initialValue: store.storeDesc,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "tidak boleh kosong";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  store.storeDesc = newValue;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      formKey.currentState?.save();
                      StoreService()
                          .updateStore(store.id!, store)
                          .then((value) {
                        showSnackbar(context, "update data berhasil");
                        Navigator.of(context).pop(true);
                      });
                    } else {
                      //ada yg tidak valid
                      showSnackbar(context, "tolong di isi semua");
                    }
                  },
                  child: const Text("update"))
            ],
          )),
    );
  }
}
