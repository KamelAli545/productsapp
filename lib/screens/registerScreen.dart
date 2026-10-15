import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productsapp/cubit/auth_cubit.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:productsapp/screens/loginScreen.dart';
import 'package:productsapp/widgets/inputWidgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _confirm = TextEditingController();
  bool _hide=true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Create an\naccount',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                   InputWidgets(
                       label: "Name",
                       controller: _name,
                     keyboardType: TextInputType.name,
                     validator: (v) {
                       if (v == null || v.trim().isEmpty) return 'Enter your name';
                       if (!RegExp(r'[A-Z]').hasMatch(v)) return 'Name must contain a capital letter';
                       return null;
                     },
                   ),
                    const SizedBox(height: 15),
                    InputWidgets(
                      label: "Email",
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v)=>(
                          v==null||!v.contains('@')?
                          "Enter a vaild email":null
                      ),
                    ),
                    const SizedBox(height: 15),
                    InputWidgets(
                      label: "Password",
                      controller: _password,
                      obscureText: true,
                      validator: (v)=>(
                          v==null||v.length<6?
                          "Enter a More Than 6 Characters ":null
                      ),
                    ),
SizedBox(height: 15,),
                    InputWidgets(
                      label: 'Confirm Password',
                      controller: _confirm,
                      obscureText: true,
                      validator: (v) =>
                      (v == null || v != _password.text) ? "Passwords don't match" : null,
                    ),

                    const SizedBox(height: 24),
                    Text.rich(
                      const TextSpan(
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        children: [
                          TextSpan(text: 'By clicking the '),
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' button, you agree to the public offer'),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red
                        ),
                        onPressed: state is AuthLoading
                            ? null
                            : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().register(
                              name: _name.text,
                              email: _email.text,
                              password: _password.text,
                            );
                          }
                        },
                        child: state is AuthLoading
                            ? const CircularProgressIndicator()
                            : const Text('Sign Up',
                          style: TextStyle(
                              color: Colors.white
                          ),),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text("OR Continue With",
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
SizedBox(height: 10,),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => LoginScreen())),
                      child: Center(
                        child: const Text("Do have an account? Login",
                          style: TextStyle(
                              color: Colors.grey
                          ),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
