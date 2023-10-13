import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logica_entrata_merce/controller/getx_controller.dart';
import 'package:logica_entrata_merce/helper/dialog_helper.dart';
import 'package:logica_entrata_merce/services/app_exceptions.dart';
import 'package:logica_entrata_merce/services/base_client.dart';
import 'package:http/http.dart' as http;
import 'package:logica_entrata_merce/widget/slidable_widget.dart';
import 'package:logica_entrata_merce/helper/utils.dart';

class ResumePage extends StatefulWidget {
  @override
  _ResumePage createState() {
    return _ResumePage();
  }
}

class _ResumePage extends State<ResumePage> {
  final controller = Get.put(Controller());
  final String title = 'riepilogo dati';

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

  Future dataSend(List<dynamic> listaUdc, String token) async {
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('https://www.logicawms.com/gsm-api/salva_entrata_drv_new.php')); //Uri.parse('https://www.galardigroup.it/gsm-api/salva_entrata_drv.php'));
    request.body = json.encode(listaUdc);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Codice 200!');
      dynamic res = json.decode(await response.stream.bytesToString());
      print(res['message'].toString());
      showDialogDatiInseriti(
          title: 'INFO', description: res['message'].toString());
    } else {
      print(response.statusCode.toString());
      print(await response.stream.bytesToString());
      dynamic wrongRes = json.decode(await response.stream.bytesToString());
      DialogHelper.showErrorDialog(
          title: 'ERRORE!', description: wrongRes['message'].toString());
      print(response.reasonPhrase);
    }
  }

  Future sendData(List<dynamic> listaUdc, String token) async {
    var body = listaUdc;
    var dataResponse = await BaseClient()
        .postToken('https://www.logicawms.com/gsm-api',
            '/salva_entrata_drv_new.php', body, token)
        .catchError(handleError); //'https://www.galardigroup.it/gsm-api'
    dynamic response = json.decode(dataResponse);

    print(response['res']);
    if (response['res'] == "Ok") {
      print('Codice 200!');
      print(response['message']);
      //Procedura per indicare all'utente che tutto è andato a buon fine
      //Get.to(SecondPage(data: controller.userProfile));
      controller.itemsList.clear();
      print(controller.itemsList.toString());
      showDialogDatiInseriti(title: 'INFO', description: response['message']);
    } else {
      print('Codice 400!');
      //Procedura per indicare all'utente che qualcosa è andata storta!ù
      DialogHelper.showErrorDialog(
          title: 'ERRORE!', description: response['message']);
    }
  }

  static void showDialogDatiInseriti(
      {String title = 'INFO', String description = 'Dati inseriti!'}) {
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
                Get.toNamed("/");
              },
              child: Text('OK')),
        ],
      ),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CAMION " + controller.itemsList[0]['codeTruck']),
        backgroundColor: Color(0xFF005DA7),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: controller.itemsList.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 0.5,
                    thickness: 2.0,
                    color: Color(0xFF005DA7),
                  ),
                  itemBuilder: (context, index) {
                    return SlidableWidget(
                      child: Card(
                        margin: const EdgeInsets.all(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${controller.itemsList[index]['codeUdc']}',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          'BARCODE: ${controller.itemsList[index]['codeArticle']}'),
                                      Text(
                                          'POSITION: ${controller.itemsList[index]['codePosition']}'),
                                    ],
                                  ),
                                  Text(
                                      '${controller.itemsList[index]['qtyArticle']} pz.',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      onDismissed: (action) =>
                          dismissSlidableItem(context, index, action),
                    );
                  },
                ),
              ),
              controller.itemsList.length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          color: Colors.teal,
                          child: Text(
                            "INVIA DATI",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            print("INVIA DATI");
                            print(controller.itemsList.toString());
                            print(controller.userProfile.jwt);
                            sendData(controller.itemsList,
                                controller.userProfile.jwt);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          color: Color(0xFF005DA7),
                          child: Text(
                            "AGGIUNGI NUOVO UDC",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed("/udc");
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void dismissSlidableItem(
      BuildContext context, int index, SlidableAction action) {
    

    switch (action) {
      case SlidableAction.delete:
        Utils.showSnackBar(context, 'UDC Rimosso!');
        setState(() => controller.deleteItemList(index));
        print(controller.itemsList.toString());
        break;
      case SlidableAction.edit:
        controller.setIndexArticle(index);
        Get.toNamed("/qty_edit");
        print(controller.itemsList.toString());
        break;
    }
  }
}
