
import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/random_quote/domain/entities/quote.dart';
import 'package:quotes/features/random_quote/domain/repositories/quote_repository.dart';
import '../datasources/random_quote_local_data_source.dart';
import '../datasources/random_quote_remote_data_source.dart';

class QuoteRepositoryImpl extends QuoteRepository {
  final NetworkInfo networkInfo;
  final RandomQuoteLocalDataSource randomQuoteLocalDataSource;
  final RandomQuoteRemoteDataSource randomQuoteRemoteDataSource;
  QuoteRepositoryImpl({
    required this.networkInfo,
    required this.randomQuoteRemoteDataSource,
    required this.randomQuoteLocalDataSource});

  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
  if(await networkInfo.isConnected){
    try{
      final randomQuoteRemote = await randomQuoteRemoteDataSource.getRandomQuote();
      randomQuoteLocalDataSource.cacheQuote(randomQuoteRemote);
      return Right(randomQuoteRemote);
    }on ServerException{
      return left(ServerFailure());
    }
  }else{
    try{
     final randomQuoteLocal = await randomQuoteLocalDataSource.getLastRandomQuote();
     return Right(randomQuoteLocal);
   }on CacheException{
     return left(CacheFailure());
   }
   }
  }
}