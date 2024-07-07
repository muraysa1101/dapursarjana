import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:dapursarjana/screen/navigation_screen.dart';
import 'package:dapursarjana/screen/register_screen.dart';
import 'package:dapursarjana/service/user_service.dart';
import 'package:dapursarjana/util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController(text: "");
  TextEditingController _passwordController = TextEditingController(text: "");
  bool _obscureText = true;
  bool _loadingLogin = false;

  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadingLogin
          ? const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.blue))
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                hexStringToColor("7FFF00"),
                hexStringToColor("FFFF00"),
                hexStringToColor("7FFF00"),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              //batas
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
                        "Selamat datang di login Dapur Sarjana!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Masukkan data login anda untuk melanjutkan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
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
                            prefixIcon: Icon(Icons.email_outlined)),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "email tidak boleh kosong";
                          }
                          if (!EmailValidator.validate(value ?? "")) {
                            return "format email salah";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
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
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(Icons.email_outlined),
                            suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility))),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value != null && value.length < 8) {
                            return "Password cannot be less than 8 character";
                          }
                          if (value?.isEmpty ?? true) {
                            return "Password cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () async {
                            //validasi
                            if (_formKey.currentState?.validate() ?? false) {
                              //login proses
                              //1. show loading
                              setState(() {
                                _loadingLogin = true;
                              });
                              //2. hit service
                              _userService
                                  .login(_emailController.text,
                                      _passwordController.text)
                                  .then((value) {
                                showSnackbar(context, "Login berhasil");

                                // what to do next??
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return NavigationScreen();
                                }));
                              }).catchError((error) {
                                showSnackbar(context, "Login gagal");
                              }).whenComplete(() {
                                //3. hide loading
                                setState(() {
                                  _loadingLogin = false;
                                });
                              });
                            } else {
                              showSnackbar(context, "Form tidak valid");
                            }
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Not having an account yet? ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const RegisterScreen();
                              }));
                            },
                            child: const Text(
                              "Register Now",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
