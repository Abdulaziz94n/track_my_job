import 'package:flutter/material.dart';
import '../../../core/extensions/build_context_extension.dart';
import '../../../core/extensions/string_extension.dart';
import '../../core/theme/decorations.dart';
import '../../models/agency.dart';
import '../../models/noter.dart';
import '../../models/service_provider.dart';
import 'app_text.dart';

///
class AppDropDownField<E> extends StatelessWidget {
  const AppDropDownField(
      {super.key,
      required this.label,
      required this.items,
      required this.onSelect,
      this.prefixIcon,
      this.menuMaxHeight,
      this.isExpanded = false,
      this.initialValue,
      this.validator});
  final String label;
  final List<DropdownMenuItem<E>> items;
  final Widget? prefixIcon;
  final String? Function(E?)? validator;
  final ValueChanged<E?>? onSelect;
  final E? initialValue;
  final bool isExpanded;
  final double? menuMaxHeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        child: DropdownButtonFormField<E>(
          items: items,
          value: initialValue,
          onChanged: onSelect,
          validator: validator,
          isExpanded: isExpanded,
          decoration: WidgetsDecoration.textFieldDecoration(context).copyWith(
            label: AppText(
              text: label,
              style: context.appTextTheme.bodyMedium!
                  .copyWith(color: Colors.grey.shade600),
            ),
            prefixIcon: prefixIcon,
            prefixIconConstraints:
                const BoxConstraints(maxWidth: 40, minWidth: 35),
          ),
        ),
      ),
    );
  }
}

List<DropdownMenuItem<T>> appDropDownItems<T>(
    BuildContext context, List<T> items) {
  return items
      .map((T e) => DropdownMenuItem<T>(
          value: e,
          child: FittedBox(
            fit: BoxFit.none,
            child: AppText(
              style: context.appTextTheme.bodyMedium!,
              text: e is Agency
                  ? e.name.capitalizeFirst
                  : e is ServiceProvider
                      ? e.name.capitalizeFirst
                      : e is Noter
                          ? e.id.capitalizeFirst
                          : e.toString().capitalizeFirst,
            ),
          )))
      .toList();
}
