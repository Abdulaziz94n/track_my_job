import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/sizes.dart';
import '../../controllers/transactions_controller.dart';
import '../../../core/extensions/build_context_extension.dart';
import 'filter_button.dart';
import 'filters_row.dart';

class TransactionsFilters extends StatefulWidget {
  const TransactionsFilters({super.key});

  @override
  State<TransactionsFilters> createState() => _TransactionsFiltersState();
}

class _TransactionsFiltersState extends State<TransactionsFilters>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;
  late Size _filterButtonSize;
  Size _smallfilterButtonSize = Size(40, Sizes.p32);

  bool filterApplied = false;
  TransactionsController transactionsController =
      Get.find<TransactionsController>();

  @override
  void initState() {
    super.initState();
    scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: scaleController,
      curve: Curves.easeIn,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _filterButtonSize = Size(context.screenWidth * 0.20, Sizes.p32);
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: double.maxFinite,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: scaleAnimation,
              builder: (context, child) {
                return Container(
                  margin: EdgeInsets.only(
                      left: filterApplied
                          ? _smallfilterButtonSize.width + Sizes.p4
                          : 0.0),
                  child: Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()
                        ..scale(scaleAnimation.value),
                      child: FiltersRow()),
                );
              },
            ),
            FilterButton(
              isFiltered: filterApplied,
              isFilteredSize: _smallfilterButtonSize,
              isNotFilteredSize: _filterButtonSize,
              scaleController: scaleController,
              onPressed: () {
                if (scaleController.status == AnimationStatus.completed) {
                  setState(() {
                    filterApplied = false;
                    scaleController.reverse();
                    transactionsController.resetFilters();
                  });
                }
                if (scaleController.status == AnimationStatus.dismissed) {
                  setState(() {
                    filterApplied = true;
                    scaleController.forward();
                  });
                }
              },
            ),
          ],
        ),
      ),
    ).paddingOnly(left: Sizes.p8);
  }
}
