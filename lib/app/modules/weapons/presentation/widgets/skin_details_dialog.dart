import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/entities/weapon_entity.dart';

class SkinDetailsDialog extends StatefulWidget {
  final SkinEntity skin;
  final Color accentColor;

  const SkinDetailsDialog({
    Key? key,
    required this.skin,
    required this.accentColor,
  }) : super(key: key);

  static void show(BuildContext context, SkinEntity skin, Color accentColor) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Skin Details',
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SkinDetailsDialog(skin: skin, accentColor: accentColor);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<SkinDetailsDialog> createState() => _SkinDetailsDialogState();
}

class _SkinDetailsDialogState extends State<SkinDetailsDialog>
    with SingleTickerProviderStateMixin {
  int _selectedChromaIndex = 0;
  int _selectedLevelIndex = -1;
  bool _showingVideo = false;
  VideoPlayerController? _videoController;
  bool _isVideoLoading = false;
  bool _videoError = false;
  int _loadingLevelIndex = -1;

  late AnimationController _bulletAnimController;
  late Animation<double> _bulletAnim;

  List<ChromaEntity> get _chromas => widget.skin.chromas;
  List<LevelEntity> get _levelsWithVideo =>
      widget.skin.levels.where((l) => l.streamedVideo != null).toList();

  ChromaEntity? get _selectedChroma =>
      _chromas.isNotEmpty ? _chromas[_selectedChromaIndex] : null;

  String? get _displayImage {
    if (_selectedChroma?.fullRender != null) {
      return _selectedChroma!.fullRender;
    }
    if (_selectedChroma?.displayIcon != null) {
      return _selectedChroma!.displayIcon;
    }
    return widget.skin.displayIcon;
  }

  @override
  void initState() {
    super.initState();
    _bulletAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
    _bulletAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _bulletAnimController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bulletAnimController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _loadVideo(String url, int levelIndex) async {
    setState(() {
      _isVideoLoading = true;
      _videoError = false;
      _loadingLevelIndex = levelIndex;
      _selectedLevelIndex = levelIndex;
    });

    _videoController?.dispose();

    try {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(url));
      await _videoController!.initialize();
      _videoController!.setLooping(true);
      _videoController!.play();

      setState(() {
        _isVideoLoading = false;
        _showingVideo = true;
        _loadingLevelIndex = -1;
      });
    } catch (e) {
      setState(() {
        _isVideoLoading = false;
        _videoError = true;
        _loadingLevelIndex = -1;
      });
    }
  }

  void _selectLevel(int index) {
    if (_loadingLevelIndex != -1) return;
    if (index == _selectedLevelIndex && _showingVideo) return;

    final levels = _levelsWithVideo;
    if (index < levels.length && levels[index].streamedVideo != null) {
      _loadVideo(levels[index].streamedVideo!, index);
    }
  }

  void _stopVideo() {
    _videoController?.pause();
    setState(() {
      _showingVideo = false;
      _selectedLevelIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        decoration: BoxDecoration(
          color: AppColors.detailListBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.accentColor.withAlpha(100),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.accentColor.withAlpha(50),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildImageArea(),
                        if (_chromas.length > 1) _buildChromaSelector(),
                        if (_levelsWithVideo.isNotEmpty) _buildVideoSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.accentColor.withAlpha(60),
            widget.accentColor.withAlpha(20),
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: widget.accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.skin.displayName,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(50),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.close,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageArea() {
    return Stack(
      children: [
        if (widget.skin.wallpaper != null)
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: widget.skin.wallpaper!,
              fit: BoxFit.cover,
              color: Colors.black.withAlpha(150),
              colorBlendMode: BlendMode.darken,
              errorWidget: (context, url, error) => const SizedBox(),
            ),
          ),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: widget.skin.wallpaper == null
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      widget.accentColor.withAlpha(30),
                      Colors.transparent,
                    ],
                  )
                : null,
          ),
          child: _isVideoLoading
              ? _buildBulletLoading()
              : _showingVideo
                  ? _buildVideoPlayer()
                  : _buildSkinImage(),
        ),
      ],
    );
  }

  Widget _buildBulletLoading() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _bulletAnim,
            builder: (context, child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  final delay = index * 0.15;
                  final progress = (_bulletAnim.value - delay).clamp(0.0, 1.0);
                  final opacity = progress < 0.5
                      ? progress * 2
                      : 2 - progress * 2;
                  final scale = 0.6 + (opacity * 0.4);

                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.circle,
                        size: 12,
                        color: widget.accentColor.withAlpha((opacity * 255).toInt()),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.downloading,
                color: widget.accentColor.withAlpha(150),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Carregando...',
                style: TextStyle(
                  color: widget.accentColor.withAlpha(200),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkinImage() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CachedNetworkImage(
        imageUrl: _displayImage ?? '',
        fit: BoxFit.contain,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: AppColors.grey.withAlpha(30),
          highlightColor: AppColors.grey.withAlpha(60),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.image_not_supported,
          color: AppColors.grey.withAlpha(100),
          size: 48,
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_videoError || _videoController == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.videocam_off,
              color: AppColors.grey.withAlpha(100),
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              'Erro ao carregar vídeo',
              style: TextStyle(
                color: AppColors.grey.withAlpha(150),
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          if (_videoController!.value.isPlaying) {
            _videoController!.pause();
          } else {
            _videoController!.play();
          }
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            ),
          ),
          if (!_videoController!.value.isPlaying)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(120),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: widget.accentColor,
                size: 32,
              ),
            ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: _stopVideo,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(150),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.close,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChromaSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.palette,
                color: widget.accentColor,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'VARIANTES',
                style: TextStyle(
                  color: widget.accentColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_chromas.length, (index) {
                final chroma = _chromas[index];
                final isSelected = index == _selectedChromaIndex;
                final hasImage = chroma.displayIcon != null || chroma.fullRender != null;

                return GestureDetector(
                  onTap: () {
                    if (_showingVideo) _stopVideo();
                    setState(() {
                      _selectedChromaIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? widget.accentColor.withAlpha(40)
                          : Colors.black.withAlpha(50),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? widget.accentColor
                            : widget.accentColor.withAlpha(30),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: hasImage
                          ? CachedNetworkImage(
                              imageUrl: chroma.displayIcon ?? chroma.fullRender ?? '',
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) => _buildChromaPlaceholder(index),
                            )
                          : _buildChromaPlaceholder(index),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChromaPlaceholder(int index) {
    final colors = [
      Colors.grey,
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.purple,
      Colors.orange,
    ];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors[index % colors.length].withAlpha(100),
            colors[index % colors.length].withAlpha(50),
          ],
        ),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: colors[index % colors.length],
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildVideoSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.accentColor.withAlpha(50),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.play_circle_outline,
                color: widget.accentColor,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'EFEITOS',
                style: TextStyle(
                  color: widget.accentColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_levelsWithVideo.length, (index) {
              final level = _levelsWithVideo[index];
              final isSelected = _showingVideo && index == _selectedLevelIndex;
              final isLoading = _loadingLevelIndex == index;
              final levelName = _getLevelDisplayName(level.levelItem);

              return GestureDetector(
                onTap: () => _selectLevel(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: isSelected || isLoading
                        ? LinearGradient(
                            colors: [
                              widget.accentColor.withAlpha(80),
                              widget.accentColor.withAlpha(40),
                            ],
                          )
                        : null,
                    color: isSelected || isLoading ? null : Colors.black.withAlpha(50),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected || isLoading
                          ? widget.accentColor
                          : widget.accentColor.withAlpha(40),
                      width: isSelected || isLoading ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isLoading)
                        const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                            strokeWidth: 2,
                          ),
                        )
                      else
                        Icon(
                          _getLevelIcon(level.levelItem),
                          color: isSelected ? AppColors.white : widget.accentColor,
                          size: 14,
                        ),
                      const SizedBox(width: 8),
                      Text(
                        isLoading ? 'Carregando...' : levelName,
                        style: TextStyle(
                          color: isSelected || isLoading ? AppColors.white : AppColors.grey,
                          fontWeight: isSelected || isLoading ? FontWeight.w600 : FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  String _getLevelDisplayName(String? levelItem) {
    if (levelItem == null) return 'Prévia';
    final name = levelItem.split('::').last;
    switch (name.toLowerCase()) {
      case 'vfx':
        return 'Efeitos';
      case 'animation':
        return 'Animação';
      case 'finisher':
        return 'Finalização';
      case 'killcounter':
        return 'Contador';
      case 'killbanner':
        return 'Banner';
      default:
        return name;
    }
  }

  IconData _getLevelIcon(String? levelItem) {
    if (levelItem == null) return Icons.visibility;
    final name = levelItem.split('::').last.toLowerCase();
    switch (name) {
      case 'vfx':
        return Icons.auto_awesome;
      case 'animation':
        return Icons.animation;
      case 'finisher':
        return Icons.sports_score;
      case 'killcounter':
        return Icons.tag;
      case 'killbanner':
        return Icons.flag;
      default:
        return Icons.play_circle;
    }
  }
}
