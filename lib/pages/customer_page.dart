import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logica_entrata_merce/controller/getx_controller.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPage createState() {
    return _CustomerPage();
  }
}

class _CustomerPage extends State<CustomerPage> {
  String dropdownValue = 'DR. VRANJES';
  @override
  Widget build(BuildContext context) {
    final String description = "seleziona il cliente depositante";
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
                          "Cliente",
                          style: TextStyle(
                              color: Color(0xFF005DA7),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                            padding: EdgeInsets.all(16.0),
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
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const FaIcon(FontAwesomeIcons.userTie,
                                  color: Color(0xFF005DA7)),
                              iconSize: 26,
                              isExpanded: true,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Color(0xFF005DA7), fontSize: 21),
                              underline: Container(
                                height: 0,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'DR. VRANJES',
                                'LU-VE',
                                'SEM',
                                'ADS',
                                'THECOMP',
                                'MODULA',
                                'IMPERIALE'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
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
                          final controller = Get.put(Controller());
                          controller.setNameCustomer(dropdownValue);
                          print(controller.nameCustomer);
                          Get.toNamed("/truck");
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
