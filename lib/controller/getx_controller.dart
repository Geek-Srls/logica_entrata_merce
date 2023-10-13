import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Controller extends GetxController {
  final box = GetStorage();

  void init() => box.erase();

  dynamic get userProfile => box.read('userprofile');
  void setUserProfile(dynamic data) => box.write('userprofile', data);

  int get idWarehouse => box.read('idWarehouse');
  void setIdWarehouse(int id) => box.write('idWarehouse', id);

  String get nameCustomer => box.read('nameCustomer');
  void setNameCustomer(String name) => box.write('nameCustomer', name);

  String get codeUdc => box.read('codeUdc');
  void setCodeUdc(String udc) => box.write('codeUdc', udc);

  String get codeTruck => box.read('codeTruck');
  void setCodeTruck(String truck) => box.write('codeTruck', truck);

  String get codeArticle => box.read('codeArticle');
  void setCodeArticle(String article) => box.write('codeArticle', article);

  int get qtyArticle => box.read('qtyArticle');
  void setQtyArticle(int qty) => box.write('qtyArticle', qty);

  String get codePosition => box.read('codePosition');
  void setCodePosition(String position) => box.write('codePosition', position);

  List<dynamic> get itemsList => box.read('itemsList');
  void setItemsList(List<dynamic> itemlist) => box.write('itemsList', itemlist);

  dynamic get ean13 => box.read('ean13');
  void setEan13(dynamic ean13) => box.write('ean13', ean13);

  int get indexArticle => box.read('indexArticle');
  void setIndexArticle(int index) => box.write('indexArticle', index);

  void deleteItemList(int index) {
    this.itemsList.removeAt(index);
  }

  void editItemList(int index, int qty) {
    this.itemsList[index]['qtyArticle'] = qty;
  }
}
