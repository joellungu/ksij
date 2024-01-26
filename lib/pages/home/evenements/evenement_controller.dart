import 'package:get/get.dart';
import 'package:ksij_kinshasa/utils/requete.dart';

class EvenementController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //

  Future<List> allEvents() async {
    //
    //change([], status: RxStatus.loading());
    //
    Response response = await requete.getE("evenement/all");

    if (response.isOk) {
      print("data: ${response.body}");
      //
      //change(response.body, status: RxStatus.success());
      return response.body;
    } else {
      //
      //change([], status: RxStatus.empty());
      return [];
    }
  }
}
