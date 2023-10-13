import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logica_entrata_merce/controller/base_controller.dart';
import 'package:logica_entrata_merce/services/base_client.dart';
import 'package:logica_entrata_merce/helper/dialog_helper.dart';
import 'package:logica_entrata_merce/services/app_exceptions.dart';
import 'package:logica_entrata_merce/model/user_profile.dart';

import 'package:logica_entrata_merce/controller/getx_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

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

  Future login() async {
    var request = {"username": user.text, "password": pass.text};
    BaseController.showLoading('Attendere prego');
    
    var dataResponse = await BaseClient()
        .post('https://www.logicawms.com/gsm-api', '/login_drv.php', request)
        .catchError(handleError);
    dynamic response = json.decode(dataResponse);

    print(response['res']);
    if (response['res'] == "ok") {
      BaseController.hideLoading();
      print(UserProfile.fromData(response).nome);
      print(UserProfile.fromData(response).cognome);
      print("TOKEN: " + UserProfile.fromData(response).jwt);

      final controller = Get.put(Controller());
      controller.init();
      controller.setUserProfile(UserProfile.fromData(response));
      controller.setItemsList([]);

      Get.toNamed("/warehouse");
      //Get.to(SecondPage(data: controller.userProfile));
    } else {
      user.text = "";
      pass.text = "";
      DialogHelper.showErrorDialog(description: 'ACCESSO NEGATO!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = "preparazione carichi di magazzino. V. 1.1.02";
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
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
                        Color(0xFFF1F9FF),
                      ]),
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 70),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(image: AssetImage('assets/images/LWMS_2022.png')),
                      SizedBox(height: 15),
                      Text(
                        title.toUpperCase(),
                        style: TextStyle(
                            color: Color(0xFFE8501D),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Username",
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
                                    contentPadding: EdgeInsets.only(top: 8),
                                    prefixIcon: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 12.0, top: 6.0),
                                        child:
                                            FaIcon(FontAwesomeIcons.solidUser)),
                                    hintText: "Username",
                                    hintStyle: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black38,
                                    )),
                                controller: user),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Password",
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
                              obscureText: true,
                              style: TextStyle(
                                  color: Color(0xFF005DA7), fontSize: 21),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 8),
                                  prefixIcon: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 12.0, top: 6.0),
                                      child: FaIcon(FontAwesomeIcons.lock)),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black38,
                                  )),
                              controller: pass,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        width: double.infinity,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          elevation: 5,
                          onPressed: () {
                            //print(user.text);
                            login();
                          },
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: Color(0xFF005DA7),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
