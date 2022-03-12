
import 'package:etrade/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MyApp.dart';
import 'cart_provider.dart';

void main() {
  runApp(MyAp());
}

class MyAp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (BuildContext context){
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,

          home: MyHomePage(


          ),
        );
      }),

    );

  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
          title: const Text('E-Trade'),
          backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
  body: Center(
       child: Tooltip(message: 'My Home',
           child: FlatButton(
             onPressed: () {

             },
             child: Text(
               "Home Screen",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
             ),
           )  ),


  ),
      bottomNavigationBar: BottomNavigationBar(

          mouseCursor: SystemMouseCursors.grab,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.home

            ),
            label: 'Home',

          ),
          BottomNavigationBarItem(

            icon: Icon(Icons.menu),
            label: 'Menu',
            backgroundColor: Colors.white
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
              var route = MaterialPageRoute(
                  builder: (BuildContext context) =>  MyApp());
              Navigator.of(context).push(route);
            }
            if (_selectedIndex == 2) {
              var route = MaterialPageRoute(
                  builder: (BuildContext context) =>  ProductListScreen());
              Navigator.of(context).push(route);
            }

              }
              )
    );





    
  }


}




