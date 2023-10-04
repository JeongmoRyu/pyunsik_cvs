import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:frontend/models/cart.dart';
import 'package:provider/provider.dart';

class CombinationChart extends StatefulWidget {
  final int totalKcal;
  final double totalProtein;
  final double totalFat;
  final double totalCarb;
  final double totalSodium;

  const CombinationChart({super.key,
    required this.totalKcal,
    required this.totalProtein,
    required this.totalFat,
    required this.totalCarb,
    required this.totalSodium
  });

  @override
  State<CombinationChart> createState() => _CombinationChartState();
}

class _CombinationChartState extends State<CombinationChart> {
  // 제품 정보 및 기준 정보 정의
  Map<String, dynamic> CartTotal = {};

  Map<String, dynamic> StandardDetail = {
    'kcal': 2500,
    'carb': 130,
    'protein': 60,
    'fat': 51.0,
    'sodium': 2000.0,
  };

  double totalkcalRatio = 0.0;
  double totalproteinRatio = 0.0;
  double totalfatRatio = 0.0;
  double totalsodiumRatio = 0.0;
  double totalcarbRatio = 0.0;
  double totalfullRatio = 1.0;

  List<ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    // Color kcalColor = Color.fromRGBO(238, 123, 46, 1.0);
    // Color proteinColor = Color.fromRGBO(101, 171, 246, 1.0);
    // Color fatColor = Color.fromRGBO(138, 120, 203, 1.0);
    // Color carbColor = Color.fromRGBO(51, 86, 183, 1.0);
    // Color sodiumColor = Color.fromRGBO(82, 38, 147, 1.0);

    Color kcalColor = Color.fromRGBO(238, 123, 46, 1.0);
    Color proteinColor = Color.fromRGBO(101, 171, 246, 1.0);
    Color fatColor = Color.fromRGBO(138, 120, 203, 1.0);
    Color carbColor = Color.fromRGBO(51, 86, 183, 1.0);
    Color sodiumColor = Color.fromRGBO(82, 38, 147, 1.0);

    Color barBackgroundColor = Color.fromRGBO(236, 236, 236, 1.0);
    Color barGoodColor = Theme.of(context).primaryColor;
    Color barBadColor = Color.fromRGBO(255, 60, 60, 1.0);

    CartTotal = {
      'totalKcal': widget.totalKcal,
      'totalProtein': widget.totalProtein,
      'totalFat': widget.totalFat,
      'totalCarb': widget.totalCarb,
      'totalSodium': widget.totalSodium,
    };


    totalkcalRatio = CartTotal['totalKcal'] / StandardDetail['kcal'];
    totalproteinRatio = CartTotal['totalProtein'] / StandardDetail['protein'];
    totalfatRatio = CartTotal['totalFat'] / StandardDetail['fat'];
    totalsodiumRatio = CartTotal['totalSodium'] / StandardDetail['sodium'];
    totalcarbRatio = CartTotal['totalCarb'] / StandardDetail['carb'];

    chartData = [
      ChartData('kcal', CartTotal['totalKcal'] / StandardDetail['kcal'], kcalColor),
      ChartData('carb', CartTotal['totalCarb'] / StandardDetail['carb'], carbColor),
      ChartData('protein', CartTotal['totalProtein'] / StandardDetail['protein'], proteinColor),
      ChartData('fat', CartTotal['totalFat'] / StandardDetail['fat'], fatColor),
      ChartData('sodium', CartTotal['totalSodium'] / StandardDetail['sodium'], sodiumColor),
    ];

    return Container(
      height: 480,
      child: Scaffold(
        body: Column(
          children: [
            // 차트 표시 부분
            Container(
              child: Row(
                children: [
                  // RadialBar 차트
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 250,

                      child: Stack(
                        alignment: Alignment.center, // 텍스트를 중앙에 배치
                        children: [
                          Container(
                            child: SfCircularChart(
                              series: <CircularSeries>[
                                RadialBarSeries<ChartData, String>(
                                  trackColor: Colors.white,
                                  dataSource: chartData,
                                  pointColorMapper:(ChartData data, _) => data.color,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${CartTotal['totalKcal']}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'kcal',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 비율 정보 표시
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 250,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(
                              leading: Icon(Icons.circle, color: carbColor),
                              title: Text('순탄수 : ' + '${(totalcarbRatio*100).toStringAsFixed(0)}%'),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: proteinColor),
                              title: Text('단백질 : ' '${(totalproteinRatio*100).toStringAsFixed(0)}%'),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: fatColor),
                              title: Text('지방 : '+'${(totalfatRatio*100).toStringAsFixed(0)}%'),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: sodiumColor),
                              title: Text('나트륨 : '+'${(totalsodiumRatio*100).toStringAsFixed(0)}%'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 기타 정보 표시 부분
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // 순탄수 정보
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Container(
                          height: 20,
                          child: Text('순탄수'),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          height: 10,
                          width: 90,
                          color: barBackgroundColor,
                          child: totalcarbRatio > 1
                              ? FractionallySizedBox(
                            widthFactor: totalfullRatio,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: barBadColor,
                            ),
                          )
                              : FractionallySizedBox(
                            widthFactor: totalcarbRatio,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: barGoodColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 20,
                          child: Text('${CartTotal['totalCarb']}' + ' / ' + '${StandardDetail['carb']}' + 'g'),
                        ),
                      ],
                    ),
                  ),
                  // 단백질 정보
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Container(
                          height: 20,
                          child: Text('단백질'),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          height: 10,
                          width: 90,
                          color: barBackgroundColor,
                          child: totalproteinRatio > 1
                              ? FractionallySizedBox(
                            widthFactor: totalfullRatio,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: barBadColor,
                            ),
                          )
                              : FractionallySizedBox(
                            widthFactor: totalproteinRatio,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: barGoodColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 20,
                          child: Text('${CartTotal['totalProtein']}' + ' / ' + '${StandardDetail['protein']}' + 'g'),
                        ),
                      ],
                    ),
                  ),
                  // 지방 정보
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Container(
                          height: 20,
                          child: Text('지방'),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          height: 10,
                          width: 90,
                          color: barBackgroundColor,
                          child: totalfatRatio > 1
                              ? FractionallySizedBox(
                            widthFactor: totalfullRatio,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: barBadColor,
                            ),
                          )
                              : FractionallySizedBox(
                            widthFactor: totalfatRatio,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: barGoodColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 20,
                          child: Text('${CartTotal['totalFat']}' + ' / ' + '${StandardDetail['fat']}' + 'g'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 칼로리 정보 표시 부분
            Container(
              height: 155,
              child: Center(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(88, 113, 215, 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        child: Center(
                          child: Text(
                            StandardDetail['kcal'] > CartTotal['totalKcal']
                                ? ' "${StandardDetail['kcal'] - CartTotal['totalKcal']}kcal를 더 먹을 수 있어요" '
                                : ' "${StandardDetail['kcal']}kcal 초과했습니다!!" ',
                            style: TextStyle(
                              color: StandardDetail['kcal'] > CartTotal['totalKcal']
                                  ? Colors.white
                                  : Colors.red,
                              fontSize: 20,
                            ),
                          )
                          ,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
