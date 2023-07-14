import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slmc_app/product_block/block/product_events.dart';
import 'package:slmc_app/product_block/block/product_states.dart';
import 'package:slmc_app/product_block/respository_block.dart';

class ProductBlock extends Bloc<ProductEvent,ProductStates>{
  final Repository repository;


  ProductBlock( this.repository) : super(ProductErrorState("dd")){
    on<LoadProductEvent>((event,emit) async{
     print("im in bloc");
     emit(ProductLoadingState());
     print(state);
      try{
        final products = await repository.products();
        print(state);
        emit(ProductLoadedState(products));
        print("entered");
        print(ProductLoadedState(products));
        print(state);
      }
      catch(e){
        emit(ProductErrorState(e.toString()));
      }
    });
  }

 // // super(ProductErrorState("dd"));@override
 //  Stream<ProductStates> mapEventToState(ProductEvent event) async* {
 //    switch (event) {
 //      case eventLoadProductEvent():
 //        yield ProductLoadedState(products);
 //        try {
 //          albums = await albumsRepo.getAlbumList();
 //          yield AlbumsLoaded(albums: albums);
 //        } on SocketException {
 //          yield AlbumsListError(
 //            error: NoInternetException('No Internet'),
 //          );
 //        } on HttpException {
 //          yield AlbumsListError(
 //            error: NoServiceFoundException('No Service Found'),
 //          );
 //        } on FormatException {
 //          yield AlbumsListError(
 //            error: InvalidFormatException('Invalid Response format'),
 //          );
 //        } catch (e) {
 //          yield AlbumsListError(
 //            error: UnknownException('Unknown Error'),
 //          );
 //        }break;
 //    }
 //  }
}




