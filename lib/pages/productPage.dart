import 'package:flutter/material.dart';
class ViewProduct extends StatefulWidget {
  final Product product;
  ViewProduct(this.product);
  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.05,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back,),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*.25,
                width: MediaQuery.of(context).size.width*.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: NetworkImage(widget.product.image),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Divider(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text("Item:"),
                  ),
                  Text(widget.product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text("Price:"),
                  ),
                  Text("Ksh.${widget.product.price}"),
                ],
              ),
              Divider(),
              Align(
                alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text("Description",
                      style: TextStyle(
                        decoration: TextDecoration.underline
                      ),
                    ),
                  )),
              Text(widget.product.descrption),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class Product{
  final String image;
  final String name;
  final String price;
  final String descrption;
  Product(this.image,this.name,this.price,this.descrption);
}