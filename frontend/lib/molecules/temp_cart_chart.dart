import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:frontend/models/cart.dart';
import 'package:provider/provider.dart';

class TempCartChart extends StatefulWidget {

  const TempCartChart({Key? key}) : super(key: key);

  @override
  _TempCartChartState createState() => _TempCartChartState();
}

class _TempCartChartState extends State<TempCartChart> {
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
  List<ChartData> kcalData = [];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    CartTotal = {
      'totalKcal': cart.getTotalKcal(),
      'totalProtein': cart.getTotalProtein(),
      'totalFat': cart.getTotalFat(),
      'totalCarb': cart.getTotalCarb(),
      'totalSodium': cart.getTotalSodium(),
    };


    totalkcalRatio = CartTotal['totalKcal'] / StandardDetail['kcal'];
    totalproteinRatio = CartTotal['totalProtein'] / StandardDetail['protein'];
    totalfatRatio = CartTotal['totalFat'] / StandardDetail['fat'];
    totalsodiumRatio = CartTotal['totalSodium'] / StandardDetail['sodium'];
    totalcarbRatio = CartTotal['totalCarb'] / StandardDetail['carb'];

    chartData = [
      ChartData('kcal', CartTotal['totalKcal'] / StandardDetail['kcal'], Colors.grey),
      ChartData('carb', CartTotal['totalCarb'] / StandardDetail['carb'], Colors.red),
      ChartData('protein', CartTotal['totalProtein'] / StandardDetail['protein'], Colors.green),
      ChartData('fat', CartTotal['totalFat'] / StandardDetail['fat'], Colors.blue),
      ChartData('sodium', CartTotal['totalSodium'] / StandardDetail['sodium'], Colors.orange),
    ];

    kcalData = [
      ChartData('kcal', CartTotal['totalKcal'] / CartTotal['totalKcal'], Colors.red)
    ];



    return Container(
      height: 480,
      child: Scaffold(
        body: Column(
          children: [
            // 차트 표시 부분
            Container(
              color: Colors.grey[200],
              child: Row(
                children: [
                  // RadialBar 차트
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 250,
                      color: Colors.grey[200],

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
                                    color: Colors.black, // 흰색 텍스트 색상
                                  ),
                                ),
                                TextSpan(
                                  text: 'kcal',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black, // 검정색 텍스트 색상
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
                      color: Colors.grey[200],
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(
                              leading: Icon(Icons.circle, color: Colors.red),
                              title: Text('순탄수 : ' + '${(totalcarbRatio*100).toStringAsFixed(0)}%'),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: Colors.green),
                              title: Text('단백질 : ' '${(totalproteinRatio*100).toStringAsFixed(0)}%'),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: Colors.blue),
                              title: Text('지방 : '+'${(totalfatRatio*100).toStringAsFixed(0)}%'),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: Colors.orange),
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
              color: Colors.grey[200],
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
                          color: Colors.grey,
                          child: totalcarbRatio > 1
                              ? FractionallySizedBox(
                            widthFactor: totalfullRatio,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: Colors.red,
                            ),
                          )
                              : FractionallySizedBox(
                            widthFactor: totalcarbRatio,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: Colors.green,
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
                          color: Colors.grey,
                          child: totalproteinRatio > 1
                              ? FractionallySizedBox(
                            widthFactor: totalfullRatio,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: Colors.red,
                            ),
                          )
                              : FractionallySizedBox(
                            widthFactor: totalproteinRatio,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: Colors.green,
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
                          color: Colors.grey,
                          child: totalfatRatio > 1
                              ? FractionallySizedBox(
                            widthFactor: totalfullRatio,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: Colors.red,
                            ),
                          )
                              : FractionallySizedBox(
                            widthFactor: totalfatRatio,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: Colors.green,
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
              color: Colors.grey[200],
              child: Center(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.grey,
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
