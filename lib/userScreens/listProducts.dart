import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gp_project/userScreens/notifications.dart';
import '../userScreens/itemdetails.dart';
import '../userScreens/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AllProudct extends StatefulWidget {
  var currentId;
  var currentName;
  @override
  _Allproductstate createState() => _Allproductstate();
  AllProudct({this.currentId, this.currentName});
}

class _Allproductstate extends State<AllProudct> {
  // final db = Firestore.instance;
  // FirebaseUser currentUser;
   
  

  @override
  Widget build(BuildContext context) {
    print("from file");
                            print(widget.currentId);
    return Scaffold(
      appBar: AppBar(
        title: Text(' My Proudct'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> myCart(currentId: widget.currentId, currentName:widget.currentName)));
              }),
              new IconButton(
              icon: new Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> notifications()));
              }),
        ]    
      ),
      body: _draw(),
      
    );
  }
  Widget _draw(){
    Color cartColor;

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return Card(
                  child: new Column(
                    children: <Widget>[
                  Container(
                    child: ListTile(
                      
                    title: new Text(document['title'],style: TextStyle(color: Colors.indigo,fontSize: 20)),
                    subtitle: new Text(document['description'],style: TextStyle(color: Colors.black87,fontSize: 15)),
                    ),
                  ),
                   Container(
                    height: 140.0,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(document['image']),
                    fit: BoxFit.fitHeight),
                borderRadius: new BorderRadius.only(
                  bottomRight: new Radius.circular(120.0),
                  bottomLeft: new Radius.circular(120.0),
                )),
                   ) ,
                   Container(
                     //color: Colors.lime,
                     child: Center(

                       child: Row(

                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Container(
                             color: Colors.green,
                             width: 120,
                             child: Padding(
                               
                               padding: const EdgeInsets.all(16.0),
                               child: Text("${document['price'].toString()} EG",
                               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),),
                             ),
                           ),

                         IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.green,),
                         onPressed: (){
                            Firestore.instance.collection('cart')..add(
                              {
                                "userId":widget.currentId,
                                "username": widget.currentName,
                                "itemTitle": document['title'],
                                "itemPrice": document['price'],
                                "added": false,
                              }
                            );
                         },),
                          FlatButton(child: Text("more details.."),
                            onPressed:(){
                              Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => new ItemDetail(
                                itemImage: document['image'],
                                itemName: document['title'],
                                itemDescription: document['description'],
                                itemPrice: document['price'],
                                
                              )));
                            },
                            color: Colors.white,
                            
                            textColor: Colors.blue,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            splashColor: Colors.grey,
                          ),
                         
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
      },
      
    );
    
  }
}