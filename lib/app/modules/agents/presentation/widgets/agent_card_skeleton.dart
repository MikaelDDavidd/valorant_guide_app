import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:valorant_guide_app/app/constants/app_colors.dart';

class AgentCardSkeleton extends StatelessWidget {
  final int index;

  const AgentCardSkeleton({Key? key, required this.index}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final shape = _getCardShape(index);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Transform(
          transform: _getCardTransform(index),
          alignment: _getTransformAlignment(index),
          child: Shimmer.fromColors(
            baseColor: AppColors.detailListBackground,
            highlightColor: AppColors.darkPurple,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: shape,
                color: AppColors.detailListBackground,
              ),
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
              Shimmer.fromColors(
                baseColor: AppColors.grey.withAlpha(50),
                highlightColor: AppColors.grey.withAlpha(100),
                child: Container(
                  height: 16,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Shimmer.fromColors(
                baseColor: AppColors.grey.withAlpha(30),
                highlightColor: AppColors.grey.withAlpha(60),
                child: Container(
                  height: 10,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AgentsGridSkeleton extends StatelessWidget {
  const AgentsGridSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: 8,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return AgentCardSkeleton(index: index);
      },
    );
  }
}
