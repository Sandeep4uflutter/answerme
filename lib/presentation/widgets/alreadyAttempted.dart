import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projects/constants/colorConstants/appColors.dart';
import 'package:projects/constants/textConstants/appTextConstants.dart';
import 'package:projects/presentation/screens/responsesScreen.dart';

class AlreadyAttempted extends StatefulWidget {
  const AlreadyAttempted({Key? key, required this.isOld, required this.responses}) : super(key: key);
  final bool isOld;
  final List responses;

  @override
  State<AlreadyAttempted> createState() => _AlreadyAttemptedState();
}

class _AlreadyAttemptedState extends State<AlreadyAttempted> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.checkmark_alt_circle_fill,
              size: 100.sp,
              color: AppColors.alreadyAttemptedIcon,
            ),
            const SizedBox(height: 10),
            Text(
              widget.isOld==true?AppTextConstant.alreadyAttemptedText:AppTextConstant.successfullyAttemptedText,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.alreadyAttemptedText),
            ),
            const SizedBox(height: 10),
            // ignore: deprecated_member_use
            RaisedButton(
              elevation: 0,
              color: AppColors.alreadyAttemptedButton,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Text(AppTextConstant.alreadyAttemptedButtonText,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, color: AppColors.alreadyAttemptedButtonText),),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ResponsesScreen(response: widget.responses)));
              },
            )
          ],
        ),
      ),
    );
  }
}
