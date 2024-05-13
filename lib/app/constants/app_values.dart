import 'package:get_storage/get_storage.dart';
import 'package:valorant_guide_app/app/constants/app_storage_keys.dart';

class AppValues {
  int themIndexValue = GetStorage().read(AppStorageKeys.themeKey) ?? 0;
}
