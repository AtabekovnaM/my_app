import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/pages/entry_page.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/pages/reset_page.dart';
import 'package:my_app/services/auth_service.dart';
import 'package:my_app/services/prefs_service.dart';
import 'package:my_app/services/utils_service.dart';

class LogInPage extends StatefulWidget {
  static final String id = 'login_page';
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();


  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignIn() {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return;

    setState(() {
      isLoading = true;
    });
    AuthService.signInUser(context, email, password).then((value) => {
      _getFirebaseUser(value),
    });
  }

  _getFirebaseUser(Map<String, FirebaseUser> map) async {
    setState(() {
      isLoading = false;
    });
    FirebaseUser firebaseUser;
    if (!map.containsKey("SUCCESS")) {
      if (map.containsKey("ERROR"))
        Utils.fireToast("Check email or password");
      return;
    }
    firebaseUser = map["SUCCESS"];
    if (firebaseUser == null) return;

    await Prefs.saveUserId(firebaseUser.uid);
    Navigator.pushReplacementNamed(context, Profile_Page.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Container(
              padding: EdgeInsets.only(right: 350),
              child: IconButton(
                icon: Icon(Icons.chevron_left),
                color: Colors.black,
                iconSize: 40,
                onPressed: (){
                  Navigator.pushNamed(context, EntryPage.id);
                },
              ),
            ),
          ],
        ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/ic_image.jpg'),
              ),
            ),
            child: Container(
              color: Colors.white.withOpacity(.97),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          Container(
          child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10,right: 10),
                  child: Icon(Icons.headset_mic,color: Colors.red,size: 60,),
                ),
                SizedBox(height: 90,),
                Container(
                  margin: EdgeInsets.only(right: 280,),
                  child: Text("EMAIL",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Container(
                  width: 340,
                  padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: emailController,
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your email",
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Container(
                  margin: EdgeInsets.only(right: 230,),
                  child: Text("PASSWORD",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Container(
                  width: 340,
                  padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your password",
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 16),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, ResetPage.id);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 180,top: 30),
                    child: Text("Forgot Password?",style: TextStyle(color: Colors.red,fontSize: 19,fontWeight: FontWeight.bold),),
                  ),
                ),
                GestureDetector(
                  onTap: _doSignIn,
                  child: Container(
                    margin: EdgeInsets.only(top: 35),
                    width: 350,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 150,top: 22),
                      child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 70,
                      margin: EdgeInsets.only(left: 45,top: 35),
                      decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.grey,width: 2.0))
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 35),
                      child: Text("OR CONNECT WITH",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      width: 70,
                      margin: EdgeInsets.only(left: 20,top: 35),
                      decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.grey,width: 2.0))
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 35,left: 30,right: 30),
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.red[800],
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: isLoading ? GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, Profile_Page.id);
                    },
                  ) : GestureDetector(
                    onTap: (){
                      handleSignIN();
                    },
                    child: Container(
                      child: Center(
                        child: Text("GOOGLE",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                      )
                    ),
                  ),
                )
              ])  
            )
          ])
        ]
      )
    );
  }



  Future<void> handleSignIN() async{
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;

    setState(() {
      isLoading = true;
    });
  }


  Future<void> googleSignOut() async{
   await  _auth.signOut().then((value) {
     _googleSignIn.signOut();

     setState(() {
       isLoading = false;
     });

   });
  }
}
  