import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TempChartInAll extends StatefulWidget {
  const TempChartInAll({Key? key}) : super(key: key);

  @override
  _TempChartInAllState createState() => _TempChartInAllState();
}

class _TempChartInAllState extends State<TempChartInAll> {
  // 제품 정보 및 기준 정보 정의
  Map<String, dynamic> CombinationDetail = {

    'combinationName': '아이스치즈불닭볶음면',
    'totalPrice' : 5100,
    'totalKcal' : 550,
    'totalCarb':  80.7,
    'totalProtein' : 9,
    'totalFat' : 15.4,
    'totalSodium' : 1090,
    'CombinationItems' : [
      {
        'productId' : 729,
        'productName' : '불닭볶음면',
        'price' : 1800,
        'filename' : 'https://tqklhszfkvzk6518638.cdn.ntruss.com/product/8801073110502.jpg',
        'kcal' : 425,
        'carb':  63,
        'protein' : 9,
        'fat' : 15,
        'sodium' : 950.0,
        'amount' : 1
      },
      {
        'productId' : 1,
        'productName' : '폴라포포도',
        'price' : 1800,
        'filename' : 'https://image.woodongs.com/imgsvr/item/GD_8809713220048_004.jpg',
        'kcal' : 70,
        'carb':  17,
        'protein' : 0,
        'fat' : 0.4,
        'sodium' : 35,
        'amount' : 1
      },
      {
        'productId' : 32,
        'productName' : '인포켓치즈',
        'price' : 1500,
        'filename' : 'https://image.woodongs.com/imgsvr/item/GD_8801155834708.jpg',
        'kcal' : 55,
        'carb':  0.7,
        'protein' : 0,
        'fat' : 0,
        'sodium' : 105,
        'amount' : 1
      },
    ]

  };


  Map<String, dynamic> StandardDetail = {
    'kcal': 2500,
    'carb': 130,
    'protein': 60,
    'fat': 51.0,
    'sodium': 2000.0,
  };

  double kcalRatio = 0.0;
  double proteinRatio = 0.0;
  double fatRatio = 0.0;
  double sodiumRatio = 0.0;
  double carbRatio = 0.0;
  double fullRatio = 1.0;

  List<ChartData> chartData = [];
  List<ChartData> kcalData = [];


  @override
  void initState() {
    super.initState();
    kcalRatio = CombinationDetail['totalKcal'] / StandardDetail['kcal'];
    proteinRatio = CombinationDetail['totalProtein'] / StandardDetail['protein'];
    fatRatio = CombinationDetail['totalFat'] / StandardDetail['fat'];
    sodiumRatio = CombinationDetail['totalSodium'] / StandardDetail['sodium'];
    carbRatio = CombinationDetail['totalCarb'] / StandardDetail['carb'];

    chartData = [
      ChartData('kcal', CombinationDetail['totalKcal'] / StandardDetail['kcal'], Colors.grey),
      ChartData('carb', CombinationDetail['totalCarb'] / StandardDetail['carb'], Colors.red),
      ChartData('protein', CombinationDetail['totalProtein'] / StandardDetail['protein'], Colors.green),
      ChartData('fat', CombinationDetail['totalFat'] / StandardDetail['fat'], Colors.blue),
      ChartData('sodium', CombinationDetail['totalSodium'] / StandardDetail['sodium'], Colors.orange),
    ];

    kcalData = [
      ChartData('kcal', CombinationDetail['totalKcal'] / CombinationDetail['totalKcal'], Colors.red)
    ];


  }

  @override
  Widget build(BuildContext context) {
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
                                  text: '${CombinationDetail['totalKcal']}',
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
                              title: Text('순탄수 : ' + '${(carbRatio*100).toStringAsFixed(0)}%'),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: Colors.green),
                              title: Text('단백질 : ' '${(proteinRatio*100).toStringAsFixed(0)}%'),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: Colors.blue),
                              title: Text('지방 : '+'${(fatRatio*100).toStringAsFixed(0)}%'),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: Colors.orange),
                              title: Text('나트륨 : '+'${(sodiumRatio*100).toStringAsFixed(0)}%'),
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
                          child: carbRatio > 1
                              ? FractionallySizedBox(
                                widthFactor: fullRatio,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.red,
                                ),
                              )
                              : FractionallySizedBox(
                                widthFactor: carbRatio,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.green,
                              ),
                            ),
                         ),
                        SizedBox(height: 10,),
                        Container(
                          height: 20,
                          child: Text('${CombinationDetail['totalCarb']}' + ' / ' + '${StandardDetail['carb']}' + 'g'),
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
                          child: proteinRatio > 1
                              ? FractionallySizedBox(
                                widthFactor: fullRatio,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.red,
                                ),
                              )
                              : FractionallySizedBox(
                                widthFactor: proteinRatio,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 20,
                          child: Text('${CombinationDetail['totalProtein']}' + ' / ' + '${StandardDetail['protein']}' + 'g'),
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
                          child: fatRatio > 1
                              ? FractionallySizedBox(
                                widthFactor: fullRatio,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.red,
                                ),
                              )
                              : FractionallySizedBox(
                                widthFactor: fatRatio,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.green,
                              ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 20,
                          child: Text('${CombinationDetail['totalFat']}' + ' / ' + '${StandardDetail['fat']}' + 'g'),
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
                            StandardDetail['kcal'] > CombinationDetail['totalKcal']
                                ? ' "${StandardDetail['kcal'] - CombinationDetail['totalKcal']}kcal를 더 먹을 수 있어요" '
                                : ' "${StandardDetail['kcal']}kcal 초과했습니다!!" ',
                            style: TextStyle(
                              color: StandardDetail['kcal'] > CombinationDetail['totalKcal']
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
