import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/colorConstants/appColors.dart';
import '../../constants/textConstants/appTextConstants.dart';

class MainCard extends StatefulWidget {
  const MainCard({Key? key, required this.date}) : super(key: key);
  final String date;

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(10.0),
      child:Container(
        height: 140,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: AppColors.mainScreenCardColor,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:[
                Align(
                    alignment: Alignment.centerRight,
                    child:Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          width: 160,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.mainScreenCardTimeCard
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.watch_later_outlined, color: AppColors.mainScreenCardTimeIcon,),
                               Text(widget.date.toString(), style: const TextStyle(fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),)
                            ],
                          ),
                        )
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(AppTextConstant.textDeclaration1,style: TextStyle(fontSize: 17, color: AppColors.mainScreenCardText, fontWeight: FontWeight.w400),)
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 10, top: 2),
                    child: Text(AppTextConstant.textDeclaration2,style: TextStyle(fontSize: 17, color: AppColors.mainScreenCardText, fontWeight: FontWeight.w400),)
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 10, top: 2),
                    child: Text(AppTextConstant.textDeclaration3,style: TextStyle(fontSize: 17, color: AppColors.mainScreenCardText, fontWeight: FontWeight.w400),)
                ),
              ],
            ),
            Positioned(
                left: 5,
                bottom: 0,
                child: Icon(CupertinoIcons.doc_append, size: 120,color: AppColors.mainScreenCardIcon,))
          ],
        ),
      ),);
  }
}
