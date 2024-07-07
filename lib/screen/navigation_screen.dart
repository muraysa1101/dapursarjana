import 'package:flutter/material.dart';
import 'package:dapursarjana/screen/cart_screen.dart';
import 'package:dapursarjana/screen/map_screen.dart';
import 'package:dapursarjana/screen/profile_screen.dart';
import 'package:dapursarjana/screen/store_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;
  final List<Widget> _listScreen = [
    StoreScreen(),
    const MapScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listScreen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "List Store"),
          BottomNavigationBarItem(
              icon: Icon(Icons.place), label: "Nearby tore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
