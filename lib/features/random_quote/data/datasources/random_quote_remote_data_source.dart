import 'dart:convert';
import 'dart:async';
import 'package:quotes/core/api/end_points.dart';
import 'package:quotes/features/random_quote/data/models/qoute_model.dart';

import '../../../../core/api/api_consumer.dart';

abstract class RandomQuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource {
  ApiConsumer apiConsumer;

  RandomQuoteRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await apiConsumer.get(
      EndPoints.randomQuote,
    );
    return QuoteModel.fromJson(json.decode(response));
  }
}
