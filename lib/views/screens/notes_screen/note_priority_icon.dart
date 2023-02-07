import 'package:flutter/material.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/enums/note_priority.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../shared/spacing_widgets.dart';

class NotePriorityIcon extends StatelessWidget {
  const NotePriorityIcon({super.key, required this.priority});
  final NotePriority priority;
  @override
  Widget build(BuildContext context) {
    final isNormal = priority == NotePriority.normal;
    final isVeryImportant = priority == NotePriority.veryImportant;
    return Row(
      children: [
        ColoredBox(
          color: context.secondaryColor,
          child: SizedBox(
            width: Sizes.p4,
            height: Sizes.p32,
          ),
        ),
        HorizontalSpacingWidget(Sizes.p4),
        ColoredBox(
          color: isNormal ? Colors.white : context.secondaryColor,
          child: SizedBox(
            width: Sizes.p4,
            height: Sizes.p32,
          ),
        ),
        HorizontalSpacingWidget(Sizes.p4),
        ColoredBox(
          color: !isVeryImportant ? Colors.white : context.secondaryColor,
          child: SizedBox(
            width: Sizes.p4,
            height: Sizes.p32,
          ),
        ),
        HorizontalSpacingWidget(Sizes.p4),
      ],
    );
  }
}
