import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dapursarjana/constants.dart';
import 'package:dapursarjana/model/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _box = GetStorage();

  Future<String> login(String email, String password) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("user")
        .where("email", isEqualTo: email)
        .get();
    if (querySnapshot.docs.length == 1) {
      String dataPassword = querySnapshot.docs[0].get("password");
      if (password == dataPassword) {
        await _box.write(Constants.KEY_ID, querySnapshot.docs[0].id);
        await _box.write(
            Constants.KEY_FULLNAME, querySnapshot.docs[0].get('full_name'));
        await _box.write(
            Constants.KEY_EMAIL, querySnapshot.docs[0].get('email'));
        await _box.write(
            Constants.KEY_PASSWORD, querySnapshot.docs[0].get('password'));
        await _box.write(
            Constants.KEY_PROFILE, querySnapshot.docs[0].get('profile_photo'));
        await _box.write(Constants.KEY_ROLE, querySnapshot.docs[0].get('role'));
        await _box.write(Constants.KEY_PHONE_NUMBER,
            querySnapshot.docs[0].get('phone_number'));
        await _box.write(
            Constants.KEY_Address, querySnapshot.docs[0].get('address'));
        await _box.write(Constants.IS_LOGIN, true);
        return Constants.SUCCESS_RESPONSE;
      } else {
        throw Constants.WRONG_PASSWORD_RESPONSE;
        //return Future.error(Constants.WRONG_PASSWORD_RESPONSE);
      }
    } else {
      return Future.error(Constants.FAILED_RESPONSE);
    }
  }

  Future<String> register(UserModel userModel) async {
    return await _firestore
        .collection("user")
        .add(userModel.toJson())
        .then((value) async {
      await _box.write(Constants.KEY_ID, value.id);
      await _box.write(Constants.KEY_FULLNAME, userModel.full_name);
      await _box.write(Constants.KEY_EMAIL, userModel.email);
      await _box.write(Constants.KEY_PASSWORD, userModel.password);
      await _box.write(Constants.KEY_PROFILE, userModel.profilePhoto);
      await _box.write(Constants.KEY_PHONE_NUMBER, userModel.phoneNumber);
      await _box.write(Constants.KEY_Address, userModel.address);
      await _box.write(Constants.KEY_ROLE, userModel.role);
      await _box.write(Constants.IS_LOGIN, true);
      return Constants.SUCCESS_RESPONSE;
    }).catchError((error) {
      throw Constants.FAILED_RESPONSE;
    });
  }

  Future<String> changeProfile(UserModel userModel) async {
    DocumentReference documentReference =
        _firestore.doc('user/${_box.read(Constants.KEY_ID)}');
    _firestore.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot =
          await transaction.get(documentReference);
      if (documentSnapshot.exists) {
        transaction.update(documentReference, userModel.toJson());
        await _box.erase();
        await _box.write(Constants.KEY_ID, documentSnapshot.id);
        await _box.write(Constants.KEY_FULLNAME, userModel.full_name);
        await _box.write(Constants.KEY_EMAIL, userModel.email);
        await _box.write(Constants.KEY_PASSWORD, userModel.password);
        await _box.write(Constants.KEY_PROFILE, userModel.profilePhoto);
        await _box.write(Constants.KEY_PHONE_NUMBER, userModel.phoneNumber);
        await _box.write(Constants.KEY_Address, userModel.address);
        await _box.write(Constants.IS_LOGIN, true);
      } else {
        throw Constants.FAILED_RESPONSE;
      }
    });
    return Constants.SUCCESS_RESPONSE;
  }
}
