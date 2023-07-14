import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slmc_app/intro/register.dart';
import 'package:slmc_app/intro/auth_checked.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const route = '/login';
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // Future<FirebaseApp> _initializeFirebase() async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp();
  //   return firebaseApp;
  // }
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible=true;
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _auth= ref.watch(authenticationProvider);

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
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: Colors.indigo, width: 2)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        hintText: "Enter your email"
                    ),
                    validator: (String? value){
                      if(_passwordController.text.isEmpty){
                        return "This Field can not be blank";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 25, 5, 25),
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
                      if(_passwordController.text.isEmpty){
                        return "This Field can not be blank";
                      }

                      return null;
                    },
                  ),
                ),
               ElevatedButton(child: Text("Login"),
                 onPressed: ()async{
                  if(_formKey.currentState!.validate()){
                    _auth.logInWithEmailAndPassword(_emailController.text, _passwordController.text);
                  }
                  else{
                    return;
                  }
               },),
                SizedBox(height: 50,),
                Container(

                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => print('Sign Up Button Pressed'),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don\'t have an Account? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () => Navigator.pushNamed(context, RegisterPage.route))
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
