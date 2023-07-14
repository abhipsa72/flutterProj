import 'package:equatable/equatable.dart';
import 'package:slmc_app/product_block/products_model.dart';

abstract class ProductStates {}
  class ProductLoadingState extends ProductStates {
  @override
  List<Object?> get props => [];
  }

  class ProductLoadedState extends ProductStates {
  final List<ProductsModel> users;
  ProductLoadedState(this.users);
  @override
  List<Object?> get props => [users];

  }

  class ProductErrorState extends ProductStates {
  final String error;
  ProductErrorState(this.error);
  @override
  List<Object?> get props => [error];
  }


