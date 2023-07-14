import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:slmc_app/product_block/products_model.dart';

@immutable
abstract class ProductEvent  {
  ProductEvent();
}

class LoadProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class AddToWishlistEvent extends ProductEvent{

}