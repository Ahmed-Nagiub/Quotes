import 'package:flutter/material.dart';
import 'package:quotes/config/locale/app_localizations.dart';
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
          child:  Text(
            AppLocalizations.of(context)!.translate('something_went_wrong')!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10,),
         Text(
          AppLocalizations.of(context)!.translate('try_again')!,
          style: const TextStyle(
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
              }, child:  Text(
            AppLocalizations.of(context)!.translate('reload_screen')!,
            style: const TextStyle(
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
