// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/match/domain/entities/match_entity.dart';
import 'package:valorant_guide_app/app/modules/match/presentation/controllers/match_controller.dart';
import 'package:valorant_guide_app/app/modules/match/presentation/widgets/kill_feed_card.dart';
import 'package:valorant_guide_app/app/modules/match/presentation/widgets/player_scoreboard_card.dart';
import 'package:valorant_guide_app/app/modules/match/presentation/widgets/round_timeline_card.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  final ScrollController _scrollController = ScrollController();
  final RxBool _showBackToTop = false.obs;
  final MatchController controller = Get.find<MatchController>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 300 && !_showBackToTop.value) {
        _showBackToTop.value = true;
      } else if (_scrollController.offset < 300 && _showBackToTop.value) {
        _showBackToTop.value = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.appColorsTheme[0].background,
        floatingActionButton: Obx(() => AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showBackToTop.value ? 1.0 : 0.0,
              child: IgnorePointer(
                ignoring: !_showBackToTop.value,
                child: FloatingActionButton(
                  onPressed: _scrollToTop,
                  backgroundColor: AppColors.selectedTabColor,
                  child: const Icon(Icons.arrow_upward, color: Colors.white),
                ),
              ),
            )),
        body: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.selectedTabColor,
              ));
            }

            if (controller.failure.value != null) {
              return Center(
                  child: Text('Error: ${controller.failure.value!.message}'));
            }

            if (controller.match.value == null) {
              return const Center(child: Text('Match not found'));
            }

            final match = controller.match.value!;
            final metadata = match.metadata;
            final teams = match.teams;

            return NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: AppColors.appColorsTheme[0].background,
                    surfaceTintColor: Colors.transparent,
                    expandedHeight: 360.0,
                    floating: false,
                    pinned: true,
                    leading: const SizedBox(),
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: _buildHeader(metadata, teams),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(48),
                      child: Container(
                        color: AppColors.appColorsTheme[0].background,
                        child: const TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: AppColors.grey,
                          indicatorColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 3,
                          dividerColor: Colors.transparent,
                          tabs: [
                            Tab(
                              height: 40,
                              child: Center(child: Text('SCOREBOARD')),
                            ),
                            Tab(
                              height: 40,
                              child: Center(child: Text('ROUNDS')),
                            ),
                            Tab(
                              height: 40,
                              child: Center(child: Text('KILLS')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  _buildScoreboard(),
                  _buildRoundsTimeline(),
                  _buildKillsFeed(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(MetadataEntity metadata, TeamsEntity teams) {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.gradientStartColor,
            AppColors.gradientEndColor,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Image (Map Splash)
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/body.png'), // Placeholder or Map Splash if available
                          fit: BoxFit.cover))),
            ),
          ),
          // Bottom Gradient Fade
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
                    AppColors.appColorsTheme[0].background,
                  ],
                ),
              ),
            ),
          ),
          // Content
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 48, // Space for TabBar
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    const Spacer(),
                    _buildTeamScore(teams),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              metadata.map.toUpperCase(),
                              style: const TextStyle(
                                fontFamily: 'Rubik',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
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
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                metadata.mode.toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildInfoChip(Icons.timer,
                                '${(metadata.gameLength / 60000).toStringAsFixed(0)} MIN'),
                            const SizedBox(height: 8),
                            _buildInfoChip(Icons.calendar_today,
                                metadata.gameStartPatched.split(',')[0]),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamScore(TeamsEntity teams) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              '${teams.red.roundsWon}',
              style: const TextStyle(
                fontFamily: 'Rubik',
                color: AppColors.red,
                fontSize: 56,
                fontWeight: FontWeight.w700,
                shadows: [
                  Shadow(
                    color: Colors.black45,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            const Text(
              'DEF', // Assuming Red starts Def or just label
              style: TextStyle(
                fontFamily: 'Rubik',
                color: AppColors.red,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'VS',
            style: TextStyle(
              fontFamily: 'Rubik',
              color: Colors.white.withOpacity(0.5),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              '${teams.blue.roundsWon}',
              style: const TextStyle(
                fontFamily: 'Rubik',
                color: AppColors.blue,
                fontSize: 56,
                fontWeight: FontWeight.w700,
                shadows: [
                  Shadow(
                    color: Colors.black45,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            const Text(
              'ATK', // Assuming Blue starts Atk or just label
              style: TextStyle(
                fontFamily: 'Rubik',
                color: AppColors.blue,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.selectedTabColor,
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Rubik',
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Rubik',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScoreboard() {
    final match = controller.match.value!;
    final allPlayers = match.players.allPlayers;
    final redTeam =
        allPlayers.where((p) => p.team.toLowerCase() == 'red').toList();
    final blueTeam =
        allPlayers.where((p) => p.team.toLowerCase() == 'blue').toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('RED TEAM', AppColors.red),
          const SizedBox(height: 16),
          ...redTeam.map((player) => PlayerScoreboardCard(player: player)),
          const SizedBox(height: 32),
          _buildSectionTitle('BLUE TEAM', AppColors.blue),
          const SizedBox(height: 16),
          ...blueTeam.map((player) => PlayerScoreboardCard(player: player)),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildRoundsTimeline() {
    final rounds = controller.match.value!.rounds;
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: rounds.length,
      itemBuilder: (context, index) {
        final round = rounds[index];
        return RoundTimelineCard(round: round, roundNumber: index + 1);
      },
    );
  }

  Widget _buildKillsFeed() {
    final kills = controller.match.value!.kills;
    final allPlayers = controller.match.value!.players.allPlayers;
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: kills.length,
      itemBuilder: (context, index) {
        final kill = kills[index];
        return KillFeedCard(kill: kill, allPlayers: allPlayers);
      },
    );
  }
}