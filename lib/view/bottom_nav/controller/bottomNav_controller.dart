import 'package:sipnudge_task/import/custom_import.dart';

class BottomNavController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isFading = false.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
