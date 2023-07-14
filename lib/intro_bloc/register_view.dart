import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slmc_app/intro_bloc/auth_bloc.dart';
import 'package:slmc_app/intro_bloc/auth_event.dart';
import 'package:slmc_app/intro_bloc/auth_state.dart';



class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const route = '/register';
  @override
 State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // Future<FirebaseApp> _initializeFirebase() async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp();
  //   return firebaseApp;
  // }
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible=true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _numberController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final  AuthenticationBlock bloc= BlocProvider.of<AuthenticationBlock>(context);
    print("builder called");
    return Scaffold(
      appBar:  AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(onPressed: (){}, icon: Icon(Icons.menu)); },),
        title: Container(
          child: Row(
            children: [
              Image.asset(
                "assets/img.png",
                //fit: BoxFit.cover,
              ),

            ],
          ),
        ),
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: <Color>[Colors.white70,Colors.blueAccent])),),

      ),
      body: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 25),
                    child: TextFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: Colors.indigo, width: 2)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          hintText: "Enter your name"
                      ),
                      validator: (String? value){
                        if(_confirmPasswordController.text.isEmpty){
                          return "This Field can not be blank";
                        }
                        return null;
                      },
                      controller: _nameController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 25),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: Colors.indigo, width: 2)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          hintText: "Enter your email"
                      ),
                      validator: (String? value){
                        if(_emailController.text.isEmpty){
                          return "This Field can not be blank";
                        }

                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 25),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: Colors.indigo, width: 2)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          hintText: "Enter your password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              print("touching");
                              setState(() {
                                print(passwordVisible);
                                passwordVisible = !passwordVisible;
                                print(passwordVisible);
                              });
                            },
                            child: Icon(passwordVisible? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined
                            ),
                          )
                      ),
                      validator: (String? value){
                        if(_confirmPasswordController.text.isEmpty){
                          return "This Field can not be blank";
                        }

                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 25),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: Colors.indigo, width: 2)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          hintText: "Confirm password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              print("touching");
                              setState(() {
                                print(passwordVisible);
                                passwordVisible = !passwordVisible;
                                print(passwordVisible);
                              });
                            },
                            child: Icon(passwordVisible? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined
                            ),
                          )
                      ),
                  validator: (String? value){
                    if(_confirmPasswordController.text.isEmpty){
                      return "This Field can not be blank";
                    }
                        if(_passwordController.text != _confirmPasswordController.text){
                          return "Password doesn't match";
                        }
                        return null;
          },
                    ),
                  ),
                  BlocConsumer<AuthenticationBlock,AuthenticationState>(
                    bloc: bloc,
                    listener: (context,state){
                      if(state is Registerauthenticated){
                        print("object");
                       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registered"), backgroundColor: Colors.green,));
                      }
                      if(state is RegisterUnauthenticated){
                        print("2");
                       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    builder: (context,state){
                     return ElevatedButton(
                        child: Text("Register"),
                        onPressed: ()async{
                          if(_formKey.currentState!.validate()){
                            BlocProvider.of<AuthenticationBlock>(context).add(SignUpClicked(_emailController.text,_passwordController.text,_nameController.text,_nameController.text));
                          }
                          else{
                            return;
                          }
                        },);
                    },

                  ),
                  Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () => print('Sign Up Button Pressed'),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an Account? ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => print("object"))
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
      ),
    );
  }
}
