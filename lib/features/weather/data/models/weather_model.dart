import '../../weather_barrel.dart';

class WeatherModel extends WeatherEntity{

  const WeatherModel({super.policyNumber, super.policyName, super.typeOfRequest, super.requestReason, super.actionId, super.category});

  factory WeatherModel.fromJson(Map<String, dynamic> json){
    return WeatherModel(
      policyNumber: json['policyNumber'],
      policyName: json['policyName'],
      typeOfRequest: json['typeOfRequest'],
      requestReason: json['requestReason']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "Source": "Customer Portal/Mobile App",
      "Status": "Open",
      "INSArea": "$typeOfRequest",
      "CommMethods": "Customer",
    };
  }

  factory WeatherModel.fromEntity({required WeatherEntity entity}){
    return WeatherModel(
      policyNumber: entity.policyNumber,
      policyName: entity.policyName,
      typeOfRequest: entity.typeOfRequest,
      requestReason: entity.requestReason,
      category: entity.category,
      actionId: entity.actionId
    );
  }
}