import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:logica_entrata_merce/helper/dialog_helper.dart';
import 'package:get/get.dart';
import 'package:logica_entrata_merce/controller/getx_controller.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:logica_entrata_merce/services/app_exceptions.dart';
import 'package:logica_entrata_merce/services/base_client.dart';

class NewArticlePage extends StatefulWidget {
  @override
  _NewArticlePage createState() {
    return _NewArticlePage();
  }
}

class _NewArticlePage extends State<NewArticlePage> {
  TextEditingController article = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController descr = TextEditingController();
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  void handleError(error) {
    if (error is BadRequestException) {
      //Show dialog
      var message = error.message;
      DialogHelper.showErrorDialog(description: message!);
    } else if (error is FetchDataException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message!);
    } else if (error is ApiNotRespondingException) {
      DialogHelper.showErrorDialog(
          description: 'Oops! It took longer to respond.');
    }
  }

  Future sendData(dynamic newArticle, String token) async {
    var dataResponse = await BaseClient()
        .postJsonToken('https://www.logicawms.com/gsm-api', '/salva_articolo.php',
            newArticle, token)
        .catchError(handleError);//'https://galardigroup.it/gsm-api'
    dynamic response = json.decode(dataResponse);

    print(response['res']);
    if (response['res'] == "Ok") {
      print('Codice 200!');
      print(response['message']);
      //Procedura per indicare all'utente che tutto è andato a buon fine
      //Get.to(SecondPage(data: controller.userProfile));
      if (response['message'] == 'Articolo Inserito con Successo!' ||
          response['message'] == 'Articolo Modificato con Successo!') {
        Get.toNamed("/qty");
      } else {
        Fluttertoast.showToast(
            msg: response['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xFF005DA7),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      print('Codice 400!');
      //Procedura per indicare all'utente che qualcosa è andata storta!ù
      DialogHelper.showErrorDialog(
          title: 'ERRORE!', description: response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String description =
        "inserisci il Barcode dell'articolo (scansiona il barcode)";
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x66F1F9FF),
                      Color(0x99F1F9FF),
                      Color(0xCCF1F9FF),
                      Color(0xFFF1F9FF)
                    ]), //LinearGradient
              ), //BoxDecoration
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(image: AssetImage('assets/images/LWMS_2022.png')),
                    SizedBox(height: 15),
                    Text(
                      description.toUpperCase(),
                      style: TextStyle(
                          color: Color(0xFFE8501D),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Barcode Articolo",
                          style: TextStyle(
                              color: Color(0xFF005DA7),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ]),
                          height: 60,
                          child: TextField(
                              autofocus: true,
                              focusNode: myFocusNode,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  color: Color(0xFF005DA7), fontSize: 21),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 16, top: 8),
                                  hintText: "Inserici Barcode Articolo",
                                  hintStyle: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black38,
                                  )),
                              controller: article),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Codice Articolo",
                          style: TextStyle(
                              color: Color(0xFF005DA7),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ]),
                          height: 60,
                          child: TextField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  color: Color(0xFF005DA7), fontSize: 21),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 16, top: 8),
                                  hintText: "Inserici Codice Articolo",
                                  hintStyle: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black38,
                                  )),
                              controller: code),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Descrizione Articolo",
                          style: TextStyle(
                              color: Color(0xFF005DA7),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ]),
                          height: 60,
                          child: TextField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  color: Color(0xFF005DA7), fontSize: 21),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 16, top: 8),
                                  hintText: "Inserici Descrizione Articolo",
                                  hintStyle: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black38,
                                  )),
                              controller: descr),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        elevation: 5,
                        onPressed: () {
                          print(article.text);
                          if (article.text == "") {
                            Fluttertoast.showToast(
                                msg: "DEVI INSERIRE UN BARCODE!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color(0xFF005DA7),
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (code.text == "") {
                            Fluttertoast.showToast(
                                msg: "DEVI INSERIRE UN CODICE ARTICOLO!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color(0xFF005DA7),
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (descr.text == "") {
                            Fluttertoast.showToast(
                                msg: "INSERIRE UNA DESCRIZIONE DELL'ARTICOLO!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color(0xFF005DA7),
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            //Inserisci dati nel Database
                            dynamic jsonList = {
                              'ean13': article.text,
                              'code': code.text,
                              'descr': descr.text
                            };
                            final controller = Get.put(Controller());
                            controller.setCodeArticle(article.text);
                            print(controller.codeArticle);
                            sendData(jsonList, controller.userProfile.jwt);
                          }
                        },
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Color(0xFF005DA7),
                        child: Text(
                          'INSERISCI',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        elevation: 5,
                        onPressed: () {
                          article.text = "";
                          code.text = "";
                          descr.text = "";
                        },
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Color(0xFFAB0D00),
                        child: Text(
                          'ANNULLA',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
