import 'package:dio/dio.dart';
import '../../../../core/api/api.dart';
import '../../../../core/core_barrel.dart';
import '../models/raise_request_model.dart';

abstract class RaiseRequestRemoteDataSource {

  Future<String> submitRaiseRequest({required RaiseRequestModel model});
}

class RaiseRequestRemoteDataSourceImpl implements RaiseRequestRemoteDataSource {
  final Dio _dio;

  const RaiseRequestRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override

  Future<String> submitRaiseRequest({required RaiseRequestModel model}) async{
    var url = "${Api.baseUrl}/service-request/service-request-without-attachment";

    var data = model.toJson();

    final response = await _dio.post(url, data: data, options: Options(headers: {
      'Authorization':
      'Bearer ${locator<SharedPreferencesUtil>().getValidToken()}'
    }));

    if((response.statusCode ?? 0) == 201){
      final submitResponse = dynamicErrorReturn(response: response.data, errorText: "Could not raise a request");

      return submitResponse["data"]["content"]["ns:ServiceReqInsert_Output"]["ListOfServicereqio"]["ServiceRequest"]["SRNumber"];
    }
    else {
      throw("${response.statusMessage}");
    }
  }

}