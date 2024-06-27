import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:project/component/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoItem {
  String title;
  bool isDone;

  ToDoItem({required this.title, this.isDone = false});

  Map<String, dynamic> toJson() => {
    'title': title,
    'isDone': isDone,
  };

  factory ToDoItem.fromJson(Map<String, dynamic> json) => ToDoItem(
    title: json['title'],
    isDone: json['isDone'],
  );
}

class UserProfile {
  final String userID;
  final String firstName;
  final String secondName;
  final String idNumber;
  final String phoneNumber;
  final String email;
  final String? password;
  final String address1;
  final String address2;
  final String address3;
  final int postcode;
  final String city;
  final String state;

  UserProfile({
    required this.userID,
    required this.firstName,
    required this.secondName,
    required this.idNumber,
    required this.phoneNumber,
    required this.email,
    this.password,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.postcode,
    required this.city,
    required this.state,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userID: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      secondName: json['secondname'] ?? '',
      idNumber: json['idNumber'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      password: json['password'],
      address1: json['address1'] ?? '',
      address2: json['address2'] ?? '',
      address3: json['address3'] ?? '',
      postcode: json['postcode'] ?? 0,
      city: json['city'] ?? '',
      state: json['state'] ?? '',
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  UserProfile? userProfile;
  bool loading = true;
  List<ToDoItem> toDoList = [];
  TextEditingController controller = TextEditingController();
  //Future<Infouser>? _userInfoFuture;@override
  void initState() {
    super.initState();
    _loadToDoList();
    fetchUserProfile();
  }

  Future<void> _loadToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedList = prefs.getStringList('toDoList');

    if (storedList != null) {
      setState(() {
        toDoList = storedList.map((item) => ToDoItem.fromJson(Map<String, dynamic>.from(jsonDecode(item)))).toList();
      });
    }
  }

  Future<void> _saveToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedList = toDoList.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('toDoList', storedList);
  }

  void _addToDoItem(String title) {
    setState(() {
      toDoList.add(ToDoItem(title: title));
      _saveToDoList();
    });
    controller.clear();
  }

  void _removeToDoItem(int index) {
    setState(() {
      toDoList.removeAt(index);
      _saveToDoList();
    });
  }

  void _toggleToDoItem(int index) {
    setState(() {
      toDoList[index].isDone = !toDoList[index].isDone;
      _saveToDoList();
    });
  }


  Future<void> fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) return;

    final response = await http.get(
      Uri.parse("http://192.168.43.235:3000/auth/user-profile"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (kDebugMode) {
      print('response.body : $token');
    }

   
    print('response.body : ${response.statusCode}');
    if (response.statusCode == 200) {
      setState(() {
        Map<String, dynamic> jsonList = jsonDecode(response.body);
        userProfile = UserProfile.fromJson(jsonList);
        if (kDebugMode) {
          print('user profile nk : $userProfile');
        }
        loading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: Column(
        children: [ 
          const SizedBox(height: 100,width: 30,),
            GestureDetector(
              onTap: () {
                if (userProfile != null) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ProfileScreen(userProfile: userProfile!)));
                }
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage(
                    'assets_images/account.png'), // Ganti dengan path gambar Anda
                radius: 15, // Sesuaikan ukuran radius sesuai kebutuhan
              ),
            ),
          const SizedBox(height: 25), 
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: GoogleFonts.ptSans(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height:5), // Menambahkan jarak antara 'Welcome' dan 'nik haqim'
                Text(
                  userProfile?.firstName ?? '',
                  style: GoogleFonts.dmSans(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 35),        
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('TO-DO LIST APP', 
              style: GoogleFonts.roboto(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            )
          ),
          const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'New To-Do Item',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _addToDoItem(controller.text),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                final item = toDoList[index];
                return ListTile(
                  title: Text(
                    item.title,
                    style: TextStyle(
                      decoration: item.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: item.isDone,
                    onChanged: (bool? value) {
                      _toggleToDoItem(index);
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeToDoItem(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
    
  }
}






