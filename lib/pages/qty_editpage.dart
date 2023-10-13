import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logica_entrata_merce/controller/getx_controller.dart';

import 'package:fluttertoast/fluttertoast.dart';

class QtyEditPage extends StatefulWidget {
  @override
  _QtyEditPage createState() {
    return _QtyEditPage();
  }
}

class _QtyEditPage extends State<QtyEditPage> {
  TextEditingController qty = TextEditingController();
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

  bool isInt(String? s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    final String description = "inserisci in numero pz dell'articolo";
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
                          "Num. Pz. Articolo",
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
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  color: Color(0xFF005DA7), fontSize: 21),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 8),
                                  prefixIcon: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 12.0, top: 6.0),
                                      child:
                                          FaIcon(FontAwesomeIcons.calculator)),
                                  hintText: "Inserici N. pz. Articolo",
                                  hintStyle: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black38,
                                  )),
                              controller: qty),
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
                          print(qty.text);
                          if (qty.text == "") {
                            Fluttertoast.showToast(
                                msg: "DEVI INSERIRE NUMERO!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color(0xFF005DA7),
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (!isInt(qty.text)) {
                            Fluttertoast.showToast(
                                msg: "QTY NON VALIDA!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color(0xFF005DA7),
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            //lancia un metodo per modificare la quantità del prodotto
                            final controller = Get.put(Controller());
                            controller.setQtyArticle(int.parse(qty.text));
                            controller.editItemList(controller.indexArticle, int.parse(qty.text));
                            print(controller.indexArticle.toString());
                            Get.toNamed("/resume");
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
                          qty.text = "";
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
