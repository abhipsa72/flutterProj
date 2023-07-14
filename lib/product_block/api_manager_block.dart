import 'package:dio/dio.dart';
import 'package:slmc_app/util/dio_client.dart';

class ApiManager{
  final DioClient dioClient;

  ApiManager(this.dioClient);

  Future<Response> products() async {
    return  dioClient.get("/products");
  }

}