import 'package:flutter/material.dart';
import 'package:frontend/atom/button/alarm_button.dart';

class TopBarMain extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  TopBarMain({required this.appBar});

  @override
  Widget build(BuildContext context) {
   return AppBar(
     actions: <Widget>[
       SizedBox(
         width: 250,

         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: TextField(
             decoration: InputDecoration(
                 filled: true,
                 fillColor: Colors.grey,
                 prefixIcon: Icon(Icons.search,),
                 border: InputBorder.none
             ),
           ),
         ),
       ),
       Spacer(),
       AlarmButton(),
       IconButton(
           onPressed: () {},
           icon: Icon(Icons.bookmark_outline)
       ),
       IconButton(
           onPressed: () {},
           icon: Icon(Icons.interests_outlined)
       )
     ],
   );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

}
