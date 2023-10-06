import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    // Color backgroundColor = Colors.white;
    // Color kcalColor = Color.fromRGBO(238, 123, 46, 1.0);
    // Color proteinColor = Color.fromRGBO(101, 171, 246, 1.0);
    // Color fatColor = Color.fromRGBO(138, 120, 203, 1.0);
    // Color carbColor = Color.fromRGBO(51, 86, 183, 1.0);
    // Color sodiumColor = Color.fromRGBO(82, 38, 147, 1.0);

    // Color kcalColor = Color.fromRGBO(253, 104, 105, 1.0);
    Color carbColor = Color.fromRGBO(29, 92, 155, 1.0);
    Color proteinColor = Color.fromRGBO(116, 192, 245, 1.0);
    Color fatColor = Color.fromRGBO(242, 207, 96, 1.0);
    Color sodiumColor = Color.fromRGBO(249, 236, 172, 1.0);

    // Color barBackgroundColor = Color.fromRGBO(236, 236, 236, 1.0);
    // Color barGoodColor = Theme.of(context).primaryColor;
    // Color barBadColor = Color.fromRGBO(255, 60, 60, 1.0);

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
      // ChartData('kcal', CartTotal['totalKcal'] / StandardDetail['kcal'], kcalColor),
      // ChartData('100', 1, Color.fromRGBO(252, 249, 254, 1.0),),
      ChartData('sodium', CartTotal['totalSodium'] / StandardDetail['sodium'], sodiumColor),
      ChartData('fat', CartTotal['totalFat'] / StandardDetail['fat'], fatColor),
      ChartData('protein', CartTotal['totalProtein'] / StandardDetail['protein'], proteinColor),
      ChartData('carb', CartTotal['totalCarb'] / StandardDetail['carb'], carbColor),
    ];

    return Container(
      height: 350,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 15,),
            // 차트 표시 부분
            Container(
              child: Row(
                children: [
                  // RadialBar 차트
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      height: 250,
                      child: Stack(
                        alignment: Alignment.center, // 텍스트를 중앙에 배치
                        children: [
                          SfCircularChart(
                            series: <CircularSeries>[
                              RadialBarSeries<ChartData, String>(
                                radius: '100%',
                                  maximumValue: 1,
                                trackColor: Color.fromRGBO(246, 246, 246, 1.0),
                                dataSource: chartData,
                                pointColorMapper:(ChartData data, _) => data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                cornerStyle: CornerStyle.bothCurve
                              ),
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${CartTotal['totalKcal']}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(26, 26, 26, 1.0),
                                  ),
                                ),
                                TextSpan(
                                  text: 'kcal',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
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
                    child: SizedBox(
                      height: 300,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('1일영양성분', style: TextStyle(
                              fontSize: 12
                            )),
                            Text('기준치에 대한 비율', style: TextStyle(
                                fontSize: 12
                            )),
                            buildListTile(carbColor, '탄수화물',
                                '${widget.totalCarb.toStringAsFixed(2)}g', totalcarbRatio),
                            buildListTile(proteinColor, '단백질',
                                '${widget.totalProtein.toStringAsFixed(2)}g', totalproteinRatio),
                            buildListTile(fatColor, '지방',
                                '${widget.totalFat.toStringAsFixed(2)}g', totalfatRatio),
                            buildListTile(sodiumColor, '나트륨',
                                '${widget.totalSodium.toStringAsFixed(0)}mg', totalsodiumRatio),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 기타 정보 표시 부분
            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       // 탄수화물 정보
            //       Expanded(
            //         flex: 4,
            //         child: Column(
            //           children: [
            //             Container(
            //               height: 20,
            //               child: Text('탄수화물'),
            //             ),
            //             SizedBox(height: 15,),
            //             Container(
            //               height: 10,
            //               width: 90,
            //               color: barBackgroundColor,
            //               child: totalcarbRatio > 1
            //                   ? FractionallySizedBox(
            //                 widthFactor: totalfullRatio,
            //                 alignment: Alignment.centerLeft,
            //                 child: Container(
            //                   color: barBadColor,
            //                 ),
            //               )
            //                   : FractionallySizedBox(
            //                 widthFactor: totalcarbRatio,
            //                 alignment: Alignment.centerLeft,
            //                 child: Container(
            //                   color: barGoodColor,
            //                 ),
            //               ),
            //             ),
            //             SizedBox(height: 10,),
            //             Container(
            //               height: 20,
            //               child: Text('${CartTotal['totalCarb']}' + ' / ' + '${StandardDetail['carb']}' + 'g'),
            //             ),
            //           ],
            //         ),
            //       ),
            //       // 단백질 정보
            //       Expanded(
            //         flex: 4,
            //         child: Column(
            //           children: [
            //             Container(
            //               height: 20,
            //               child: Text('단백질'),
            //             ),
            //             SizedBox(height: 15,),
            //             Container(
            //               height: 10,
            //               width: 90,
            //               color: barBackgroundColor,
            //               child: totalproteinRatio > 1
            //                   ? FractionallySizedBox(
            //                 widthFactor: totalfullRatio,
            //                 alignment: Alignment.centerLeft,
            //                 child: Container(
            //                   color: barBadColor,
            //                 ),
            //               )
            //                   : FractionallySizedBox(
            //                 widthFactor: totalproteinRatio,
            //                 alignment: Alignment.centerLeft,
            //                 child: Container(
            //                   color: barGoodColor,
            //                 ),
            //               ),
            //             ),
            //             SizedBox(height: 10,),
            //             Container(
            //               height: 20,
            //               child: Text('${CartTotal['totalProtein']}' + ' / ' + '${StandardDetail['protein']}' + 'g'),
            //             ),
            //           ],
            //         ),
            //       ),
            //       // 지방 정보
            //       Expanded(
            //         flex: 4,
            //         child: Column(
            //           children: [
            //             Container(
            //               height: 20,
            //               child: Text('지방'),
            //             ),
            //             SizedBox(height: 15,),
            //             Container(
            //               height: 10,
            //               width: 90,
            //               color: barBackgroundColor,
            //               child: totalfatRatio > 1
            //                   ? FractionallySizedBox(
            //                 widthFactor: totalfullRatio,
            //                 alignment: Alignment.centerLeft,
            //                 child: Container(
            //                   color: barBadColor,
            //                 ),
            //               )
            //                   : FractionallySizedBox(
            //                 widthFactor: totalfatRatio,
            //                 alignment: Alignment.centerLeft,
            //                 child: Container(
            //                   color: barGoodColor,
            //                 ),
            //               ),
            //             ),
            //             SizedBox(height: 10,),
            //             Container(
            //               height: 20,
            //               child: Text('${CartTotal['totalFat']}' + ' / ' + '${StandardDetail['fat']}' + 'g'),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // 칼로리 정보 표시 부분
            // Container(
            //   height: 100,
            //   child: Center(
            //     child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           height: 60,
            //           width: MediaQuery.of(context).size.width * 0.6,
            //           decoration: BoxDecoration(
            //             color: Color.fromRGBO(90, 104, 185, 1.0),
            //             borderRadius: BorderRadius.circular(10.0),
            //           ),
            //           child: Container(
            //             child: Center(
            //               child: Text(
            //                 StandardDetail['kcal'] > CartTotal['totalKcal']
            //                     ? ' "${StandardDetail['kcal'] - CartTotal['totalKcal']}kcal를 더 먹을 수 있어요" '
            //                     : ' "${StandardDetail['kcal']}kcal 초과했습니다!!" ',
            //                 style: TextStyle(
            //                   color: StandardDetail['kcal'] > CartTotal['totalKcal']
            //                       ? Colors.white
            //                       : Colors.red,
            //                   fontSize: 20,
            //                 ),
            //               )
            //               ,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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

Widget buildListTile(Color color, String title, String weight, double ratio) {
  return ListTile(
    leading: Icon(Icons.circle, color: color),
    title: Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            Text(weight, style: TextStyle(
              fontSize: 13
            ),)
          ],
        ),
        Spacer(),
        Text('${(ratio*100).toStringAsFixed(0)}%'),
      ],
    ),
  );
}