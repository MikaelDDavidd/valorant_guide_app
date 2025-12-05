import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';
import 'package:valorant_guide_app/app/routes/app_pages.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _shakeController;
  late AnimationController _finalController;
  late AnimationController _textController;

  late Animation<double> _logoScale;
  late Animation<double> _shakeAnimation;
  late Animation<double> _logoMoveUp;
  late Animation<double> _logoFinalScale;
  late Animation<double> _textOpacity;
  late Animation<double> _textSlide;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimationSequence();
  }

  void _setupAnimations() {
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _finalController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _logoScale = Tween<double>(begin: 0.0, end: 1.2).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 30.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 30.0, end: -25.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -25.0, end: 20.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 20.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 0.0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
    );

    _logoMoveUp = Tween<double>(begin: 0.0, end: -20.0).animate(
      CurvedAnimation(parent: _finalController, curve: Curves.easeOutCubic),
    );

    _logoFinalScale = Tween<double>(begin: 1.2, end: 0.8).animate(
      CurvedAnimation(parent: _finalController, curve: Curves.easeOutCubic),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    _textSlide = Tween<double>(begin: 30.0, end: -10.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );
  }

  Future<void> _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));

    await _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 100));

    await _shakeController.forward();

    await Future.delayed(const Duration(milliseconds: 200));

    _finalController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    await _textController.forward();

    await Future.delayed(const Duration(milliseconds: 800));

    Get.offAllNamed(Routes.HOME);
  }

  @override
  void dispose() {
    _logoController.dispose();
    _shakeController.dispose();
    _finalController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColorsTheme[0].background,
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _logoController,
            _shakeController,
            _finalController,
            _textController,
          ]),
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(
                    _shakeAnimation.value,
                    _logoMoveUp.value,
                  ),
                  child: Transform.scale(
                    scale: _finalController.isAnimating || _finalController.isCompleted
                        ? _logoFinalScale.value
                        : _logoScale.value,
                    child: Image.asset(
                      'assets/logos/valorant-logo.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                Transform.translate(
                  offset: Offset(0, _textSlide.value),
                  child: Opacity(
                    opacity: _textOpacity.value,
                    child: Image.asset(
                      'assets/logos/valorant-text-logo.png',
                      width: 200,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
