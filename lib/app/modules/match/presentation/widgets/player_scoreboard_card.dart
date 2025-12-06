import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/match/domain/entities/match_entity.dart';

class PlayerScoreboardCard extends StatefulWidget {
  final PlayerDetailEntity player;

  const PlayerScoreboardCard({Key? key, required this.player}) : super(key: key);

  @override
  _PlayerScoreboardCardState createState() => _PlayerScoreboardCardState();
}

class _PlayerScoreboardCardState extends State<PlayerScoreboardCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isRedTeam = widget.player.team.toLowerCase() == 'red';
    final teamColor = isRedTeam ? AppColors.red : AppColors.blue;

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.detailListBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isExpanded ? teamColor.withOpacity(0.5) : Colors.transparent,
            width: 1,
          ),
          boxShadow: _isExpanded
              ? [
                  BoxShadow(
                    color: teamColor.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 4,
                    decoration: BoxDecoration(
                      color: teamColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.player.assets.agent.small,
                      height: 40,
                      width: 40,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.player.name,
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              '#${widget.player.tag}',
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (widget.player.currenttierPatched.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  widget.player.currenttierPatched.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: teamColor,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _buildStatColumn('K', widget.player.stats.kills.toString(), isKey: true),
                  _buildStatColumn('D', widget.player.stats.deaths.toString()),
                  _buildStatColumn('A', widget.player.stats.assists.toString()),
                  _buildStatColumn('ACS', (widget.player.stats.score ~/ widget.player.stats.kills).toString()), // Approx ACS
                  const SizedBox(width: 12),
                ],
              ),
            ),
            if (_isExpanded) _buildExpandedContent(teamColor),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, {bool isKey = false}) {
    return Container(
      width: 40,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Rubik',
              color: isKey ? Colors.white : Colors.white.withOpacity(0.9),
              fontSize: 16,
              fontWeight: isKey ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Rubik',
              color: Colors.white.withOpacity(0.4),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(Color teamColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDetailItem('HEADSHOTS', '${widget.player.stats.headshots}', Icons.gps_fixed),
              _buildDetailItem('BODYSHOTS', '${widget.player.stats.bodyshots}', Icons.accessibility),
              _buildDetailItem('LEGSHOTS', '${widget.player.stats.legshots}', Icons.directions_walk),
            ],
          ),
          const Divider(color: Colors.white10, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDetailItem('DAMAGE', '${widget.player.damageMade}', Icons.flash_on, color: teamColor),
              _buildDetailItem('TAKEN', '${widget.player.damageReceived}', Icons.shield, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon, {Color color = Colors.white}) {
    return Column(
      children: [
        Icon(icon, color: color.withOpacity(0.7), size: 16),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Rubik',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.white.withOpacity(0.5),
            fontSize: 10,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}