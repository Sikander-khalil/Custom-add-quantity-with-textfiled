
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MyApp.dart';
import 'cart_model.dart';
import 'cart_provider.dart';
import 'dbHelper.dart';
import 'main.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Cart> pageCart=[];
   int selectedIndex=-1;
  int selectedId=-1;
  TextEditingController controller= TextEditingController();
  int _selectedIndex = 0;
  String name ='';

  static List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach',
    'Mixed Fruit Basket',
  ];
   late final  cart;

  @override
  void initState(){
    super.initState();
    controller=TextEditingController();
   var cart  = Provider.of<CartProvider>(context,listen:
   false).cart;
    pageCart = cart;
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart  = Provider.of<CartProvider>(context);
    return Scaffold(

      appBar: AppBar(
        title: Text('Shopping Cart'),
        centerTitle: true,
        actions: [
          Center(
            child: Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value , child){
                  return Text(value.getCounter().toString(),style: TextStyle(color: Colors.white));
                },

              ),
              animationDuration: Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              child: Icon(Icons.shopping_bag_outlined),
            ),
          ),
          SizedBox(width: 20.0)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
                future:cart.getData() ,
                builder: (context , AsyncSnapshot<List<Cart>> snapshot){
                  if(snapshot.hasData){

                    if(snapshot.data!.isEmpty){
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [

                            SizedBox(height: 20,),
                            Text('Your cart is empty 😌' ,style: Theme.of(context).textTheme.headline5),
                            SizedBox(height: 20,),
                            Text('Explore products and shop your\nfavourite items' , textAlign: TextAlign.center ,style: Theme.of(context).textTheme.subtitle2)

                          ],
                        ),
                      );
                      // where is yoursubmit functio
                    }else {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: pageCart.length,
                            itemBuilder: (context, index){
                              return Card(
                                color: Colors.red,
                                shape: RoundedRectangleBorder(

                                  borderRadius: BorderRadius.circular(15.0),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(

                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [

                                            /*Image(
                                              height: 100,
                                              width: 100,
                                              image: NetworkImage(snapshot.data![index].image.toString()),
                                            ),*/
                                            SizedBox(width: 10,),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Row(

                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(pageCart[index].productName.toString() ,
                                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                      ),
                                                      Row(
                                                        children: [

                                                          Text("${pageCart[index].quantity}"),
                                                          const SizedBox(width: 12,),
                                                          InkWell(
                                                              onTap: (){
                                                                dbHelper!.delete(pageCart[index].id!);
                                                                // cart.removerCounter();
                                                                cart.removeTotalPrice(double.parse(pageCart[index].productPrice.toString()));
                                                              },
                                                              child: Text("Remove", style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),)),
                                                        ],

                                                      )
                                                    ],
                                                  ),

                                                  SizedBox(height: 5,),
                                                  Text(

                                                    pageCart[index].unitTag.toString() +" "+r"Rs"+" " + pageCart[index].productPrice.toString() ,
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Align(
                                                      alignment: Alignment.centerRight,
                                                      child: InkWell(
                                                          onTap: () {

                                                          setState(() {
                                                            selectedIndex = index;
                                                          });
                                                          },
                                                          child:Container(
                                                            height: 35,
                                                            width: 100,

                                                            /*decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius: BorderRadius.circular(5)

                                                        ),*/
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .all(4.0),
                                                              child: Row(
                                                                children: [

                                                                  Expanded(
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceBetween,
                                                                      children: [

                                                                        ElevatedButton(
                                                                          onPressed: () async {
                                                                            selectedId = pageCart[index].id!;
                                                                            final name = await openDialog();
                                                                            // you are storing quantiry in name ?yes
                                                                            // Thats the issue. you are not getting specific index of item being clikced
                                                                            // in, you need to store qnantity by getting index first h len ge?ow ??
                                                                            //
                                                                            if (name ==
                                                                                null ||
                                                                                name
                                                                                    .isEmpty)
                                                                              return ;
                                                                            setState(() {
                                                                              selectedIndex = index;
                                                                              this
                                                                                  .name =
                                                                                  name;

                                                                            });
                                                                          },
                                                                          child: Text(


                                                                              "Quantity"
                                                                          ),


                                                                        )




                                                                      ],

                                                                    ),
                                                                  ),


                                                                ],

                                                              ),
                                                            ),
                                                          )
                                                      )
                                                  )
                                                ],
                                              ),
                                            )

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );

                            }),
                      );
                    }

                  }
                  return Text("");
                }),
            Consumer<CartProvider>(builder: (context, value, child){
              return Visibility(

                visible: value.getTotalPrice().toStringAsFixed(2) == "0.00" ? false : true,
                child: Container(
                  color: Colors.black,
                  child: Column(

                    children: [
                      //  ReusableWidget(title: 'Sub Total', value: r'Rs'+value.getTotalPrice().toStringAsFixed(2),),
                      //    ReusableWidget(title: 'Discout 5%', value: r'Rs'+'20',),
                      ReusableWidget(title: 'Total', value: r'Rs'+value.getTotalPrice().toStringAsFixed(2),)
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ) ,
    );
  }

  Future<String?> openDialog()=> showDialog<String>

///whre  is list view list
    (context: context,
    builder: (context) => AlertDialog(
      title: Text(" Your Quantity"),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: "Eneter your quality"),
        keyboardType: TextInputType.number,
        controller: controller,

      ),
      actions: [
        TextButton(  child: Text("Submit"),
          onPressed: submit,

        )
      ],

    ),


  );

  // final cart  = Provider.of<CartProvider>(context);


  void submit()async {

    // pageCart = await cart._cart;
  setState(() {
    int? qty = 0;
    int index= pageCart.indexWhere((element) => element.id == selectedId);
    print(pageCart[index].quantity);
    qty= pageCart[index].quantity;
    print("quantity is first: $qty");
    pageCart[index].quantity= int.parse(controller.text);
    print("quantity is: ${pageCart[index].quantity}");
pageCart.asMap().forEach((key, value) {

  print(value.quantity);

});
    // [index];
  });
    print("last submitted");
    Navigator.of(context).pop();
  }
}


class ReusableWidget extends StatelessWidget {
  final String title , value ;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title , style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
          Text(value.toString() , style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}