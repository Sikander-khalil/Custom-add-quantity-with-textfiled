import 'package:badges/badges.dart';
import 'package:etrade/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:provider/provider.dart';

import 'MyApp.dart';
import 'cart_model.dart';
import 'cart_provider.dart';
import 'cart_screen.dart';
import 'dbHelper.dart';
class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Flutter Apply Search on ListView')
        ),
        body: Center(
            child: ProductListScreen()
        )

    );


  }
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {


  TextEditingController _textController = TextEditingController();

  int _selectedIndex = 0;

  static List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach',
    'Mixed Fruit Basket',
  ];
  // List<String> newDataList = List.from(productName);
  /*onItemChanged(String value) {
    setState(() {
      newDataList = productName
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }*/
  List<String> newDataList = List.from(productName);

  onItemChanged(String value) {
    setState(() {
      newDataList = productName
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
  List<String> productUnit = ['KG', 'Dozen', 'KG', 'Dozen', 'KG', 'KG', 'KG',];

  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];


/*  List<String> productImage = [
    'https://image.shutterstock.com/image-photo/mango-isolated-on-white-background-600w-610892249.jpg' ,
    'https://image.shutterstock.com/image-photo/orange-fruit-slices-leaves-isolated-600w-1386912362.jpg' ,
    'https://image.shutterstock.com/image-photo/green-grape-leaves-isolated-on-600w-533487490.jpg' ,
    'https://media.istockphoto.com/photos/banana-picture-id1184345169?s=612x612' ,
   'https://media.istockphoto.com/photos/cherry-trio-with-stem-and-leaf-picture-id157428769?s=612x612' ,
    'https://media.istockphoto.com/photos/single-whole-peach-fruit-with-leaf-and-slice-isolated-on-white-picture-id1151868959?s=612x612' ,
    'https://media.istockphoto.com/photos/fruit-background-picture-id529664572?s=612x612' ,
  ] ;*/

  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(

          centerTitle: true,

          actions: [

            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              child: Center(
                child: Badge(
                  showBadge: true,
                  badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return Text(value.getCounter().toString(),
                          style: TextStyle(color: Colors.white));
                    },
                  ),
                  animationType: BadgeAnimationType.fade,
                  animationDuration: Duration(milliseconds: 300),
                  child: Icon(Icons.shopping_bag_outlined),
                ),
              ),
            ),

            SizedBox(width: 20.0)
          ],
        ),
        body: Column(
            children: [
              TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Search Here...',

                    ),
                    onChanged: onItemChanged,
                  ),







              Expanded(
                /* child: ListView(
                    padding: EdgeInsets.all(12.0),
                    children: newDataList.map((data) {
                      return ListTile(
                        title: Text(data),
                        onTap: ()=> print(data),);
                    }).toList(),
                  ),*/
                child: ListView.builder(
                    itemCount: newDataList.length,

                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  /*  Image(
                                      height: 100,
                                      width: 100,
                                      image: NetworkImage(productImage[index].toString()),
                                    ),*/
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(newDataList[index].toString(),
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(productUnit[index].toString() + " " +
                                            r"Rs" + " " +
                                            productPrice[index].toString(),
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 5,),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              print(index);
                                              print(index);
                                              print(
                                                  newDataList[index].toString());
                                              print(
                                                  productPrice[index].toString());
                                              print(productPrice[index]);
                                              print('1');
                                              print(
                                                  productUnit[index].toString());
                                              // print(productImage[index].toString());

                                              dbHelper!.insert(
                                                Cart(
                                                    id: index,
                                                    productId: index.toString(),
                                                    productName: newDataList[index]
                                                        .toString(),
                                                    initialPrice: productPrice[index],
                                                    productPrice: productPrice[index],
                                                    quantity: 1,
                                                    unitTag: productUnit[index]
                                                        .toString()),
                                                //  image: productImage[index].toString())
                                              ).then((value) {
                                                cart.addTotalPrice(double.parse(
                                                    productPrice[index]
                                                        .toString()));
                                                cart.addCounter();

                                                final snackBar = SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                      'Product is added to cart'),
                                                  duration: Duration(
                                                      seconds: 1),);

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }).onError((error, stackTrace) {
                                                print("error" + error.toString());
                                                final snackBar = SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        'Product is already added in cart'),
                                                    duration: Duration(
                                                        seconds: 1));

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              });
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius
                                                      .circular(50)
                                              ),
                                              child: const Center(
                                                child: Text('Add to cart',
                                                  style: TextStyle(
                                                      color: Colors.white),),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )

                                ],
                              )
                            ],
                          ),
                        ),
                      );

                    }),
              ),
            ]),






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
                    builder: (BuildContext context) => MyApp());
                Navigator.of(context).push(route);
              }
              if (_selectedIndex == 2) {
                var route = MaterialPageRoute(
                    builder: (BuildContext context) => ProductListScreen());
                Navigator.of(context).push(route);
              }
            }
        )

    );
  }
}