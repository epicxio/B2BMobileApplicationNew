import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YearGraph extends StatelessWidget {
  final Map<dynamic, dynamic> graphdata;
  const YearGraph({super.key, required this.graphdata});

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
        x: _monthToIndex(entry.key),
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: Colors.red,
          ),
        ],
      );
    }).toList();
  }

  int _monthToIndex(String month) {
    switch (month) {
      case 'January':
        return 0;
      case 'February':
        return 1;
      case 'March':
        return 2;
      case 'April':
        return 3;
      case 'May':
        return 4;
      case 'June':
        return 5;
      case 'July':
        return 6;
      case 'August':
        return 7;
      case 'September':
        return 8;
      case 'October':
        return 9;
      case 'November':
        return 10;
      case 'December':
        return 11;
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
            text = 'Jan';
            break;
          case 1:
            text = 'Feb';
            break;
          case 2:
            text = 'Mar';
            break;
          case 3:
            text = 'Apr';
            break;
          case 4:
            text = 'May';
            break;
          case 5:
            text = 'Jun';
            break;
          case 6:
            text = 'Jul';
            break;
          case 7:
            text = 'Aug';
            break;
          case 8:
            text = 'Sep';
            break;
          case 9:
            text = 'Oct';
            break;
          case 10:
            text = 'Nov';
            break;
          case 11:
            text = 'Dec';
            break;
        }
        return Text(
          text,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
        );
      });
}
