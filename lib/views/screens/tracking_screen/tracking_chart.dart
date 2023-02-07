import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/noters_controller.dart';
import '../../../controllers/transactions_controller.dart';
import '../../shared/app_card.dart';

import '../../../models/transaction.dart';

class TrackingChart extends GetView<TransactionsController> {
  const TrackingChart({super.key, required this.year});
  final int year;
  NotersController get notersController => Get.find();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.grey.shade300,
          borderData: FlBorderData(show: false),
          minX: 1,
          maxX: 12,
          minY: 0,
          maxY: 80000,
          lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                fitInsideVertically: true,
                fitInsideHorizontally: true,
              )),
          titlesData: _buildTitlesData(),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(
              strokeWidth: 01,
              color: Colors.black45,
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              show: true,
              isCurved: false,
              dotData: FlDotData(show: false),
              barWidth: 2,
              belowBarData:
                  BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
              spots: [
                FlSpot(1, monthlyProfit(month: 1, year: year)),
                FlSpot(2, monthlyProfit(month: 2, year: year)),
                FlSpot(3, monthlyProfit(month: 3, year: year)),
                FlSpot(4, monthlyProfit(month: 4, year: year)),
                FlSpot(5, monthlyProfit(month: 5, year: year)),
                FlSpot(6, monthlyProfit(month: 6, year: year)),
                FlSpot(7, monthlyProfit(month: 7, year: year)),
                FlSpot(8, monthlyProfit(month: 8, year: year)),
                FlSpot(9, monthlyProfit(month: 9, year: year)),
                FlSpot(10, monthlyProfit(month: 10, year: year)),
                FlSpot(11, monthlyProfit(month: 11, year: year)),
                FlSpot(12, monthlyProfit(month: 12, year: year)),
              ],
            )
          ],
        ),
      ),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true,
      topTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          return const Text('');
        },
      )),
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          return Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: AutoSizeText(
              minFontSize: 10,
              maxLines: 2,
              meta.formattedValue,
              style: const TextStyle(fontSize: 10),
            ),
          );
        },
      )),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 20,
        getTitlesWidget: (value, meta) => const SizedBox.shrink(),
      )),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          getTitlesWidget: (value, meta) {
            return meta.formattedValue == '0'
                ? const SizedBox.shrink()
                : AutoSizeText(
                    minFontSize: 10,
                    maxLines: 2,
                    meta.formattedValue,
                    style: const TextStyle(fontSize: 10),
                  );
          },
        ),
      ),
    );
  }

  double monthlyProfit({required int month, int? year}) {
    double monthlyTotal = 0.0;
    double noterMonthlyTotal = 0;
    if (year == null) year = DateTime.now().year;
    final noters = notersController.notersList;
    for (var noter in noters) {
      if (noter.monthlyProfits!['$month-$year'] != null) {
        noterMonthlyTotal += noter.monthlyProfits!['$month-$year']!;
      }
    }

    List<Transaction> monthTrans = controller.chartData
        .where((element) => element.dateTime.month == month)
        .toList();
    for (var transaction in monthTrans) {
      monthlyTotal += transaction.netProfit;
    }
    return monthlyTotal + noterMonthlyTotal;
  }
}
