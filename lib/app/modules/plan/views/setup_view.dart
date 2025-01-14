import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../utils/constant/constant.dart';
import '../controllers/plan_controller.dart';
import 'dart:math' as math;

class SetupView extends GetView<PlanController> {
  const SetupView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.startLoadingAnimation();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Loading Animation
            SpinKitPouringHourGlassRefined(
              color: GColors.primary,
              size: 100.0,
              duration: const Duration(milliseconds: 2000),
            ),
            Gap(20),

            // Loading Messages
            Obx(() => Text(
                  controller.messages[controller.loadingMessageIndex.value],
                  style: Poppins.medium.copyWith(
                    fontSize: 16,
                    color: GColors.darkGrey,
                  ),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(height: 20),

            // Animated Dots
            _LoadingDots(),
          ],
        ),
      ),
    );
  }
}

class _LoadingDots extends StatefulWidget {
  const _LoadingDots({Key? key}) : super(key: key);

  @override
  _LoadingDotsState createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    _animations = List.generate(3, (index) {
      return DelayTween(
        begin: 0.0,
        end: 1.0,
        delay: index * 0.2,
      ).animate(_controller);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Transform.translate(
                offset: Offset(0, -4 * _animations[index].value),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: GColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

// Custom Delay Tween
class DelayTween extends Tween<double> {
  final double delay;

  DelayTween({
    required double begin,
    required double end,
    required this.delay,
  }) : super(begin: begin, end: end);

  @override
  double lerp(double t) {
    return super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);
  }
}
