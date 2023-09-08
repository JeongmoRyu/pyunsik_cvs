import 'package:flutter/material.dart';
import 'package:frontend/atom/product_card.dart';

class ScrollEffect extends StatelessWidget {
  const ScrollEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverAppBar(
        //   title: Text('Sliver appbar'),
        //   backgroundColor: Colors.brown[500],
        //   expandedHeight: 200,
        //   leading: Icon(Icons.arrow_back),
        //   actions: [
        //     Icon(Icons.settings),
        //     SizedBox(
        //       width: 12,
        //     ),
        //   ],
        //   flexibleSpace: FlexibleSpaceBar(
        //     background: CircleAvatar(
        //       backgroundImage: AssetImage(
        //           'assets/images/cvs.jpg'
        //       ),
        //       radius: 10.0,
        //     ),
        //     // background: Image.asset(
        //     //     'assets/ball.png',
        //     //     fit: BoxFit.contain,
        //     //     ),
        //   ),
        // ),
        SliverToBoxAdapter(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 20,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return ImageWidget(index: index,);
              }),
        )
      ],
    );
  }
}
