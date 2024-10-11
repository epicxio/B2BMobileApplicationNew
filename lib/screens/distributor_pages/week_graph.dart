import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeekGraph extends StatelessWidget {
  final Map<dynamic, dynamic> graphdata;
  const WeekGraph({super.key, required this.graphdata});

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
        x: _dayToIndex(entry.key),
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: Colors.red,
          ),
        ],
      );
    }).toList();
  }

  int _dayToIndex(String day) {
    switch (day) {
      case 'Sunday':
        return 0;
      case 'Monday':
        return 1;
      case 'Tuesday':
        return 2;
      case 'Wednesday':
        return 3;
      case 'Thursday':
        return 4;
      case 'Friday':
        return 5;
      case 'Saturday':
        return 6;
      default:
        return 0;
    }
  }

  SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      getTitlesWidget: (value, metadata) {
        String text = '';
        switch (value.toInt()) {
          case 0:
            text = 'Sun';
            break;
          case 1:
            text = 'Mon';
            break;
          case 2:
            text = 'Tue';
            break;
          case 3:
            text = 'Wed';
            break;
          case 4:
            text = 'Thu';
            break;
          case 5:
            text = 'Fri';
            break;
          case 6:
            text = 'Sat';
            break;
        }
        return Text(
          text,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
        );
      });
}
