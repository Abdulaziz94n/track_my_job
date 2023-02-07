import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../../core/extensions/string_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;

import '../../../../models/noter.dart';
import '../../../shared/no_items.dart';
import 'noter_tile.dart';

class NotersList extends StatelessWidget {
  const NotersList({super.key, required this.noters});
  final List<Noter> noters;
  @override
  Widget build(BuildContext context) {
    return noters.isEmpty
        ? Center(
            child: NoItemsWidget(
                text: translations.noNotery.tr.capitalizeFirstOfEach))
        : ListView.builder(
            itemCount: noters.length,
            itemBuilder: (context, index) => NoterTile(
                  noter: noters[index],
                ));
  }
}
