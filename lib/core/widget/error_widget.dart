import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_color.dart';
import 'package:quotes/core/utils/media_query_values.dart';

class ErrorWidget extends StatelessWidget {
  final VoidCallback? onPress;
  const ErrorWidget({Key? key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(Icons.warning_amber_rounded,
          color: AppColor.primary,
          size: 150,
          ),
        ),
        Container(
          child: const Text(
            'Something Went Wrong',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10,),
        const Text(
          'Please Try Again',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.w500
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          height: 55,
          width: context.width * 0.55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColor.primary,
              onPrimary: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              )
            ),
              onPressed: (){
              if(onPress != null){
                onPress!();
              }
              }, child: const Text(
            'Reload Screen',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700
            ),
          )),
        )
      ],
    );
  }
}
