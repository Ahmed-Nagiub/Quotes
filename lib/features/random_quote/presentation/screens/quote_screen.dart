// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/config/locale/app_localizations_setup.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/random_quote/domain/entities/quote.dart';
import 'package:quotes/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/features/splash/presentation/cubit/locale_cubit.dart';
import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_color.dart';
import '../widgets/quote_content.dart';
import 'package:quotes/core/widget/error_widget.dart' as error_widget;
class QuoteScreen extends StatefulWidget {

  const QuoteScreen({super.key,});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  _getRandomQuote()=>BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();

  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }


  Widget _buildBodyContent() {
    return BlocBuilder<RandomQuoteCubit,RandomQuoteState >(
      builder: (context, state) {
        if(state is RandomQuoteIsLoading){
          return Center(
            child: SpinKitFadingCircle(
              color: AppColor.primary,
            ),
          );
        }else if(state is RandomQuoteError){
          return error_widget.ErrorWidget(
            onPress: ()=>_getRandomQuote(),
          );
        }else if(state is RandomQuoteLoaded){
          return Column(
            children: [
              QuoteContent(quote: state.quote,),
              InkWell(
                onTap: ()=> _getRandomQuote(),
                child: Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColor.primary),
                  child: const Icon(
                    Icons.refresh,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        }else{
          return Center(
            child: SpinKitFadingCircle(
              color: AppColor.primary,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(onPressed: (){
        if(AppLocalizations.of(context)!.isEnLocale){
          BlocProvider.of<LocaleCubit>(context).toArabic();
        }else{
          BlocProvider.of<LocaleCubit>(context).toEnglish();
        }
      }, icon: Icon(Icons.translate_outlined,color: AppColor.primary,)),
      title: Text(AppLocalizations.of(context)!.translate('app_name')!),
    );
    return RefreshIndicator(
        onRefresh: ()=>_getRandomQuote(),
        child: Scaffold(appBar: appBar, body: _buildBodyContent()));
  }
}
