import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';

class CardSkeleton extends StatelessWidget {
  final BorderRadius borderRadius;
  final Matrix4? transform;
  final Alignment? transformAlignment;
  final double? height;
  final double? width;

  const CardSkeleton({
    Key? key,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.transform,
    this.transformAlignment,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget card = Shimmer.fromColors(
      baseColor: AppColors.detailListBackground,
      highlightColor: AppColors.darkPurple,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: AppColors.detailListBackground,
        ),
      ),
    );

    if (transform != null) {
      card = Transform(
        transform: transform!,
        alignment: transformAlignment ?? Alignment.center,
        child: card,
      );
    }

    return card;
  }
}

class MapsGridSkeleton extends StatelessWidget {
  const MapsGridSkeleton({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.01)
                ..rotateY(-0.06)
                ..rotateX(-0.1),
              alignment: FractionalOffset.bottomLeft,
              child: CardSkeleton(borderRadius: _getCardShape(index)),
            ),
            Positioned(
              left: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextSkeleton(70, 14),
                  const SizedBox(height: 6),
                  _buildTextSkeleton(50, 10),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextSkeleton(double width, double height) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withAlpha(50),
      highlightColor: AppColors.grey.withAlpha(100),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

class WeaponsGridSkeleton extends StatelessWidget {
  const WeaponsGridSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SizedBox(
            height: 140,
            child: Stack(
              children: [
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0009)
                    ..rotateY(-0.05)
                    ..rotateX(-0.5),
                  alignment: FractionalOffset.bottomLeft,
                  child: const CardSkeleton(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 30,
                  child: Shimmer.fromColors(
                    baseColor: AppColors.grey.withAlpha(40),
                    highlightColor: AppColors.grey.withAlpha(80),
                    child: Container(
                      height: 50,
                      width: 180,
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextSkeleton(80, 14),
                      const SizedBox(height: 6),
                      _buildTextSkeleton(50, 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextSkeleton(double width, double height) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withAlpha(50),
      highlightColor: AppColors.grey.withAlpha(100),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
