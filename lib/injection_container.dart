import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/random_quote/data/datasources/random_quote_local_data_source.dart';
import 'package:quotes/features/random_quote/data/datasources/random_quote_remote_data_source.dart';
import 'package:quotes/features/random_quote/data/repositories/quote_repository_impl.dart';
import 'package:quotes/features/random_quote/domain/repositories/quote_repository.dart';
import 'package:quotes/features/random_quote/domain/usecases/get_random_quote.dart';
import 'package:quotes/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
final sl = GetIt.instance;

void init() async {
  //! Features
  // Bloc
  sl.registerFactory(() => RandomQuoteCubit(getRandomQuoteUseCase: sl()));

  // use cases
  sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl()));

  // Repository
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
  networkInfo: sl(),
  randomQuoteRemoteDataSource: sl(),
  randomQuoteLocalDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<RandomQuoteRemoteDataSource>(() => RandomQuoteRemoteDataSourceImpl(clint: sl()));
  sl.registerLazySingleton<RandomQuoteLocalDataSource>(() => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));

  //! core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}