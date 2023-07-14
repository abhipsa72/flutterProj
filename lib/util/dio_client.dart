import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioClient{
   Dio dio= Dio();
   DioClient(this.dio) {
     dio.options.baseUrl= "https://fakestoreapi.com";
     dio.options.connectTimeout= 2000;

   }
Future<Response> get(String path, {Map<String,dynamic>? params}) async{
  return dio.get(path,
  queryParameters: params
  );
}


}
final dio =Provider<Dio>((ref){return Dio();});
final dioClientProvider= Provider<DioClient>((ref){
  return DioClient(ref.read(dio));
});