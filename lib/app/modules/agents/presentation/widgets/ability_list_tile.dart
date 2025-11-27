import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/agents/domain/entities/agent_entity.dart';

class AbilityListTile extends StatefulWidget {
  final AbilityEntity ability;
  final int themeIndex;
  final Color agentColor;

  const AbilityListTile({
    Key? key,
    required this.ability,
    required this.themeIndex,
    required this.agentColor,
  }) : super(key: key);

  @override
  State<AbilityListTile> createState() => _AbilityListTileState();
}

class _AbilityListTileState extends State<AbilityListTile> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  String _getSlotKey(String slot) {
    switch (slot.toLowerCase()) {
      case 'ability1':
        return 'Q';
      case 'ability2':
        return 'E';
      case 'grenade':
        return 'C';
      case 'ultimate':
        return 'X';
      case 'passive':
        return 'P';
      default:
        return '?';
    }
  }

  bool get _isUltimate => widget.ability.slot.toLowerCase() == 'ultimate';

  @override
  Widget build(BuildContext context) {
    final slotKey = _getSlotKey(widget.ability.slot);

    return GestureDetector(
      onTap: _toggleExpand,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isUltimate ? widget.agentColor.withAlpha(30) : AppColors.detailListBackground,
          borderRadius: BorderRadius.circular(12),
          border: _isUltimate
              ? Border.all(
                  color: widget.agentColor.withAlpha(100),
                  width: 1,
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  _buildSlotIndicator(slotKey),
                  const SizedBox(width: 12),
                  _buildAbilityIcon(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_isUltimate)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              'ULTIMATE',
                              style: TextStyle(
                                color: widget.agentColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        Text(
                          widget.ability.displayName.toUpperCase(),
                          style: TextStyle(
                            color: AppColors.appColorsTheme[widget.themeIndex].text,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.grey,
                      size: 24,
                    ),
                  ),
                ],
              ),
              SizeTransition(
                sizeFactor: _expandAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(30),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.ability.description,
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlotIndicator(String slotKey) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: _isUltimate ? widget.agentColor.withAlpha(200) : Colors.black.withAlpha(80),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: _isUltimate ? widget.agentColor : widget.agentColor.withAlpha(100),
          width: _isUltimate ? 2 : 1,
        ),
      ),
      child: Center(
        child: Text(
          slotKey,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildAbilityIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.agentColor.withAlpha(40),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(6),
      child: CachedNetworkImage(
        imageUrl: widget.ability.displayIcon ?? '',
        color: AppColors.white.withAlpha(230),
        progressIndicatorBuilder: (context, url, progress) => Shimmer.fromColors(
          baseColor: AppColors.grey.withAlpha(30),
          highlightColor: AppColors.grey.withAlpha(60),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.flash_on,
          color: widget.agentColor,
          size: 24,
        ),
      ),
    );
  }
}
