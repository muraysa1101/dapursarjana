import 'dart:io';

import 'package:dapursarjana/util.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dapursarjana/constants.dart';
import 'package:dapursarjana/model/user_model.dart';
import 'package:dapursarjana/service/user_service.dart';
import 'package:path/path.dart';

class ChangeProfileScreen extends StatefulWidget {
  const ChangeProfileScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChangeProfileScreenState createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();
  final _box = GetStorage();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _imageUrl;
  File? _imageFile;
  bool _isLoading = false;
  final bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _usernameController.text = _box.read(Constants.KEY_FULLNAME);
    _addressController.text = _box.read(Constants.KEY_Address);
    _emailController.text = _box.read(Constants.KEY_EMAIL);
    _passwordController.text = _box.read(Constants.KEY_PASSWORD);
    _phoneController.text = _box.read(Constants.KEY_PHONE_NUMBER);
    _imageUrl = _box.read(Constants.KEY_PROFILE);
  }

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    if (gallery) {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
    } else {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
    }

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Change Profile"),
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.only(bottom: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            SizedBox.expand(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(1000)),
                                child: _imageFile != null
                                    ? FittedBox(
                                        fit: BoxFit.fill,
                                        child: Image.file(_imageFile!),
                                      )
                                    : _imageUrl == "-"
                                        ? const Icon(Icons.person)
                                        : FittedBox(
                                            fit: BoxFit.fill,
                                            child: Image.network(_imageUrl!),
                                          ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                getImage(true);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: const Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Lengkap',
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Silakan masukkan nama lengkap anda';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Alamat',
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Silakan masukkan alamat lengkap anda';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && EmailValidator.validate(value)) {
                            return null;
                          }
                          return "Format email salah";
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value != null && value.length < 8) {
                            return "Kata sandi tidak boleh kurang dari 8 karakter";
                          }
                          if (value != null && value.isEmpty) {
                            return "Kata sandi tidak boleh kosong";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Nomor Handphone',
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Silakan masukkan nomor telepon';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              setState(() {
                _isLoading = true;
              });
              if (_imageFile != null) {
                await FirebaseStorage.instance
                    .ref(basename(_imageFile!.path))
                    .putFile(_imageFile!)
                    .then((task) async {
                  print(
                      "Berhasil Mengunggah Gambar ${basename(_imageFile!.path)}");
                  await task.storage
                      .ref(basename(_imageFile!.path))
                      .getDownloadURL()
                      .then((value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        _imageUrl = value;
                      });
                      UserModel userModel = UserModel(
                        email: _emailController.text.toString(),
                        address: _addressController.text.toString(),
                        password: _passwordController.text.toString(),
                        phoneNumber: _phoneController.text.toString(),
                        full_name: _usernameController.text.toString(),
                        profilePhoto: _imageUrl,
                      );
                      _userService.changeProfile(userModel).then((value) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Berhasil")));
                      }).catchError((error) {
                        print(error);
                      });
                    } else {
                      print("Gambar Tidak ada");
                    }
                  }).catchError((error) {
                    print(error);
                  });
                  // ignore: invalid_return_type_for_catch_error, avoid_print
                }).catchError((error) => print(error.toString()));
              } else {
                UserModel userModel = UserModel(
                  email: _emailController.text.toString(),
                  address: _addressController.text.toString(),
                  password: _passwordController.text.toString(),
                  phoneNumber: _phoneController.text.toString(),
                  full_name: _usernameController.text.toString(),
                  profilePhoto: _imageUrl,
                );
                _userService.changeProfile(userModel).then((value) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Berhasil")));
                }).catchError((error) {
                  print(error);
                });
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Silakan isi semua kolom")));
            }
          },
          child: const Text("Simpan"),
        ),
      ),
    );
  }
}
