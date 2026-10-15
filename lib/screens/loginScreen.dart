import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:productsapp/cubit/auth_cubit.dart';
import 'registerScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _hide = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit,AuthState>(
        listener: (context,state){
          if(state is AuthError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context,state){
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Lottie.asset('assets/aminations/Product.json',
                        height: 200,
                          width: 200
                        ),
                      ),
                      Text("Welcome\nBack!",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: Colors.grey
                            )
                            , border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        )),
                        validator: (v) => v == null || !v.contains('@')
                            ? 'Enter a valid email'
                            : null,
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: _password,
                        obscureText: _hide,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: Colors.grey
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                                _hide ? Icons.visibility_off : Icons.visibility),
                            onPressed: () => setState(() => _hide = !_hide),
                          ),
                        ),
                        validator: (v) => v == null || v.length < 6
                            ? 'Min 6 characters'
                            : null,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:Colors.red
                          ),
                          onPressed: state is AuthLoading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<AuthCubit>()
                                  .login(_email.text, _password.text);
                            }
                          },
                          child: state is AuthLoading
                              ? const CircularProgressIndicator()
                              : const Text('Login',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text("OR",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                      GoogleSignInButton(
                          loadingIndicator:
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2,),
                          ),
                          clientId: "254953698829-6niaqj5i73c44r5uavs2sevl4f76drs9.apps.googleusercontent.com"),
                      TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RegisterScreen())),
                        child: Center(
                          child: const Text("Create An Account? Sign Up",
                            style: TextStyle(
                                color: Colors.grey
                            ),),
                        ),
                      ),





                    ],
                  )),
            ),
          );
        },
      ),




    );
  }
}
