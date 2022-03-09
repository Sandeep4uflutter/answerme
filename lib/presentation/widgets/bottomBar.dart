// ignore_for_file: file_names
import 'package:flutter/material.dart';

import '../../constants/colorConstants/appColors.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(height: 60,
      width: MediaQuery.of(context).size.width,
      color: AppColors.bottomBarColor,
      child: Row(
        children: [
          IconButton(onPressed: (){},
          icon: Icon(Icons.menu, size: 32,
          color: AppColors.menuButtonColor,),)
        ],
      ),
    );
  }
}
