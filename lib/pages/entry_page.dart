import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/signup_page.dart';

import 'login_page.dart';
class EntryPage extends StatefulWidget {
  static final String id = 'entry_page';
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 1100,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/ic_image.jpg'),
              ),
            ),
            child: Container(
              color: Colors.redAccent.withOpacity(.88),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 230,left: 80),
                  child: Column(
                    children: [
                      Icon(Icons.headset_mic,size: 60,color: Colors.white,),
                      SizedBox(height: 20,),
                      Text(
                        "Example App",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, SignUpPage.id);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 80),
                      padding: EdgeInsets.all(20),
                      width: 250,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.0,color: Colors.white),
                          borderRadius: BorderRadius.circular(35)
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 70,top: 3),
                        child: Text("SIGN UP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
                      )
                  ),
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, LogInPage.id);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 80),
                      padding: EdgeInsets.all(20),
                      width: 250,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.white
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 80,top: 5),
                        child: Text("LOGIN",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 17),),
                      )
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
