import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:slmc_app/product_block/block/ChangeColorBlock.dart';
import 'package:slmc_app/product_block/block/product_block.dart';
import 'package:slmc_app/product_block/block/product_events.dart';
import 'package:slmc_app/product_block/block/product_states.dart';
import 'package:slmc_app/product_block/block/wishListState.dart';
import 'package:slmc_app/util/locator.dart';


class ProductView extends StatefulWidget{
  static const route = '/product';
  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>{
  final homeController = getIt<ProductBlock>();
  final wishListController= getIt<ChangeColorBlock>();
  //final ProductBlock bloc = BlocProvider.of<ProductBlock>(context);
  @override
  void initState() {
    super.initState();
    print("im in UI pre");
      homeController.add(LoadProductEvent());

    print("im in ui post");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.transparent,
           elevation: 0,
           title: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal:20 ,vertical: 10),
                   child: Image.asset(
                     'assets/logoa.jpg',
                     fit: BoxFit.fitWidth,
                     height: MediaQuery.of(context).size.height * 0.2,
                     width: MediaQuery.of(context).size.width * 0.2,
                   ),
                 ),
               ]),
         actions: [
           IconButton(onPressed: (){Navigator.pushNamed(context, ProductView.route);}, icon: Icon(Icons.shopping_bag_outlined),color: Colors.black),
           IconButton(onPressed:() {Navigator.pushNamed(context, ProductView.route);}, icon: Icon(Icons.favorite_border),color: Colors.black)
         ],
         ),

         body: BlocBuilder<ProductBlock,ProductStates>(
               bloc: homeController,
       // listener: (context, state){},
           builder: (context,state) {
             print("Inside blockbuilder $state");
             if (state is ProductLoadingState) {
               return Center(
                 child: Container(child: CircularProgressIndicator()),
               );
             }
             if (state is ProductErrorState) {
               print(state);
               return Center(child: Container(child: Text(state.error)),);
             }
             else if (state is ProductLoadedState) {
               print("loaded state");
               print("Inside blockbuilder condition $state");
               return ListView.builder(itemCount: state.users.length,
                   itemBuilder: (BuildContext context, index){
                 return Container(
                   height: MediaQuery.of(context).size.height * 0.40,
                   child: Card(
                     elevation: 5,
                     child: GestureDetector(
                       onTap: (){
                       //  Navigator.push(context, route);
                       },
                       child: Stack(
                         children: [

                    //  state is WishListAdded? Icon(Icons.favorite_border,color: Colors.red,) : Icon(Icons.favorite,color: Colors.red,),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Image.network(
                                 //color: Colors.indigo,
                                   width: MediaQuery.of(context).size.width ,
                                   height: 200,
                                   fit : BoxFit.fill,
                                   state.users[index].image),
                               Text(state.users[index].title),
                               RichText(text: TextSpan(text: "₹",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.cyan),children:<TextSpan>[TextSpan(text: state.users[index].price.toString())] ))
                             ],
                           ),

                           BlocConsumer<ChangeColorBlock,WishListAddedState>(
                               bloc: wishListController,
                             listener:  (context, state){},
                               builder: (context,state){
                                return IconButton(onPressed: (){ print("aa $state"); wishListController.add(AddToWishlistEvent());}, icon: Icon(state.isPressed? Icons.favorite_border : Icons.favorite, color: Colors.pinkAccent,));
                               }

                           )
                         ],

                       ),
                     ),
                   ),
                 );
               });
             }

             return Center(child: Container(child: Text("Data not found"),));
           }
         )

       );
  }

}

