import 'package:alquran/app/modules/detail_surah/controllers/detail_surah_controller.dart';
import 'package:get/get.dart';

class DetailJuzBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailSurahController>(() => DetailSurahController());
  }
}

