import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/entities/agent_entity.dart';
import 'package:valorant_guide_app/app/modules/agents/presentation/controllers/agents_controller.dart';
import 'package:valorant_guide_app/app/modules/agents/presentation/widgets/ability_list_tile.dart';
import 'package:valorant_guide_app/app/routes/app_pages.dart';

class AgentDetailsView extends StatefulWidget {
  const AgentDetailsView({Key? key}) : super(key: key);

  @override
  State<AgentDetailsView> createState() => _AgentDetailsViewState();
}

class _AgentDetailsViewState extends State<AgentDetailsView> {
  late PageController _galleryController;
  int _currentGalleryIndex = 0;

  @override
  void initState() {
    super.initState();
    _galleryController = PageController();
  }

  @override
  void dispose() {
    _galleryController.dispose();
    super.dispose();
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 8) {
      final alpha = hex.substring(6, 8);
      final rgb = hex.substring(0, 6);
      hex = '$alpha$rgb';
    } else if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  List<Color> _getAgentColors(AgentEntity agent) {
    if (agent.backgroundGradientColors.isEmpty) {
      return [AppColors.gradientStartColor, AppColors.gradientEndColor];
    }
    return agent.backgroundGradientColors
        .take(4)
        .map((hex) => _hexToColor(hex))
        .toList();
  }

