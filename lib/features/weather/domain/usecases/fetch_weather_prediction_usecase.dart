
import '../entities/raise_request_entity.dart';
import '../repository/raise_request_repository.dart';

class SubmitRaiseRequestUseCase {
  final RaiseRequestRepository _repository;

  SubmitRaiseRequestUseCase({required RaiseRequestRepository repository}) : _repository = repository;

  Future<String> call({required RaiseRequestEntity entity}) async {
    return await _repository.submitRaiseRequest(entity: entity);
  }
}