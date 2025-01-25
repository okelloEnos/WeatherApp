import '../entities/raise_request_entity.dart';

abstract class RaiseRequestRepository {
  Future<String> submitRaiseRequest({required RaiseRequestEntity entity});
}