  List<Map<String, String>> _getGalleryImages(AgentEntity agent) {
    final images = <Map<String, String>>[];
    if (agent.fullPortrait != null) {
      images.add({'url': agent.fullPortrait!, 'label': 'Retrato'});
    }
    if (agent.bustPortrait != null) {
      images.add({'url': agent.bustPortrait!, 'label': 'Busto'});
    }
    if (agent.background != null) {
      images.add({'url': agent.background!, 'label': 'Arte de Fundo'});
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    final agent = ModalRoute.of(context)!.settings.arguments as AgentEntity;
    final controller = Get.find<AgentsController>();

    return Obx(() => Scaffold(
          backgroundColor:
              AppColors.appColorsTheme[controller.homeThemeIndex.value].background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildTopImage(agent, controller),
                _buildBiography(agent, controller),
                _buildRoleCard(agent, controller),
                _buildImageGallery(agent, controller),
                _buildSpecialAbilities(agent, controller),
                _buildRelatedAgents(agent, controller),
              ],
            ),
          ),
        ));
  }

  Widget _buildTopImage(AgentEntity agent, AgentsController controller) {
    final colors = _getAgentColors(agent);
    final primaryColor = colors.first;
    final secondaryColor = colors.length > 1 ? colors[1] : colors.first;

    return Container(
      height: 320.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor.withAlpha(255),
            secondaryColor.withAlpha(200),
            colors.length > 2 ? colors[2].withAlpha(150) : secondaryColor.withAlpha(100),
          ],
        ),
      ),
      child: Stack(
        children: [
          if (agent.background != null)
            Positioned.fill(
              child: Opacity(
                opacity: 0.15,
                child: CachedNetworkImage(
                  imageUrl: agent.background!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const SizedBox(),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.appColorsTheme[controller.homeThemeIndex.value]
                        .background
                        .withAlpha(255),
                  ],
                ),
              ),
            ),
          ),
          if (agent.fullPortrait != null)
            Positioned(
              right: -40,
              top: 20,
              bottom: -60,
              child: CachedNetworkImage(
                imageUrl: agent.fullPortrait!,
                fit: BoxFit.contain,
                width: 280,
                errorWidget: (context, url, error) => const SizedBox(),
              ),
            ),
          Positioned(
            left: 24,
            top: 60,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    agent.displayName.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      letterSpacing: 2.0,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 8,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  if (agent.role != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: primaryColor.withAlpha(150),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (agent.role!.displayIcon.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CachedNetworkImage(
                                  imageUrl: agent.role!.displayIcon,
                                  width: 16,
                                  height: 16,
                                  color: AppColors.white,
                                  errorWidget: (context, url, error) =>
                                      const SizedBox(),
                                ),
                              ),
                            Text(
                              agent.role!.displayName,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color agentColor, int themeIndex) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: agentColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            color: AppColors.appColorsTheme[themeIndex].text,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  agentColor.withAlpha(100),
                  agentColor.withAlpha(0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBiography(AgentEntity agent, AgentsController controller) {
    final colors = _getAgentColors(agent);
    final agentColor = colors.first;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'BIOGRAFIA',
            agentColor,
            controller.homeThemeIndex.value,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.detailListBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: agentColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.format_quote,
                      color: agentColor.withAlpha(150),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'História',
                      style: TextStyle(
                        color: agentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  agent.description,
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard(AgentEntity agent, AgentsController controller) {
    if (agent.role == null) return const SizedBox();

    final colors = _getAgentColors(agent);
    final agentColor = colors.first;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'CLASSE',
            agentColor,
            controller.homeThemeIndex.value,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.detailListBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: agentColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: agentColor.withAlpha(40),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: agentColor.withAlpha(100),
                      width: 1,
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: agent.role!.displayIcon,
                    color: agentColor,
                    errorWidget: (context, url, error) => Icon(
                      Icons.shield,
                      color: agentColor,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        agent.role!.displayName.toUpperCase(),
                        style: TextStyle(
                          color: agentColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        agent.role!.description,
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery(AgentEntity agent, AgentsController controller) {
    final colors = _getAgentColors(agent);
    final agentColor = colors.first;
    final images = _getGalleryImages(agent);

    if (images.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'GALERIA',
            agentColor,
            controller.homeThemeIndex.value,
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppColors.detailListBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: agentColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _galleryController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentGalleryIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: CachedNetworkImage(
                          imageUrl: images[index]['url']!,
                          fit: BoxFit.contain,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.broken_image,
                            color: AppColors.grey,
                            size: 48,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                      (index) => GestureDetector(
                        onTap: () {
                          _galleryController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentGalleryIndex == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentGalleryIndex == index
                                ? agentColor
                                : agentColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    images[_currentGalleryIndex]['label']!,
                    style: TextStyle(
                      color: agentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<AbilityEntity> _sortAbilities(List<AbilityEntity> abilities) {
    final order = {
      'passive': 0,
      'grenade': 1,
      'ability1': 2,
      'ability2': 3,
      'ultimate': 4,
    };
    final sorted = List<AbilityEntity>.from(abilities);
    sorted.sort((a, b) {
      final orderA = order[a.slot.toLowerCase()] ?? 99;
      final orderB = order[b.slot.toLowerCase()] ?? 99;
      return orderA.compareTo(orderB);
    });
    return sorted;
  }

  Widget _buildSpecialAbilities(
      AgentEntity agent, AgentsController controller) {
    final colors = _getAgentColors(agent);
    final agentColor = colors.first;
    final sortedAbilities = _sortAbilities(agent.abilities);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'HABILIDADES',
            agentColor,
            controller.homeThemeIndex.value,
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: sortedAbilities.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return AbilityListTile(
                ability: sortedAbilities[index],
                themeIndex: controller.homeThemeIndex.value,
                agentColor: agentColor,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedAgents(AgentEntity agent, AgentsController controller) {
    if (agent.role == null) return const SizedBox();

    final colors = _getAgentColors(agent);
    final agentColor = colors.first;

    final relatedAgents = controller.agents
        .where((a) =>
            a.role?.uuid == agent.role!.uuid && a.uuid != agent.uuid)
        .toList();

    if (relatedAgents.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'AGENTES RELACIONADOS',
            agentColor,
            controller.homeThemeIndex.value,
          ),
          const SizedBox(height: 8),
          Text(
            'Outros ${agent.role!.displayName}s',
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: relatedAgents.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final relatedAgent = relatedAgents[index];
                final relatedColors = _getAgentColors(relatedAgent);

                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.AGENT_DETAILS,
                      arguments: relatedAgent,
                    );
                  },
                  child: Container(
                    width: 90,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          relatedColors.first.withAlpha(150),
                          relatedColors.length > 1
                              ? relatedColors[1].withAlpha(100)
                              : relatedColors.first.withAlpha(80),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: relatedColors.first.withAlpha(80),
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: Stack(
                        children: [
                          if (relatedAgent.background != null)
                            Positioned.fill(
                              child: Opacity(
                                opacity: 0.15,
                                child: CachedNetworkImage(
                                  imageUrl: relatedAgent.background!,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const SizedBox(),
                                ),
                              ),
                            ),
                          Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CachedNetworkImage(
                                    imageUrl: relatedAgent.bustPortrait ??
                                        relatedAgent.fullPortrait ??
                                        '',
                                    fit: BoxFit.contain,
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.person,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(100),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(11),
                                    bottomRight: Radius.circular(11),
                                  ),
                                ),
                                child: Text(
                                  relatedAgent.displayName,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
