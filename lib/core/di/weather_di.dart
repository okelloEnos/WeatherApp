
import 'package:britam/core/domain/use_case/fetch_holdings_usecase.dart';
import 'package:britam/core/domain/use_case/fetch_personal_details_usecase.dart';
import 'package:britam/features/auto_debit/domain/usecases/add_auto_debit_usecase.dart';
import 'package:get_it/get_it.dart';

import '../../features/auto_debit/data/datasources/auto_debit_remote_data_source.dart';
import '../../features/auto_debit/data/repository/auto_debit_repository.dart';
import '../../features/auto_debit/domain/repository/auto_debit_repository.dart';
import '../../features/auto_debit/domain/usecases/cancel_auto_debit_usecase.dart';
import '../../features/auto_debit/domain/usecases/fetch_auto_debit_usecase.dart';
import '../../features/auto_debit/presentation/bloc/auto_debit/auto_debit_bloc.dart';
import '../../features/transfer_funds/presentation/bloc/transfer_account_holding/transfer_account_holding_bloc.dart';
import '../data/datasources/holdings_remote_data_source.dart';
import '../data/datasources/personal_details_remote_data_source.dart';
import '../data/repository/holding_repository.dart';
import '../data/repository/personal_details_repository.dart';
import '../domain/repository/holding_repository.dart';
import '../domain/repository/person_repository.dart';
import '../presentation/bloc/holdings/holdings_bloc.dart';
import '../presentation/bloc/person/person_bloc.dart';

void invokeWeatherDI({required GetIt locator}) {

  // data source
  locator.registerLazySingleton<HoldingRemoteDataSource>(
          () => HoldingRemoteDataSourceImpl(dio: locator()));

  // repository
  locator.registerLazySingleton<HoldingRepository>(
          () => HoldingRepositoryImpl(remoteDataSource: locator()));

  // use case
  locator.registerLazySingleton(() => FetchHoldingUseCase(repository: locator()));

  // bloc
  locator.registerFactory(
      () => HoldingsBloc(fetchHoldingUseCase: locator()));
  locator.registerFactory(
          () => TransferAccountHoldingBloc(fetchHoldingUseCase: locator()));

}
