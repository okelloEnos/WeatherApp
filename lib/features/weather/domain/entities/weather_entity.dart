import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable{
  final String? policyNumber;
  final String? policyName;
  final String? typeOfRequest;
  final String? requestReason;
  final String? category;
  final String? actionId;

  const WeatherEntity({this.policyNumber, this.policyName, this.typeOfRequest, this.requestReason, this.category, this.actionId});

  @override
  List<Object?> get props => [policyNumber, policyName, typeOfRequest, requestReason, category, actionId];
}