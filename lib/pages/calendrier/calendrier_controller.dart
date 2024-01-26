import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksij_kinshasa/utils/requete.dart';

class CalendrierController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  final box = GetStorage();
  //
  Future<bool> getAllDate() async {
    Response response = await requete.getE("calendrier/all");
    if (response.isOk) {
      print(response.body);
      box.write("calendrier", response.body);
    }
    return true;
    ;
  }
}
