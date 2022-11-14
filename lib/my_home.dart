
import 'package:flutter/material.dart';
class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://st3.depositphotos.com/1037987/15097/i/450/depositphotos_150975580-stock-photo-portrait-of-businesswoman-in-office.jpg"
                ),
              ),
              Column(
                children:<Widget> [
                  Text("Good morning"),
                  Text("abhipsa")
                ],
              )
            ],
          ),
          Text("Resturents"),
          Container(
            height: 100,
            child: ListView(
    scrollDirection: Axis.horizontal,
    children: <Widget>[
    Container(
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(40),
    color: Colors.purple[600],
    ),
    width: 150,

    child: const Center(child: Text('Item 1', style: TextStyle(fontSize: 18, color: Colors.white),)),
    ),
    Container(
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(40),
    color: Colors.purple[600],
    ),
    width: 150,
    child: const Center(child: Text('Item 2', style: TextStyle(fontSize: 18, color: Colors.white),)),
    ),

    Container(
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(40),
    color: Colors.purple[600],
    ),
    width: 150,
    child: const Center(child: Text('Item 4', style: TextStyle(fontSize: 18, color: Colors.white),)),
            ),

        ],
      )
    ),
//ListView.builder(itemBuilder: itemBuilder)
    ]
    ),

    );
  }
}
