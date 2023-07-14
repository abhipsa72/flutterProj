import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slmc_app/intro/auth_checked.dart';
import 'package:slmc_app/intro_bloc/auth_event.dart';
import 'package:slmc_app/intro_bloc/auth_state.dart';

class AuthenticationBlock extends Bloc<AuthenticationEvent,AuthenticationState>{
  final Authentication authRepository;
  AuthenticationBlock({required this.authRepository}) : super(Uninitialized()){

    on<AppStarted>((event, emit) async{
     emit(Loading());
    bool authCheck=  authRepository.isAuthenticated;
    if(authCheck){
      emit(LoginAuthenticated());
    }
    emit(Uninitialized());
    });

   on<LoginClicked>((event,emit) async{
     try {
       await authRepository.logInWithEmailAndPassword(event.email, event.password);
       emit(LoginAuthenticated());
     }
     catch (e) {

       emit(LoginUnauthenticated(e.toString()));

     }
     });

    on<SignUpClicked>((event,emit) async{
      try {
        await authRepository.signUpWithEmailAndPassword(event.email, event.email, event.email,event.number);
        emit(Registerauthenticated());
      }
      catch (e) {

        emit(RegisterUnauthenticated(e.toString()));

      }
    });



  }



}