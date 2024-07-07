import 'package:flutter/material.dart';
import 'package:dapursarjana/model/cart_model.dart';
import 'package:dapursarjana/model/order_model.dart';
import 'package:dapursarjana/screen/order_service.dart';
import 'package:dapursarjana/service/local_service.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartModel> listCart;
  final int totalPrice;
  const CheckoutScreen(
      {Key? key, required this.listCart, required this.totalPrice})
      : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final OrderService _orderService = OrderService();
  final LocalService _localService = LocalService();
  TextEditingController consigneeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: consigneeController,
                      decoration: const InputDecoration(
                        labelText: 'Consignee',
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
                          return 'Please enter consignee name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: addressController,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter place address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.streetAddress,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Address',
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
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total Price"),
                    const SizedBox(height: 4),
                    Text(
                      "Rp. ${widget.totalPrice}",
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        _isLoading = true;
                      });
                      OrderModel orderModel = OrderModel();
                      orderModel.orderAddress = addressController.text.trim();
                      orderModel.orderConsignee =
                          consigneeController.text.trim();
                      orderModel.orderTotalPrice = widget.totalPrice;
                      _orderService
                          .submitCheckoutData(orderModel, widget.listCart)
                          .then((value) {
                        _localService.clearDataCart();
                        Navigator.pop(context);
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error.toString())));
                      }).whenComplete(() {
                        setState(() {
                          _isLoading = false;
                        });
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please fill all the fields")));
                    }
                  },
                  child: const Text(
                    "Submit Checkout",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
