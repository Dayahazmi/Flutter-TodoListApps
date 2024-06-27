import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:project/widget/UserProvider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {  
  late UserProvider userProvider;
  bool _obsecurePassword = true;
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController ic = TextEditingController();
  TextEditingController numberPhone = TextEditingController();
  TextEditingController numberPlate = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    userProvider = UserProvider(); // Initialize userProvider in initState
  }  

Future signupscreen() async {
  var url = Uri.parse("http://192.168.0.119/flutter-login-signup/register_page.php");

  var response = await http.post(url, body: {
    "email": user.text,
    "password": pass.text,
    "username": name.text,
    "numphone": numberPhone.text,
    "numplate": numberPlate.text,
    "ConfirmPassword": confirmPassword.text,
    "ic": ic.text,
  });

  var data = json.decode (response.body);
  if (data == "Error") {
    Fluttertoast.showToast(
        msg: "This User Already Exist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }else {
    userProvider.login(numberPlate.text, name.text);
    Fluttertoast.showToast(
        msg: "Registeration Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }
}

  @override
  Widget build(BuildContext context) {
    int hexColorValue = int.parse('F8F6F0', radix: 16) | 0xFF000000;
    return Scaffold(
      backgroundColor: Color(hexColorValue),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [              
              const SizedBox(height: 20.0),
              const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                  },
                  child: const Text('Already Registered? Log in here'),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //username
                    TextFormField(
                      controller: name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';                          
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Name'),
                        hintText: 'Enter Your Name',
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
                        fillColor: Colors.white.withOpacity(0.7),  
                      ),                     
                    ),
                    const SizedBox(height: 16),
                    //ic
                    TextFormField(
                      controller: ic,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your ic';                          
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('IC'),
                        hintText: 'Enter Your IC',
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
                        fillColor: Colors.white.withOpacity(0.7),  
                      ),
                    ),
                    const SizedBox(height: 16),
                    //numberphone
                    TextFormField(
                      controller: numberPhone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your number phone';                          
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Number Phone'),
                        hintText: 'Enter Your Number Phone',
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
                        fillColor: Colors.white.withOpacity(0.7),  
                      ),
                    ),
                    const SizedBox(height: 16),
                    //number plate
                    TextFormField(
                      controller: numberPlate,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Number Plate';                          
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Number Plate'),
                        hintText: 'Enter Your Number Plate',
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
                        fillColor: Colors.white.withOpacity(0.7),  
                      ),                     
                    ),
                    const SizedBox(height: 16),
                    //email
                    TextFormField(
                      controller:user,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';                          
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Email'),
                        hintText: 'Enter Your Email',
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
                        fillColor: Colors.white.withOpacity(0.7),  
                      ),
                    ),
                    const SizedBox(height: 16),
                    //password
                    TextFormField(
                      controller: pass,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';                          
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        hintText: 'Enter Your Password',
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
                        fillColor: Colors.white.withOpacity(0.7),  
                      ),
                      obscureText: _obsecurePassword,
                    ),
                    const SizedBox(height: 16), 
                    //confirm password                   
                    TextFormField(
                      controller: confirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Confirm Password';                          
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Confirm Password'),
                        hintText: 'Enter Your Confirm Password',
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
                        fillColor: Colors.white.withOpacity(0.7),  
                      ),
                      obscureText: _obsecurePassword,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        signupscreen();
                        Navigator.pushNamed(context, '/');
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 50, 10, 169),
                        )
                      ),
                      child: const Text('Sign up',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      ),                                                         
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
