import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogChoice {
  static void showChoiceDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Nuovo Articolo"),
      onPressed: () {
        Get.toNamed("/newarticle");
      },
    );
    Widget continueButton = TextButton(
      child: Text("Annulla"),
      onPressed: () {
        if (Get.isDialogOpen!) Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Articolo Non Trovato!"),
      content: Text("Vuoi inserire un nuovo Articolo?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
