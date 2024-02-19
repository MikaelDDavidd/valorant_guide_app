import 'package:get_storage/get_storage.dart';
import 'package:valorant_guide_app/app/constants/app_storage_keys.dart';

class AppStrings {
  static String _getStringByLanguage(
      String englishString, String portugueseString) {
    var currentLanguage =
        GetStorage().read(AppStorageKeys.languageKey) ?? 'Português';

    if (currentLanguage == 'Português') {
      return portugueseString;
    } else {
      return englishString;
    }
  }

  static String get appTittleString =>
      _getStringByLanguage('Valorant Guide', 'Guia de Valorant');
      static String get selectAgent =>
      _getStringByLanguage('Select your Agent', 'Escolha seu \nnovo Agente');
      static String get selectMap =>
      _getStringByLanguage('Select your Map', 'Escolha seu \nnovo Mapa');
}
