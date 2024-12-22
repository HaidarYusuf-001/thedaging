import 'package:get/get.dart';

import '../controllers/daging_controller.dart';
import '../controllers/dagingdetails.dart';


class MenuDagingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuDagingController>(
          () => MenuDagingController(),
    );
    Get.lazyPut<DagingDetailsController>(
          () => DagingDetailsController(),
    );
  }
}
