
import '../userScreens/myHomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../userScreens/listProducts.dart';

class loginPage extends StatefulWidget {

  
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
var userID;
var username;
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser;
   initUser() async{
    firebaseUser = await _firebaseAuth.currentUser();
    userID = firebaseUser.uid;
    //username = firebaseUser.email;
    setState(() {});
  }
  @override
  void initState(){
    super.initState();
    initUser();
  }
  String _email , _password ;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Sign in'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 40.0, bottom: 0.0, right: 50.0, left: 22.0),
              child: TextFormField(
                validator:(input){
                  if(input.isEmpty){
                    return 'Please type email';
                  }
                } ,
                onSaved:(input)=>_email = input,
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 40.0, bottom: 0.0, right: 50.0, left: 22.0),
              child: TextFormField(
              validator:(input){
                if(input.length < 6){
                  return 'Your password need to be at least 6 characters';
                }
              } ,
              onSaved:(input)=>_password = input,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                obscureText: true,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(14.0),
              child: ButtonTheme(
                      minWidth: 170,
                      child: RaisedButton(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, right: 20, left: 20),
                        onPressed:signIn,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),
                        ),
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );

   
  }
   Future<void> signIn()async{
      final FormState = _formKey.currentState;

      if (FormState.validate()){
        FormState.save();
        try{
          AuthResult user =  await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email,
         password:_password ) ;
         username= _email;
         Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProudct(currentId: userID, currentName: username)));
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
        }
        catch(e){
          print(e.message);
        }
      }
    }
}