import 'package:flutter/material.dart';
import 'package:frontend/util/reommendation_api.dart';
import 'package:frontend/util/constants.dart';

import '../atom/loading.dart';

class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.horizontalPadding,
        vertical: Constants.verticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '실시간 인기 검색어',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          FutureBuilder(
            future: RecommendationApi.getRanking(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic> rankList = snapshot.data!;
                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: (1 / .15),
                  children: rankList.map((item) {
                    final int index = rankList.indexOf(item) + 1;
                    final String itemName = item['keyword'] ?? '';
                    return Row(
                      children: [
                        SizedBox(
                          width: 22,
                          child: Text(
                            '$index',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            // context.push('/detail', extra: 1);
                          },
                          child: SizedBox(
                            width: 120,
                            child: Text(
                              itemName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              }
              if (snapshot.hasError) {
                print(snapshot.toString());
                return Text('${snapshot.error}');
              }
              return Loading();
            },
          ),
        ],
      ),
    );
  }
}
