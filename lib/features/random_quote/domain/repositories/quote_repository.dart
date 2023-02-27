import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/quote.dart';
import 'dart:async';
abstract class QuoteRepository {
  Future<Either<Failure, Quote>> getRandomQuote();
}