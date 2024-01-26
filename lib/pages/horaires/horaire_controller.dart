import 'package:get/get.dart';
import 'package:ksij_kinshasa/utils/requete.dart';

class HoraireController extends GetxController with StateMixin<Map> {
  //
  Requete requete = Requete();
  //

  allPrayOfDay(String date) async {
    //
    change({}, status: RxStatus.loading());
    //
    Response response = await requete.getE("priere/one/$date");

    if (response.isOk) {
      print("data: ${response.body}");
      //
      change(response.body, status: RxStatus.success());
      //return response.body;
    } else {
      //
      change({}, status: RxStatus.empty());
      //return [];
    }
  }
}
