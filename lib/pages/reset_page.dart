import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/pages/login_page.dart';

class ResetPage extends StatefulWidget {
  static final String id = 'reset_page';
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final auth = FirebaseAuth.instance;
  var emailController = TextEditingController();
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Navigator.pushNamed(context, LogInPage.id);
                },
              ),
            ),
          ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(
              child: Center(
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
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
                onChanged: (value){
                  setState(() {
                    _email = value;
                  });
                },
              ),
            ),
            GestureDetector(
              onTap: (){
                resetPassword(context);
              },
              child: Container(
                  margin: EdgeInsets.only(top: 35),
                  width: 350,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 120,top: 22),
                    child: Text("Send Request",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold),),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetPassword(BuildContext context) async{
    if(emailController.text.length == 0 || !emailController.text.contains("@")){
      Fluttertoast.showToast(msg: "Enter valid email");
      return;
    }

    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
    Fluttertoast.showToast(msg: "Reset password link has sent  your mail please use it to change the password");
    Navigator.pop(context);
  }
}
