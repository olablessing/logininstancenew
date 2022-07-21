import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapkit/snapkit.dart';

class SigninController extends GetxController {



 
  bool _isSnackOpen = false;


  final count = 0.obs;
  var instagramtoken = null;
  var instagramname = null;
  var instagramuserid = null;
  @override
  void onInit() {
    super.onInit();
  
  }


   @override
  void dispose() {
    super.dispose();
    
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void increment() => count.value++;
}
