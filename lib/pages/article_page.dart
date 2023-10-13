import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logica_entrata_merce/controller/getx_controller.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:logica_entrata_merce/helper/dialog_helper.dart';
import 'package:logica_entrata_merce/helper/dialog_choice.dart';
import 'package:logica_entrata_merce/services/app_exceptions.dart';
import 'package:logica_entrata_merce/services/base_client.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePage createState() {
    return _ArticlePage();
  }
}

class _ArticlePage extends State<ArticlePage> {
  TextEditingController article = TextEditingController();
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

  Future sendData(dynamic ean13, String token) async {
    var dataResponse = await BaseClient()
        .postJsonToken('https://www.logicawms.com/gsm-api',
            '/check_article.php', ean13, token)
        .catchError(handleError);//'https://www.galardigroup.it/gsm-api'
    dynamic response = json.decode(dataResponse);

    print(response['res']);
    if (response['res'] == "Ok") {
      print('Codice 200!');
      print(response['message']);
      //Procedura per indicare all'utente che tutto è andato a buon fine
      //Get.to(SecondPage(data: controller.userProfile));
      if (response['message'] == 'Articolo Inesistente!') {
        //Apro una finestra di Dialogo
        DialogChoice.showChoiceDialog(context);
      } else {
        Get.toNamed("/qty");
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
                    SizedBox(height: 10),
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
                                  contentPadding: EdgeInsets.only(top: 8),
                                  prefixIcon: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 12.0, top: 6.0),
                                      child: FaIcon(FontAwesomeIcons.barcode)),
                                  hintText: "Inserici Barcode Articolo",
                                  hintStyle: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black38,
                                  )),
                              controller: article),
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
                          } else {
                            final controller = Get.put(Controller());
                            controller.setCodeArticle(article.text);
                            //dynamic jsonList = {'ean13': article.text};

                            //controller.setEan13(jsonList);

                            print(controller.codeArticle);
                            Get.toNamed("/qty");
                            //sendData(controller.ean13, controller.userProfile.jwt);
                          }
                        },
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Color(0xFF005DA7),
                        child: Text(
                          'OK',
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
