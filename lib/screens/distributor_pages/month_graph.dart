import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonthGraph extends StatelessWidget {
  final Map<dynamic, dynamic> graphdata;
  const MonthGraph({super.key, required this.graphdata});

  @override
  Widget build(BuildContext context) {
    return graphdata.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : BarChart(
            BarChartData(
              //   baselineY: BorderSide.strokeAlignCenter,
              gridData: FlGridData(show: false),
              //  backgroundColor: Colors.white,

              barGroups: _chartGroups(),
              borderData: FlBorderData(
                border: Border.all(color: Colors.white),
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          );
                        })),
              ),
            ),
          );
  }

  List<BarChartGroupData> _chartGroups() {
    return graphdata.entries.map((entry) {
      return BarChartGroupData(
        x: int.parse(entry.key),
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: Colors.red,
          ),
        ],
      );
    }).toList();
  }

  SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      getTitlesWidget: (value, metadata) {
        return Text(
          (value.toInt()).toString(),
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
        );
      });
}
