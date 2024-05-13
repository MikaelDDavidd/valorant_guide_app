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
      static String get ascent =>
      _getStringByLanguage('An open playground for small wars of position and attrition divide two sites on Ascent. Each site can be fortified by irreversible bomb doors; once they’re down, you’ll have to destroy them or find another way. Yield as little territory as possible.', 'Um playground aberto para pequenas guerras de posição e atrito divide dois locais em Ascent. Cada local pode ser fortificado com portas anti-bomba irreversíveis; uma vez caídos, você terá que destruí-los ou encontrar outra maneira. Renda o mínimo de território possível.');
      static String get split =>
      _getStringByLanguage('If you want to go far, you’ll have to go up. A pair of sites split by an elevated center allows for rapid movement using two rope ascenders. Each site is built with a looming tower vital for control. Remember to watch above before it all blows sky-high.', 'Se você quiser ir longe, terá que subir. Um par de locais divididos por um centro elevado permite um movimento rápido usando dois ascensores de corda. Cada local é construído com uma torre iminente, vital para o controle. Lembre-se de observar acima antes que tudo exploda às alturas.');
      static String get fracture =>
      _getStringByLanguage('A top secret research facility split apart by a failed radianite experiment. With defender options as divided as the map, the choice is yours: meet the attackers on their own turf or batten down the hatches to weather the assault.', 'Um centro de pesquisa ultrassecreto dividido por um experimento fracassado de radianita. Com opções de defesa tão divididas quanto o mapa, a escolha é sua: enfrentar os atacantes em seu próprio território ou fechar as escotilhas para resistir ao ataque.');
      static String get bind =>
      _getStringByLanguage('Two sites. No middle. Gotta pick left or right. What’s it going to be then? Both offer direct paths for attackers and a pair of one-way teleporters make it easier to flank.', 'Dois sites. Sem meio. Tenho que escolher esquerda ou direita. O que será então? Ambos oferecem caminhos diretos para atacantes e um par de teletransportadores unidirecionais facilitam o flanqueamento.');
      static String get breeze =>
      _getStringByLanguage('Take in the sights of historic ruins or seaside caves on this tropical paradise. But bring some cover. You will need them for the wide open spaces and long range engagements. Watch your flanks and this will be a Breeze.', 'Admire as vistas de ruínas históricas ou cavernas à beira-mar neste paraíso tropical. Mas traga alguma cobertura. Você precisará deles para espaços abertos e compromissos de longo alcance. Cuidado com seus flancos e isso será uma brisa.');
      static String get district =>
      _getStringByLanguage('none', 'Vazio');
      static String get kasbah =>
      _getStringByLanguage('none', 'vazio');
      static String get drift =>
      _getStringByLanguage('none', 'vazio');
      static String get piazza =>
      _getStringByLanguage('none', 'vazio');
      static String get lotus =>
      _getStringByLanguage('A mysterious structure housing an astral conduit radiates with ancient power. Great stone doors provide a variety of movement opportunities and unlock the paths to three mysterious sites.', 'Uma estrutura misteriosa que abriga um canal astral irradia um poder antigo. Grandes portas de pedra oferecem uma variedade de oportunidades de movimento e desbloqueiam caminhos para três locais misteriosos.');
      static String get sunset =>
      _getStringByLanguage('A disaster at a local kingdom facility threatens to engulf the whole neighborhood. Stop at your favorite food truck then fight across the city in this traditional three lane map.', 'Um desastre em uma instalação do reino local ameaça engolir toda a vizinhança. Pare no seu food truck favorito e lute pela cidade neste tradicional mapa de três pistas.');
      static String get pearl =>
      _getStringByLanguage('Attackers push down into the Defenders on this two-site map set in a vibrant, underwater city. Pearl is a geo-driven map with no mechanics. Take the fight through a compact mid or the longer range wings in our first map set in Omega Earth.', 'Os atacantes atacam os Defensores neste mapa de dois locais situado em uma cidade subaquática vibrante. Pearl é um mapa geograficamente sem mecânica. Lute através de asas compactas de médio ou longo alcance em nosso primeiro mapa ambientado em Omega Earth.');
      static String get icebox =>
      _getStringByLanguage('Your next battleground is a secret Kingdom excavation site overtaken by the arctic. The two plant sites protected by snow and metal require some horizontal finesse. Take advantage of the ziplines and they will never see you coming.', 'Seu próximo campo de batalha é um local secreto de escavação do Reino dominado pelo Ártico. Os dois locais de plantas protegidos por neve e metal exigem alguma sutileza horizontal. Aproveite as tirolesas e eles nunca verão você chegando.');
      static String get haven =>
      _getStringByLanguage('Beneath a forgotten monastery, a clamour emerges from rival Agents clashing to control three sites. There’s more territory to control, but defenders can use the extra real estate for aggressive pushes.', 'Abaixo de um mosteiro esquecido, surge um clamor de Agentes rivais que se enfrentam para controlar três locais. Há mais território para controlar, mas os defensores podem usar o espaço extra para ataques agressivos.');
}
