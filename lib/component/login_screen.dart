import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/component/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:project/component/signup_screen.dart';
import 'package:project/widget/widgets.dart';
import 'package:project/widget/background-image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final bool _obsecurePassword = true;
  final TextEditingController _usernameoremailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  

  Future<void> login() async {
    var email = _usernameoremailController.text;
    var password = _passwordController.text;

    if (kDebugMode) {
      print('Email: $email');
    }
    if (kDebugMode) {
      print('Password: $password');
    }
    var url = Uri.parse("http://192.168.43.235:3000/auth/signin");
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',        
      },
      body: jsonEncode({
        'email': email,
        'password': password,        
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      if (kDebugMode) {
        print(data['token']);
      }
      if (kDebugMode) {
        print('Login Successfully');
      }
      
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen()));      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', data['token']); // Save token
    } else {
      if (kDebugMode) {
        print('Failed with status code: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Response body: ${response.body}');
      }
    }
  }

  Future<dynamic> showMessage(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
     return Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [               
                  
                  Text(
                    'Login',
                    style: GoogleFonts.secularOne(
                      fontSize: 30.0, 
                      color: Colors.white,                     
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text ('Sign in to continue',
                    style: GoogleFonts.secularOne(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding (
                    padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _usernameoremailController,                          
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          hintText: 'Enter Email',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  Container(                    
                    decoration: const BoxDecoration(            
                    ),
                    child: Padding (
                      padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _obsecurePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            hintText: 'Enter Password',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),                            
                          ),
                        ),
                      ),                  
                    ),
                  const SizedBox(height: 25.0),                 
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: (){
                        login();
                      }, 
                      child: const Text('Sign In'),
                    ),
                  ),                 
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (e) => const SignUpScreen() ),);
                    }, 
                    child:  Text("Don't have an account? Sign Up",
                     style: GoogleFonts.secularOne(
                      color: Colors.white,
                     ),
                    ),
                  ),
                               
                  
                ],                
              ),              
            ),
          )
        )
      ],
    );
  } 
 
}