import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slmc_app/intro_bloc/auth_bloc.dart';
import 'package:slmc_app/intro_bloc/login_view.dart';
import 'package:slmc_app/product_block/respository_block.dart';
import 'package:slmc_app/intro/auth_checked.dart';
import 'package:slmc_app/util/locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

 void main() async{
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
   runApp(MyApp());
 }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeController = getIt<Repository>();
    final authController = getIt<Repository>();
    return MaterialApp(
      title: 'Flutter Bloc Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

  home: RepositoryProvider(create: ( context) => Authentication(),
  child: BlocProvider(create: (context) => AuthenticationBlock(authRepository: RepositoryProvider.of<Authentication>(context)),
                    child: LoginView(),
),
),
      // home: BlocProvider(
      //     create:(context) => ProductBlock(homeController) ,
      //     child: ProductView())
    );
  }
}
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }



  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}