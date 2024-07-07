import 'dart:io';
import 'package:dapursarjana/util.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dapursarjana/constants.dart';
import 'package:dapursarjana/model/user_model.dart';
import 'package:dapursarjana/service/user_service.dart';
import 'package:path/path.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _imageUrl = "-";
  File? _imageFile;
  bool _obscureText = true;
  bool _isLoading = false;
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _fullnameController.dispose();
    _addressController.dispose();
    super.dispose();
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
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
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  children: [
                    Image.asset(
                      "assets/images/iconds.jpg",
                      height: 200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Pendaftaran",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Masukkan data anda untuk mendaftar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                  borderRadius: BorderRadius.circular(1000),
                                  child: _imageFile != null
                                      ? FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.file(_imageFile!),
                                        )
                                      : _imageUrl == "-"
                                          ? const Icon(Icons.person)
                                          : Image.network(_imageUrl,
                                              fit: BoxFit.fill),
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
                      ],
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value != null && EmailValidator.validate(value)) {
                          return null;
                        }
                        return "Email Format is wrong";
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value != null && value.length < 8) {
                          return "Password cannot be less than 8 character";
                        }
                        if (value != null && value.isEmpty) {
                          return "Password cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Nama Lengkap",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _fullnameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Masukkan Nama lengka anda",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Alamat Lengkap",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Masukkan Alamat lengkap anda",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Phone number cannot be empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Phone Number",
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () async {
                        if (_imageFile != null &&
                            (_formKey.currentState?.validate() ?? false)) {
                          setState(() {
                            _isLoading = true;
                          });
                          await FirebaseStorage.instance
                              .ref(basename(_imageFile!.path))
                              .putFile(_imageFile!)
                              .then((task) async {
                            print(
                                "Succes Uploading Image ${basename(_imageFile!.path)}");
                            await task.storage
                                .ref(basename(_imageFile!.path))
                                .getDownloadURL()
                                .then((link) {
                              if (link.isNotEmpty) {
                                setState(() {
                                  _imageUrl = link;
                                });
                                UserModel userModel = UserModel(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  phoneNumber: _phoneController.text,
                                  full_name: _fullnameController.text,
                                  address: _addressController.text,
                                  profilePhoto: _imageUrl,
                                );
                                _userService
                                    .register(userModel)
                                    .then((value) async {
                                  if (value == Constants.SUCCESS_RESPONSE) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Register berhasil")));
                                  } else {}
                                }).catchError((error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(error.toString())));
                                }).whenComplete(() {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                              } else {
                                print("Gambar Tidak ada");
                              }
                            }).catchError((error) {
                              print(error);
                            });
                          }).catchError((error) => print(error.toString()));
                        } else {
                          if (_imageFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please set image profile")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Please fill all the fields")));
                          }
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sudah memiliki akun? ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
