import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:slmc_app/intro_bloc/auth_sevice.dart';
import 'package:slmc_app/product_block/api_manager_block.dart';
import 'package:slmc_app/product_block/block/ChangeColorBlock.dart';
import 'package:slmc_app/product_block/block/product_block.dart';
import 'package:slmc_app/util/dio_client.dart';

import '../product_block/respository_block.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(ApiManager(getIt<DioClient>()));
  getIt.registerSingleton(Repository(getIt.get<ApiManager>()));
getIt.registerSingleton(ProductBlock(getIt<Repository>()));
getIt.registerSingleton(Authentication());
  getIt.registerSingleton(ChangeColorBlock());
}