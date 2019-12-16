
import '../Pages/signIn.dart';
import '../Pages/signUp.dart';
import 'package:flutter/material.dart';

class welcomePage extends StatefulWidget {
  @override
  _welcomePageState createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage>{
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopingoo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
             
             child: RaisedButton(
               color: Colors.green,
               textColor: Colors.white,
               
                onPressed:navigateToSignIn,
                child: Text('Sign in',
                style: TextStyle(fontSize: 18),
                ),
                
              ),
           ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: RaisedButton(
                color: Colors.deepOrange,
               textColor: Colors.white,
                onPressed: navigateToSignUp,
                child: Text('Sign up',
                style: TextStyle(fontSize: 18),),
              ),
            ),

        ],
      ),
    );
  }

  void navigateToSignIn()
  {
     Navigator.push(context, MaterialPageRoute(builder: (context)=> loginPage(), fullscreenDialog: true));
        
  }

  void navigateToSignUp()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> signUp(), fullscreenDialog: true));
  }
}