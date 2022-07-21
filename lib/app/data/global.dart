
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';


final box = GetStorage();
var dio = Dio();


var userId = box.read('userid');
var firstname = box.read('firstname');
var lastname = box.read('lastname');
var email = box.read('email');
var phone = box.read('phone');
var token = box.read('token');

getFormatedDate(date) {
  var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
  var inputDate = inputFormat.parse(date.toString());
  var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
  return outputFormat.format(inputDate);
}

final ftime = new DateFormat('yyyy-MM-dd hh:mm');

var alluserwallet = box.read('wallets');
var alltransactions = box.read('Transactions');

var formatthousands = NumberFormat("#,##0.00", "en_US");

final formatCurrencyus = NumberFormat("###.0#", "en_US");
final formatCurrencyng = NumberFormat("###.0#", "en_NG");
final formatCurrencyeu = NumberFormat("###.0#", "en_EU");
final formatCurrencyuk = NumberFormat("###.0#", "en_UK");

void showSnackBar(String title, String message, Color backgroundColor) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: Colors.black,
      duration: Duration(seconds: 3));
}

void showProgress({String title = "", String message = "Loading ..."}) {
  Get.defaultDialog(
      title: title,
      barrierDismissible: false,
      backgroundColor: Colors.green,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.red,
          ),
          SizedBox(
            width: 16,
          ),
          Text(message),
        ],
      ));
}

void closeDialog() {
  if (Get.isDialogOpen == true) {
    Get.back();
  }
}

void showRojarDialog({String title = "MarlinPay", String message = ""}) {
  Get.defaultDialog(
      title: title,
      content: Text(
        message,
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12.0),
        maxLines: 3,
      ));
}

void showError() {
  Get.snackbar('error', 'please try again',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText:  Colors.white,
      duration: const Duration(seconds: 3),
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ));
}
