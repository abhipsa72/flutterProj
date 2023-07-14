import 'package:slmc_app/product_block/products_model.dart';

import 'api_manager_block.dart';

class Repository {
  ApiManager apiManager ;

  Repository(this.apiManager) ;

  Future<List<ProductsModel>> products()
  async
  {
    final response =  await apiManager.products();
    print("qq");
    List<ProductsModel> products =  productsFromJson(response.data);


    return  products;
  }


}