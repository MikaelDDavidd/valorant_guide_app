import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';

class AppDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTap;

  const AppDrawer({
    Key? key,
    required this.currentIndex,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.detailListBackground,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildSectionTitle('PRINCIPAL'),
                  _buildDrawerItem(
                    icon: Icons.person_outline,
                    title: 'Agentes',
                    index: 0,
                  ),
                  _buildDrawerItem(
                    icon: Icons.map_outlined,
                    title: 'Mapas',
                    index: 1,
                  ),
                  _buildDrawerItem(
                    icon: Icons.gps_fixed,
                    title: 'Armas',
                    index: 2,
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('EM BREVE'),
                  _buildDrawerItemDisabled(
                    icon: Icons.emoji_events_outlined,
                    title: 'Ranks',
                  ),
                  _buildDrawerItemDisabled(
                    icon: Icons.sports_esports_outlined,
                    title: 'Modos de Jogo',
                  ),
                  _buildDrawerItemDisabled(
                    icon: Icons.style_outlined,
                    title: 'Player Cards',
                  ),
                  _buildDrawerItemDisabled(
                    icon: Icons.search,
                    title: 'Buscar Jogador',
                  ),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          SizedBox(
            height: 48,
            width: 48,
            child: SvgPicture.asset('assets/icons/valorant_icon.svg'),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'VALORANT',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              Text(
                'Guia Completo',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Rubik',
          color: AppColors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final isSelected = currentIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.selectedTabColor.withOpacity(0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.selectedTabColor : AppColors.white,
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Rubik',
            color: isSelected ? AppColors.selectedTabColor : AppColors.white,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
          ),
        ),
        onTap: () {
          onItemTap(index);
          Get.back();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDrawerItemDisabled({
    required IconData icon,
    required String title,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.grey.withOpacity(0.5),
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Rubik',
            color: AppColors.grey.withOpacity(0.5),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.selectedTabColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'SOON',
            style: TextStyle(
              fontFamily: 'Rubik',
              color: AppColors.selectedTabColor,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ),
        onTap: null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Divider(color: AppColors.grey.withOpacity(0.3)),
          const SizedBox(height: 12),
          Text(
            'Feito com ❤️ para a comunidade',
            style: TextStyle(
              fontFamily: 'Rubik',
              color: AppColors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
