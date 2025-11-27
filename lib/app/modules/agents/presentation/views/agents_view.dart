import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/entities/agent_entity.dart';
import 'package:valorant_guide_app/app/modules/agents/presentation/controllers/agents_controller.dart';
import 'package:valorant_guide_app/app/modules/agents/presentation/widgets/agent_card_skeleton.dart';
import 'package:valorant_guide_app/app/routes/app_pages.dart';

class AgentsView extends GetView<AgentsController> {
  const AgentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const AgentsGridSkeleton();
      }

      if (controller.error.value != null) {
        return Center(
          child: Text(
            controller.error.value!,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }

      if (controller.agents.isEmpty) {
        return const Center(
          child: Text(
            'Nenhum Item na Lista',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }

      return _buildGrid();
    });
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: controller.agents.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final agent = controller.agents[index];
        return _buildAgentCard(context, agent, index);
      },
    );
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
        .take(2)
        .map((hex) => _hexToColor(hex))
        .toList();
  }

  BorderRadius _getCardShape(int index) {
    final shapes = [
      const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(0),
      ),
      const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(20),
      ),
      const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(0),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      const BorderRadius.only(
        topLeft: Radius.circular(0),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ];
    return shapes[index % shapes.length];
  }

  Matrix4 _getCardTransform(int index) {
    final transforms = [
      Matrix4.identity()
        ..setEntry(3, 2, 0.01)
        ..rotateY(-0.05)
        ..rotateX(-0.08),
      Matrix4.identity()
        ..setEntry(3, 2, 0.01)
        ..rotateY(0.05)
        ..rotateX(-0.08),
      Matrix4.identity()
        ..setEntry(3, 2, 0.01)
        ..rotateY(-0.05)
        ..rotateX(0.05),
      Matrix4.identity()
        ..setEntry(3, 2, 0.01)
        ..rotateY(0.05)
        ..rotateX(0.05),
    ];
    return transforms[index % transforms.length];
  }

  Alignment _getTransformAlignment(int index) {
    final alignments = [
      FractionalOffset.bottomLeft,
      FractionalOffset.bottomRight,
      FractionalOffset.topLeft,
      FractionalOffset.topRight,
    ];
    return alignments[index % alignments.length];
  }

  Widget _buildAgentCard(BuildContext context, AgentEntity agent, int index) {
    final colors = _getAgentColors(agent);
    final shape = _getCardShape(index);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.AGENT_DETAILS, arguments: agent);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Transform(
            transform: _getCardTransform(index),
            alignment: _getTransformAlignment(index),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: shape,
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    colors.first.withAlpha(220),
                    colors.length > 1 ? colors[1].withAlpha(180) : colors.first.withAlpha(150),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: colors.first.withAlpha(80),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: shape,
                child: Opacity(
                  opacity: 0.15,
                  child: agent.background != null
                      ? CachedNetworkImage(
                          imageUrl: agent.background!,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const SizedBox(),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          ),
          Positioned(
            top: -15,
            left: -10,
            right: -10,
            bottom: 35,
            child: CachedNetworkImage(
              imageUrl: agent.fullPortrait ?? '',
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
              progressIndicatorBuilder: (context, url, progress) => Shimmer.fromColors(
                baseColor: AppColors.grey.withAlpha(30),
                highlightColor: AppColors.grey.withAlpha(60),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.person,
                color: AppColors.white,
                size: 60,
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agent.displayName.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: Colors.black87,
                        blurRadius: 6,
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  agent.role?.displayName ?? '',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: AppColors.white.withAlpha(180),
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    shadows: const [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 4,
                        offset: Offset(1, 1),
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
}
