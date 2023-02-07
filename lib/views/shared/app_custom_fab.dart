import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controllers/bottom_navigation_controller.dart';
import '../../core/constants/assets.dart';
import '../../routing/app_router.dart';
import '../screens/partners_screen/agencies_screen/add_agency_dialog.dart';
import '../screens/partners_screen/noters_screen/add_noter_dialog.dart';
import '../screens/notes_screen/add_note_dialog.dart';
import '../screens/partners_screen/service_providers_screen/add_service_provider_dialog.dart';

const btnSize = 55.0;
const iconColor = Colors.white;
const svgIconWidth = 30.0;
const svgIconHeight = 30.0;

class AppCustomFAB extends StatefulWidget {
  const AppCustomFAB({super.key});

  @override
  State<AppCustomFAB> createState() => _AppCustomFABState();
}

class _AppCustomFABState extends State<AppCustomFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final bottomBarController = Get.find<BottomNavigationController>();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _expandButtons() {
    if (controller.status == AnimationStatus.completed) {
      bottomBarController.setFABfalse();
      controller.reverse();
    } else {
      bottomBarController.setFABtrue();
      controller.forward();
    }
  }

  void _navigateAndClose(String routeName) {
    _expandButtons();
    Get.toNamed(routeName);
    bottomBarController.setFABfalse();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
        delegate: MyFlowMenuDelegate(controller),
        clipBehavior: Clip.none,
        children: [
          SecondaryFAB(
            isVisible: false,
            heroTag: '3',
            icon: Icons.beenhere_outlined,
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AddNoterDialog(),
            ),
          ),
          SecondaryFAB(
            isVisible: true,
            heroTag: '0',
            child: SvgPicture.asset(
              AssetsManager.transactionIcon,
              width: svgIconWidth,
              height: svgIconHeight,
              color: iconColor,
            ),
            icon: Icons.feed_outlined,
            onPressed: () => _navigateAndClose(AppRoutes.addTransactionScreen),
          ),
          SecondaryFAB(
            isVisible: true,
            heroTag: '1',
            child: SvgPicture.asset(
              AssetsManager.partnersIcon,
              width: svgIconWidth,
              height: svgIconHeight,
              color: iconColor,
            ),
            icon: Icons.groups_outlined,
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AddAgencyDialog(),
            ),
          ),
          SecondaryFAB(
            isVisible: true,
            heroTag: '2',
            child: SvgPicture.asset(
              AssetsManager.providerIcon,
              width: svgIconWidth,
              height: svgIconHeight,
              color: iconColor,
            ),
            icon: FontAwesomeIcons.user,
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AddServiceProviderDialog(),
            ),
          ),
          SecondaryFAB(
            isVisible: false,
            heroTag: '4',
            icon: Icons.note_alt_outlined,
            onPressed: () async => showDialog(
              context: context,
              builder: (context) => AddNoteDialog(),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                painter: HalfCirclePainter(),
              ),
              SecondaryFAB(
                isVisible: true,
                isMain: true,
                icon: Icons.add,
                heroTag: '5',
                onPressed: _expandButtons,
              ),
            ],
          )
        ]);
  }
}

class SecondaryFAB extends StatelessWidget {
  const SecondaryFAB({
    super.key,
    this.child,
    this.isMain,
    required this.isVisible,
    required this.heroTag,
    required this.icon,
    required this.onPressed,
  });
  final bool? isMain;
  final IconData icon;
  final String heroTag;
  final VoidCallback? onPressed;
  final Widget? child;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: !isVisible ? 0 : btnSize,
      height: !isVisible ? 0 : btnSize,
      child: FloatingActionButton(
        heroTag: heroTag,
        elevation: 0,
        onPressed: onPressed,
        child: !isVisible
            ? null
            : child != null
                ? child
                : (isMain == true)
                    ? GetBuilder<BottomNavigationController>(
                        builder: (controller) {
                        final isExpanded = controller.fabExpanded;
                        return AnimatedRotation(
                            duration: Duration(milliseconds: 250),
                            turns: isExpanded ? 0.135 : 0,
                            child: Icon(icon, color: Colors.white, size: 30));
                      })
                    : Icon(
                        icon,
                        color: Colors.white,
                        size: 25,
                      ),
      ),
    );
  }
}

class MyFlowMenuDelegate extends FlowDelegate {
  MyFlowMenuDelegate(this.controller) : super(repaint: controller);
  final Animation<double> controller;
  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - btnSize;
    final yStart = size.height - btnSize;

    final childrenCount = context.childCount;
    final radius = 90 * controller.value;
    for (int i = 0; i < childrenCount; i++) {
      final isLastItem = i == context.childCount - 1;
      setValue(value) => isLastItem ? 0.0 : value;
      final theta = i * pi * 0.5 / (childrenCount - 4);
      final x = xStart - (xStart * 0.5) - setValue(radius * cos(theta));
      final y = yStart - setValue(radius * sin(theta));
      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(x, y, 0)
          ..translate(btnSize / 2, btnSize / 2)
          ..rotateZ(isLastItem ? 0.0 : 180 * (1 - controller.value) * pi / 180)
          ..scale(isLastItem ? 1.0 : max(controller.value, 0.5))
          ..translate(-btnSize / 2, -btnSize / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return true;
  }
}

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;
    final center = Offset(size.width / 2, size.height);
    final radius = 27.0;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius), -pi, -pi, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
