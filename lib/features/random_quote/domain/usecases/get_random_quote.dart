import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/features/random_quote/domain/entities/quote.dart';
// ignore_for_file: prefer_const_constructors
import '../../../../core/error/failures.dart';
import '../repositories/quote_repository.dart';
import 'dart:async';
class GetRandomQuote implements UseCase<Quote,NoParams> {
  final QuoteRepository quoteRepository;
  GetRandomQuote({required this.quoteRepository});
  @override
  Future<Either<Failure, Quote>> call(NoParams params) => quoteRepository.getRandomQuote();
}

