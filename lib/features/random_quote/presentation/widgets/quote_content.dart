import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_color.dart';

import '../../domain/entities/quote.dart';

class QuoteContent extends StatelessWidget {
  final Quote quote;
  const QuoteContent({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        quote.content,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 22
        ),
      ),
    );
  }
}
