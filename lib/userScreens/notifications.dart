import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class notifications extends StatefulWidget {
  var currentId;
  

  @override
  _notificationsState createState() => _notificationsState();
  //notifications({this.currentId});
}

class _notificationsState extends State<notifications> {
  var total=0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("notifications "),

        centerTitle: false,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> order(total: total,currentId: widget.currentId)));
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
      stream: Firestore.instance.collection('notification').snapshots(),
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
                             
                             child: Text("${document['username']} make an order with price = ${document['total'].toString()}",
                             overflow: TextOverflow.ellipsis,
                             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                           ),
                           
                       IconButton(icon: Icon(Icons.delete,color: Colors.red,),
                         onPressed: (){
                           Firestore.instance.collection('notification').document(document.documentID).delete();
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
