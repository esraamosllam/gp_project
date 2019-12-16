import 'package:firebase_auth/firebase_auth.dart';
import '../Pages/signIn.dart';
import 'package:flutter/material.dart';

class signUp extends StatefulWidget {
  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp>{

  String _email , _password ,_name ;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   
  @override
  Widget build(BuildContext context) {
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
                        onPressed:signUp,
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),
                        ),
                        color: Colors.greenAccent,
                        textColor: Colors.white,
                      ),
                    ),
            ),
            
          ],
        ),
      ),
    );

   
  }
   Future<void> signUp()async{
      //final FormState = _formKey.currentState;

      if (_formKey.currentState.validate()){
        _formKey.currentState.save();
        try{
          AuthResult user =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email,
         password:_password ) ;
         
         //user.sendEmailVerification();
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> loginPage()));

        // Navigator.of(context).pop();
        }
        catch(e){
          print(e.message);
        }
        
      }
    }


}
