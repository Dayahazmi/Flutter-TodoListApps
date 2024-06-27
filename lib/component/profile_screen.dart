import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/component/home_screen.dart';
import 'package:project/component/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';




class ProfileScreen extends StatefulWidget {
  final UserProfile userProfile;
  const ProfileScreen({super.key, required this.userProfile});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController carplate = TextEditingController();
  bool loading = true;
  get prefs => null;
  

  @override
  void initState() {
    super.initState();
    
  }
  

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF4F6FF),
        appBar: AppBar(
          leading: SizedBox(
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                )),
          ),
          title: Text(
            'Back',
            style: GoogleFonts.dmSans(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets_images/account.png'), // Ganti dengan path gambar Anda
                          radius:
                              15, // Sesuaikan ukuran radius sesuai kebutuhan
                        ),
                        const SizedBox(width: 10),
                        Text(
                            '${widget.userProfile.firstName} ${widget.userProfile.secondName}',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ],
                ),
              )),
          backgroundColor: const Color(0xFFF4F6FF),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 30, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Me',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 35),
                GestureDetector(
                  //onTap: showAccountInfoDialog,
                  onTap: () {
                    showAccountInfoDialog.call();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(width: 20),
                      Text(
                        'Account Info',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 170),
                      const Icon(Icons.keyboard_arrow_right_sharp),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(
                  color: Colors.black,
                  endIndent: 5,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  //onTap: showEmailnPassword,
                  onTap: () {
                    showEmailnPassword.call();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.email_sharp),
                      const SizedBox(width: 20),
                      Text(
                        'Email & Password',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 130),
                      const Icon(Icons.keyboard_arrow_right_sharp),
                    ],
                  ),
                ),
              
                const SizedBox(height: 5),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.share),
                    const SizedBox(width: 20),
                    Text('Share This App',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(width: 150),
                    const Icon(Icons.keyboard_arrow_right_sharp)
                  ],
                ),
                
                const SizedBox(height: 5),
                const Divider(
                  color: Colors.black,
                ),
                
                const SizedBox(height: 50),
                Center(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  },
                  child: Text(
                    'LOG OUT',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  void showAccountInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ACCOUNT INFO',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Name',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Text(
                    widget.userProfile.firstName,
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'I.D NUMBER',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Text(
                    widget.userProfile.idNumber,
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'PHONE NUMBER',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Text(
                    widget.userProfile.phoneNumber,
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'ADDRESS',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.userProfile.address1,
                        style: GoogleFonts.dmSans(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.userProfile.address2,
                        style: GoogleFonts.dmSans(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.userProfile.address3,
                        style: GoogleFonts.dmSans(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    widget.userProfile.postcode.toString(),
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    ' ${widget.userProfile.city}',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    ' ${widget.userProfile.state}',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                    ),
                  ),
                ])
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Confirm'),
                  ),
                  const SizedBox(
                      width:
                          16), // Add some horizontal spacing between the buttons
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void showEmailnPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email & Password',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10), // Spacer
                Center(
                  child: Text(
                    'EMAIL',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Text(
                    widget.userProfile.email,
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Text(
                    'PASSWORD',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Text(
                    'CONFIRM PASSWORD',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Confirm'),
              ),
            ),
          ],
        );
      },
    );
  }

  

  


}
