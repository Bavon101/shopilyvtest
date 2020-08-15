import 'package:flutter/material.dart';
import 'package:shopapp/pages/LoginPage.dart';
import 'package:shopapp/pages/productPage.dart';
class HomePage extends StatefulWidget {
  final UserDetails user;
  HomePage(this.user);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> widgetProducts = [];
  List<Product> products = [];
  getProducts(){
    Product product = new Product("https://images.unsplash.com/photo-1561047029-3000c68339ca?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60","Beverage Cup", "250",""
        "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. "
        "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', "
        "making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default "
        "model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over "
        "the years, sometimes by accident, sometimes on purpose");


    Product product1 = new Product("https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", "Coffee", "320","There are many variations of passages of Lorem "
        "Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly"
        " believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. "
        "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet.");


    Product product2 = new Product("https://images.unsplash.com/photo-1559898311-859a8e0edfe5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", 'Milk Coffee', '350', "Contrary to popular belief, Lorem Ipsum is not simply random text."
        " It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia,"
        " looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.");

    Product product3 = new Product('https://images.unsplash.com/photo-1544787219-7f47ccb76574?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60', 'White Mug', '150',"Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of (The Extremes of Good and Evil) by Cicero, written "
        "in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum,  comes from a line in section 1.10.32.");


    setState(() {
      products = [
        product,
        product1,
        product2,
        product3
      ];
    });
  }

  createWidgets(){
    for(int b = 0; b < products.length;b++){
      widgetProducts.add(
          Center(
            child: GestureDetector(
              onTap: (){
                Product productnew = new Product(products[b].image, products[b].name, products[b].price,products[b].descrption);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProduct(productnew)));
              },
              child: Container(
                height: 350,
                width: 300,
        decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
              children: [
                Container(
                  height: 160,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(products[b].image),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                Text(products[b].name),
                Text("Ksh.${products[b].price}"),
              ],
        ),
      ),
            ),
          ));
    }
  }
  createUi() async{
    getProducts();
    createWidgets();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createUi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.10,),
              Text("Coffee Products",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  fontSize: 25
                ),
              ),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children:widgetProducts,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
