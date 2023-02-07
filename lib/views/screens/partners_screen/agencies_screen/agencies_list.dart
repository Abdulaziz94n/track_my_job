import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../../../core/extensions/string_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../models/agency.dart';

import '../../../shared/no_items.dart';
import 'agency_tile.dart';

class AgenciesList extends StatelessWidget {
  const AgenciesList({super.key, required this.agencies});
  final List<Agency> agencies;
  @override
  Widget build(BuildContext context) {
    return agencies.isEmpty
        ? Center(
            child:
                NoItemsWidget(text: translations.noAgency.tr.capitalizeFirst))
        : ListView.builder(
            itemCount: agencies.length,
            itemBuilder: (context, index) => AgencyTile(
                  agency: agencies[index],
                ));
  }
}
