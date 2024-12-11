import 'package:get/get.dart';

import '../controllers/menuadmin_controller.dart';

class MenuAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuAdminController>(
      () => MenuAdminController(),
    );
  }
}
