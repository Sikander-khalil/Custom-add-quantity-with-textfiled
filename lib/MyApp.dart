import 'package:etrade/product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sql_conn/sql_conn.dart';


import 'main.dart';


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Container(

              margin: EdgeInsets.only(right: 100),

              child: Text('Menu',style: TextStyle(color: Colors.black),),

            )
        ),
        body: Center(
          child: IconCard(
            title: Text("Fetch Data", style: TextStyle(color: Colors.white, fontSize: 25)),
            icon: Icon(
              Icons.arrow_forward,
              size: 40,
            ),
            color: Colors.red, textColor: Colors.red,
          ),

        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.black
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Menu',
                  backgroundColor: Colors.black
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: 'Payment',
              ),

            ],


            currentIndex: _selectedIndex,

            iconSize: 30,
            onTap: (int index) {

              setState(() => _selectedIndex = index);
              if (_selectedIndex == 1) {

                Navigator.pop(context);
              }
              if (_selectedIndex == 0) {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MyHomePage()),
                );
              }
              if (_selectedIndex == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ProductListScreen()),
                );

              }
            }
        )
    );

  }

}

class IconCard extends StatefulWidget {
  IconCard(
      {Key ? key, required this.title,  required this.icon, required this.color, required this.textColor})
      : super(key: key);

  final Text title;

  final Icon icon;
  final Color color;
  final Color textColor;

  @override
  State<IconCard> createState() => BeautifulCardState();
}

class BeautifulCardState extends State<IconCard> {
  Future<void> connect(BuildContext ctx) async {
    debugPrint("Connecting...");
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("LOADING"),
            content: CircularProgressIndicator(),
          );
        },
      );
      await SqlConn.connect(
          ip: "192.168.10.8",
          port: "49170",
          databaseName: "eTrade_GKS",
          username: "sa",
          password: "exapp");
      debugPrint("Connected!");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      Navigator.pop(context);
    }
  }

  Future<void> read(String query) async {
    var res = await SqlConn.readData(query);
    debugPrint(res.toString());
  }


  Future<void> write(String query) async {
    debugPrint(" in write!");
    debugPrint(query);
    var res = await SqlConn.writeData(query);
    debugPrint(" after write!");
    debugPrint(res.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Container(

        width: 400,
        height: 200,
        margin: EdgeInsets.only(bottom: 450),
        child: Card(

            margin: EdgeInsets.all(10),
            elevation: 30,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: widget.color,
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    connect(context);

                    read("SELECT i.ItemID, i.ItemName, i.ItemUrduName, i.TradePrice FROM Item AS i");


                  },
                ),
                Positioned(
                  top: 15,
                  left: 20,
                  right: 30,
                  child:
                  widget.title,
                ),

                Positioned(
                    bottom: 80,
                    left: 300,
                    child: Container(
                      width: 90,

                      child: Center(child: widget.icon),
                    )
                )
              ],
            )
        )
    );
  }



}