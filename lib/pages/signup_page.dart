import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/pages/entry_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/services/auth_service.dart';
import 'package:my_app/services/prefs_service.dart';
import 'package:my_app/services/utils_service.dart';

class SignUpPage extends StatefulWidget {
  static final String id = 'signup_page';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var isLoading = false;
  var emailController = TextEditingController();
  var fullnameController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();


  _doSignUp() {
    String name = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = cpasswordController.text.toString().trim();
    if (name.isEmpty || email.isEmpty || password.isEmpty) return;
    if (password != cpassword) {
      Utils.fireToast("Password and confirm password does not match");
      return;
    }
    setState(() {
      isLoading = true;
    });
    User user = new User(fullname: name, email: email, password: password);
    AuthService.signUpUser(context, name, email, password).then((value) =>
    {
      _getFirebaseUser(user, value),
    });
  }

  _getFirebaseUser(User user, Map<String, FirebaseUser> map) async {
    setState(() {
      isLoading = false;
    });
    FirebaseUser firebaseUser;
    if (!map.containsKey("SUCCESS")) {
      if (map.containsKey("ERROR_EMAIL_ALREADY_IN_USE"))
        Utils.fireToast("Email already in use");
      if (map.containsKey("ERROR"))
        Utils.fireToast("Try again later");
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
                                padding: EdgeInsets.only(top: 10),
                                child: Icon(Icons.headset_mic,color: Colors.red,size: 60,),
                              ),
                              SizedBox(height: 50,),
                              Container(
                                margin: EdgeInsets.only(right: 235,),
                                child: Text("FULLNAME",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
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
                                  controller: fullnameController,
                                  style: TextStyle(color: Colors.grey),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter your fullname",
                                    hintStyle: TextStyle(color: Colors.grey,fontSize: 16),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
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
                              SizedBox(height: 15,),
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
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 5,left: 32),
                                    child: Text("CONFIRM",style: TextStyle(color: Colors.red,fontSize: 19,fontWeight: FontWeight.bold),),
                                  ),
                                  Text("PASSWORD",style: TextStyle(color: Colors.red,fontSize: 19,fontWeight: FontWeight.bold),),
                                ],
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
                                  controller: cpasswordController,
                                  style: TextStyle(color: Colors.grey),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter your password again",
                                    hintStyle: TextStyle(color: Colors.grey,fontSize: 16),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacementNamed(context, LogInPage.id);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 125,top: 30),
                                  child: Text("Already have an account?",style: TextStyle(color: Colors.red,fontSize: 19,fontWeight: FontWeight.bold),),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  _doSignUp();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 25),
                                  width: 350,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 140,top: 25),
                                    child: Text("SIGN UP",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
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
}
