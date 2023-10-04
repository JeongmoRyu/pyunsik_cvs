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

    Color kcalColor = Color.fromRGBO(253, 104, 105, 1.0);
    Color carbColor = Color.fromRGBO(29, 92, 155, 1.0);
    Color proteinColor = Color.fromRGBO(116, 192, 245, 1.0);
    Color fatColor = Color.fromRGBO(242, 207, 96, 1.0);
    Color sodiumColor = Color.fromRGBO(249, 236, 172, 1.0);

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
      // ChartData('kcal', CartTotal['totalKcal'] / StandardDetail['kcal'], kcalColor),
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
                                trackColor: Color.fromRGBO(253, 253, 253, 1.0),
                                dataSource: chartData,
                                pointColorMapper:(ChartData data, _) => data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
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
                      height: 250,
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
                            ListTile(
                              leading: Icon(Icons.circle, color: carbColor),
                              title: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: '탄수화물 ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold, // Make this part bold
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${widget.totalCarb}g',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Text('${(totalcarbRatio*100).toStringAsFixed(0)}%'),
                                ],
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: proteinColor),
                              title: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: '단백질 ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold, // Make this part bold
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${widget.totalProtein}g',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Text('${(totalproteinRatio*100).toStringAsFixed(0)}%')
                                ],
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: fatColor),
                              title: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: '지방 ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold, // Make this part bold
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${widget.totalFat}g',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Text('${(totalfatRatio*100).toStringAsFixed(0)}%'),
                                ],
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: sodiumColor),
                              title: SingleChildScrollView(
                                child: Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: '나트륨 ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold, // Make this part bold
                                            ),
                                          ),
                                          TextSpan(
                                            text: '${widget.totalSodium}mg',
                                            style: TextStyle(
                                              fontSize: 13
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Text('${(totalsodiumRatio*100).toStringAsFixed(0)}%',
                                      overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
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
            Container(
              height: 100,
              child: Center(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
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
