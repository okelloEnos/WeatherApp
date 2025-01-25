import 'package:britam/features/raise_request/domain/entities/raise_request_entity.dart';

import '../../domain/repository/raise_request_repository.dart';
import '../datasources/raise_request_remote_data_source.dart';
import '../models/raise_request_model.dart';

class RaiseRequestRepositoryImpl implements RaiseRequestRepository{
  final RaiseRequestRemoteDataSource _raiseRequestRemoteDataSource;

  RaiseRequestRepositoryImpl({required RaiseRequestRemoteDataSource raiseRequestRemoteDataSource}) :
        _raiseRequestRemoteDataSource = raiseRequestRemoteDataSource ;

  @override

  Future<String> submitRaiseRequest({required RaiseRequestEntity entity}) {
    return _raiseRequestRemoteDataSource.submitRaiseRequest(model: RaiseRequestModel.fromEntity(entity: entity));
  }


}