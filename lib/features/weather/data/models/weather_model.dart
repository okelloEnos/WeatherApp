import 'package:britam/core/util/constants/values.dart';
import 'package:britam/core/util/extensions/string_extensions.dart';
import 'package:britam/features/raise_request/domain/entities/raise_request_entity.dart';
import 'package:flutter/foundation.dart';

class RaiseRequestModel extends RaiseRequestEntity{

  const RaiseRequestModel({super.policyNumber, super.policyName, super.typeOfRequest, super.requestReason, super.actionId, super.category});

  factory RaiseRequestModel.fromJson(Map<String, dynamic> json){
    return RaiseRequestModel(
      policyNumber: json['policyNumber'],
      policyName: json['policyName'],
      typeOfRequest: json['typeOfRequest'],
      requestReason: json['requestReason']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "abst": "$policyNumber $policyName $typeOfRequest $requestReason".removeSpecialCharacters,
      "ContactFinancialAccounts": contactFinancials(category: category, policyNumber: policyNumber),
      "Owner": owner(category: category, policyNumber: policyNumber, actionId: actionId),
      "Source": "Customer Portal/Mobile App",
      "Status": "Open",
      "BRCRMCompany": company(category: category, policyNumber: policyNumber, actionId: actionId),
      "INSProduct": productCategory(category: category, policyNumber: policyNumber, actionId: actionId),
      // "INSArea": category == generalInsurance ? "Instruction" : "$typeOfRequest",
      "INSArea": "$typeOfRequest",
      "INSSub": sub(category: category, policyNumber: policyNumber, actionId: actionId, typeOfRequest: typeOfRequest),
      "CommMethods": "Customer",
      "BRCRMInternalNotes": "$policyNumber $policyName $typeOfRequest $requestReason".removeSpecialCharacters
    };
  }

  factory RaiseRequestModel.fromEntity({required RaiseRequestEntity entity}){
    return RaiseRequestModel(
      policyNumber: entity.policyNumber,
      policyName: entity.policyName,
      typeOfRequest: entity.typeOfRequest,
      requestReason: entity.requestReason,
      category: entity.category,
      actionId: entity.actionId
    );
  }
}

String contactFinancials({required String? policyNumber, required String? category}){
  return (category?.trim().toLowerCase() == "pension") ? "" : policyNumber ?? "";
}

String owner({required String? policyNumber, required String? category, required String? actionId}){
  switch(category){
    case pension:
      return "WMUNARI";
    case lifeInsurance:
      return "WMUNARI";
    case investment:
      return "WMUNARI";
    case generalInsurance:
      return "WMUNARI";
    default:
      return "";
  }
}

String company({required String? policyNumber, required String? category, required String? actionId}){
  switch(category){
    case pension:
      return "Life Assurance";
    case lifeInsurance:
      return "Life Assurance";
    case investment:
      return "AMC";
    case generalInsurance:
      return "General Insurance";
    default:
      return "";
  }
}

String productCategory({required String? policyNumber, required String? category, required String? actionId}){
  switch(category){
    case pension:
      return "Pension";
    case lifeInsurance:
      return "Individual Life";
    case investment:
      return "UTF/WMF/DISCRET";
    case generalInsurance:
      return "General";
    default:
      return "";
  }
}

String area({required String? policyNumber, required String? category, required String? actionId}){
  switch(category){
    case pension:
      return "Instruction";
    case lifeInsurance:
      return "Instruction";
    case investment:
      return "Instruction";
    case generalInsurance:
      return "Instruction";
    default:
      return "Instruction";
  }
}

String sub({required String? policyNumber, required String? category, required String? actionId, required String? typeOfRequest}){
  switch(category){
    case pension:
      // return "Test By IT";
  return (typeOfRequest != null && typeOfRequest == "Enquiry") ? "Self Service Enquiry" : "Self Service Complaint";
    case lifeInsurance:
      // return "Test By IT";
      return (typeOfRequest != null && typeOfRequest == "Enquiry") ? "Self Service Enquiry" : "Self Service Complaint";
    case investment:
      // return "Test By IT";
  return (typeOfRequest != null && typeOfRequest == "Enquiry") ? "Self Service Enquiry" : "Self Service Complaint";
    case generalInsurance:
      // return "Test By IT";
  return (typeOfRequest != null && typeOfRequest == "Enquiry") ? "Self Service Enquiry" : "Self Service Complaint";
    default:
      return "Test By IT";
  }
}