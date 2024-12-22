import 'package:get/get.dart';
import 'package:thedaging/app/modules/auth/views/login.dart';
import 'package:thedaging/app/modules/auth/views/register.dart';
import 'package:thedaging/app/modules/profile/bindings/profile_binding.dart';
import 'package:thedaging/app/modules/profile/views/profile_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/menudaging/bindings/daging_binding.dart';
import '../modules/menudaging/views/dagingdetails.dart';
import '../modules/profile/views/edit_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => MainPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.DETAILS,
      page: () => DagingDetails(
        itemData: Get.arguments['itemData'],
        description: Get.arguments['description'],
      ),
      binding: MenuDagingBinding(),
    ),
    GetPage(
      name: _Paths.EDITPROFILE,
      page: () => EditProfileView(),

    ),
    // GetPage(
    //   name: _Paths.ITEMS,
    //   page: () => {},
    //   binding: ItemsBinding(),
    // ),
  ];
}
