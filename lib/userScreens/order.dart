import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../userScreens/listProducts.dart';


class order extends StatefulWidget {
  var total;
  var currentName;
  var currentId;
  @override
  _orderState createState() => _orderState();
  order({this.total, this.currentId, this.currentName});
}

class _orderState extends State<order> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Messages"),
        centerTitle: false,
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            new Text(
              "The total is ${widget.total}",
              style: new TextStyle(fontSize: 25.0),
            ),
            RaisedButton(child: Text("Submit"),
              onPressed:(){
                Firestore.instance.collection('notification').add(
                  {
                    "username":widget.currentName,
                    
                    "total":widget.total,
                  },
                

                );
         Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProudct(currentId: widget.currentId,)));

              },
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              splashColor: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
