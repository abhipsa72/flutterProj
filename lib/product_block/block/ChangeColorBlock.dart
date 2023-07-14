import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slmc_app/product_block/block/product_events.dart';
import 'package:slmc_app/product_block/block/product_states.dart';
import 'package:slmc_app/product_block/block/wishListState.dart';

class ChangeColorBlock extends Bloc<ProductEvent,WishListAddedState>{
  ChangeColorBlock() : super(WishListAddedState(true)){
    on<AddToWishlistEvent>((event,emit) async{
    print('Wishlist Product Clicked');
   print(state.isPressed);
emit(WishListAddedState(!state.isPressed));
    print(state.isPressed);
// wishlistItems.add(event.clickedProduct);
// emit(HomeProductItemWishlistedActionState());
  }

  );}

}