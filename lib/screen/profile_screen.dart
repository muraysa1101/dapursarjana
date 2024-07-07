import 'package:dapursarjana/util.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dapursarjana/constants.dart';
import 'package:dapursarjana/screen/change_profile_screen.dart';
import 'package:dapursarjana/screen/favorite_screen.dart';
import 'package:dapursarjana/screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var box = GetStorage();
  late String username;
  String? role;

  @override
  void initState() {
    super.initState();
    username = box.read(Constants.KEY_FULLNAME);
    role = box.read(Constants.KEY_ROLE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
              Container(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: SizedBox.expand(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(1000)),
                          child: box.read(Constants.KEY_PROFILE) == "-"
                              ? const Icon(Icons.person)
                              : FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.network(
                                      box.read(Constants.KEY_PROFILE)),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username ?? "batal ini",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangeProfileScreen(),
                                ),
                              ).then((value) {
                                setState(() {});
                              });
                            },
                            child: const Row(
                              children: [
                                Text(
                                  "Change Profile",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(
                color: Colors.grey,
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                ),
                alignment: Alignment.centerLeft,
                child: const Text("Manage Account"),
              ),
              ListTile(
                leading: Icon(Icons.account_balance),
                title: Text("Role"),
                trailing: Text(
                  role ?? "-",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.favorite_border,
                ),
                title: const Text(
                  "Favorite Product",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            box.erase();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
