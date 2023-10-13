import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  //show error dialog
  static void showErrorDialog(
      {String title = 'Error', String description = 'Sonthing went wrong'}) {
    Get.dialog(Dialog(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Get.textTheme.headline4,
          ),
          Text(
            description,
            style: Get.textTheme.headline6,
          ),
          ElevatedButton(
              onPressed: () {
                if (Get.isDialogOpen!) Get.back();
              },
              child: Text('OK')),
        ],
      ),
    )));
  }

  static void showErrorUdcFail(
      {String title = 'Errore!', String description = 'UDC già inserito!'}) {
    Get.dialog(Dialog(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Get.textTheme.headline4,
          ),
          Text(
            description,
            style: Get.textTheme.headline6,
          ),
          ElevatedButton(
              onPressed: () {
                if (Get.isDialogOpen!) Get.back();
              },
              child: Text('OK')),
        ],
      ),
    )));
  }

  //show toast
  //show snack bar
  //show loading
  //hide loading
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
