import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
 final TextEditingController phoneNumberController=TextEditingController();
 final TextEditingController passwordController=TextEditingController();


 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
  }
}