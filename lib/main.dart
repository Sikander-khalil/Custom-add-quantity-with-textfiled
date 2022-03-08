
import 'package:flutter/material.dart';

import 'MyApp.dart';

void main() {
  runApp(MyAp());
}

class MyAp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {



        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:  MyHomePage(),
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
      appBar: AppBar(
          title: const Text('E-Trade'),
          backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
  body: Center(
       child: Text('Home Page', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),


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
              var route = MaterialPageRoute(
                  builder: (BuildContext context) =>  MyApp());
              Navigator.of(context).push(route);
            }
            if (_selectedIndex == 2) {
              var route = MaterialPageRoute(
                  builder: (BuildContext context) =>  MyListview());
              Navigator.of(context).push(route);
            }
           
              }
              )
    );





    
  }


}

class MyListview extends StatelessWidget {
  List<String> course = [
    "c",
    "c++",
    "java",
    "kotlin",
    "objective c",
    "swift",
    "php"
  ];
 // List<IconData> icons = [Icons.person, Icons.home, Icons.notifications];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Courses"),
        ),
        body: Container(
            color: Colors.white10,
            padding: EdgeInsets.all(16.0),
            child: HomePage(course)
        ),
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  final List<String> course;

  HomePage(this.course);

  List<IconData> icons = [Icons.person, Icons.home, Icons.notifications,Icons.warning,Icons.arrow_forward,Icons.close,Icons.build];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: course.length,
      itemBuilder: (context, pos) {
        return Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Card(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child:  Row(
                  mainAxisSize: MainAxisSize.max,

                  children: [
                    Icon(icons[pos]),
                     Container(
                       margin: EdgeInsets.only(left: 50),
                       child: Text(course[pos], style: TextStyle(
                        fontSize: 18.0,
                        height: 1.6,
                    ),


                    ),
                     ),


                  ],
                ),

              ),

            )
        );
      },
    );
  }
}
