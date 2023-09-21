import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:frontend/models/productdetail.dart';

class TempChart extends StatefulWidget {
  final ProductDetail productDetail; // ProductDetail 객체로 변경

  const TempChart({Key? key, required this.productDetail}) : super(key: key);

  @override
  _TempChartState createState() => _TempChartState();
}

class _TempChartState extends State<TempChart> {
  late ProductDetail productDetail; // ProductDetail 객체로 변경

  Map<String, dynamic> StandardDetail = {
    'kcal': 2500,
    'carb': 130,
    'protein': 60,
    'fat': 51.0,
    'sodium': 2000.0,
  };

  // 비율 계산 변수 정의
  double kcalRatio = 0.0;
  double proteinRatio = 0.0;
  double fatRatio = 0.0;
  double sodiumRatio = 0.0;
  double carbRatio = 0.0;
  double proteinbarRatio = 0.0;
  double fatbarRatio = 0.0;
  double sodiumbarRatio = 0.0;
  double carbbarRatio = 0.0;
  double fullRatio = 1.0;

  // 차트 데이터 정의
  List<ChartData> chartData = [];
  List<ChartData> kcalData = [];

  @override
  void initState() {
    super.initState();
    productDetail = widget.productDetail;

    // 비율 계산
    proteinRatio = (productDetail.protein*4) / productDetail.kcal;
    fatRatio = (productDetail.fat*9) / productDetail.kcal;
    carbRatio = (productDetail.carb*4) / productDetail.kcal;

    proteinbarRatio = productDetail.protein / StandardDetail['protein'];
    fatbarRatio = productDetail.fat / StandardDetail['fat'];
    carbbarRatio = productDetail.carb / StandardDetail['carb'];


    chartData = [
      ChartData('carb', (productDetail.carb*4) / StandardDetail['kcal'], Colors.grey),
      ChartData('protein', (productDetail.protein*4) / StandardDetail['kcal'], Colors.black),
      ChartData('fat', (productDetail.fat*9) / StandardDetail['kcal'], Colors.blueGrey),
    ];

    kcalData = [
      ChartData('kcal', productDetail.kcal / StandardDetail['kcal'], Colors.red)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      child: Column(
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
                            height: 250,
                            color: Colors.grey[200],
                            child: SfCircularChart(
                              series: <CircularSeries>[
                                DoughnutSeries<ChartData, String>(
                                  // gap: '5%',
                                  dataSource: chartData,
                                  pointColorMapper: (ChartData data, _) => data.color,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                  radius: '90%',
                                  innerRadius: '85%',
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${productDetail.kcal}',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(45, 45, 45, 1.0), // 흰색 텍스트 색상
                                  ),
                                ),
                                TextSpan(
                                  text: 'kcal',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(45, 45, 45, 1.0), // 검정색 텍스트 색상
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
                              leading: Icon(Icons.circle, color: Colors.grey),
                              title: Text('순탄수 : ' + '${(carbRatio*100).toStringAsFixed(0)}%'),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: Colors.black),
                              title: Text('단백질 : ' '${(proteinRatio*100).toStringAsFixed(0)}%'),
                            ),
                            ListTile(
                              leading: Icon(Icons.circle, color: Colors.blueGrey),
                              title: Text('지방 : '+'${(fatRatio*100).toStringAsFixed(0)}%'),
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
                          child: carbbarRatio > 1
                              ? FractionallySizedBox(
                                widthFactor: fullRatio,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.red,
                                ),
                              )
                              : FractionallySizedBox(
                                widthFactor: carbbarRatio,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.green,
                                ),
                              ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 20,
                          child: Text('${productDetail.carb}' + ' / ' + '${StandardDetail['carb']}' + 'g'),
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
                          child: proteinbarRatio > 1
                              ? FractionallySizedBox(
                                widthFactor: fullRatio,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.red,
                                ),
                              )
                              : FractionallySizedBox(
                                widthFactor: proteinbarRatio,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.green,
                                ),
                              ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 20,
                          child: Text('${productDetail.protein}' + ' / ' + '${StandardDetail['protein']}' + 'g'),
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
                          child: fatbarRatio > 1
                              ? FractionallySizedBox(
                                widthFactor: fatbarRatio,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.red,
                                ),
                              )
                              : FractionallySizedBox(
                                widthFactor: fatbarRatio,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.green,
                                ),
                              ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 20,
                          child: Text('${productDetail.fat}' + ' / ' + '${StandardDetail['fat']}' + 'g'),
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
                            ' "${StandardDetail['kcal'] - productDetail.kcal}kcal를 더 먹을 수 있어요" ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
