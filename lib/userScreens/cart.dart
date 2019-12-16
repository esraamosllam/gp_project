import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gp_project/userScreens/order.dart';
import '../userScreens/itemdetails.dart';

class myCart extends StatefulWidget {
  var currentId;
  

  @override
  _myCartState createState() => _myCartState();
  myCart({this.currentId});
}

class _myCartState extends State<myCart> {
  var total=0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cart "),
        centerTitle: false,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> order(total: total,currentId: widget.currentId)));
              }),
        ]   
      ),
      //body: Text("${widget.currentId}"),
      body:  _draw(),
    );
  }
 Widget _draw(){

    return 
        StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('cart').where('userId', isEqualTo: widget.currentId,).where('added', isEqualTo:false).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        if (snapshot.data.documents == null)
          return new Text('Error');
        else{

        
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          
          default:
            return new ListView(
              
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return Card(
                  child: new Column(
                    children: <Widget>[
                      Container(
                     
                     child: Center(

                       child: Row(

                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Padding(
                             padding: const EdgeInsets.all(16.0),
                             child: Text(document['itemTitle'],
                             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(16.0),
                             child: Text("${document['itemPrice'].toString()} EG",
                             style: TextStyle(fontSize: 16),),
                           ),
                           IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.green,),
                         onPressed: (){
                           Firestore.instance.collection('cart').document(document.documentID).updateData(
                             {"added": true,}
                           );
                           total+=document['itemPrice'];
                           print('total is ${total} ');
                         },),
                       IconButton(icon: Icon(Icons.delete,color: Colors.red,),
                         onPressed: (){
                           Firestore.instance.collection('cart').document(document.documentID).delete();
                         },),

                         ],

                       ),
                     ),
                   ),
                    ],
                  ),
                );
              }).toList(),  
            );
        }
      }
      },
      
    );
    
  }
}
