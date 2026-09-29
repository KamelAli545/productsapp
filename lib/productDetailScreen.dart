import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productsapp/cartItem.dart';
import 'package:productsapp/cartScreen.dart';
import 'package:productsapp/homeScreen.dart';
import 'package:productsapp/productModel.dart';

class ProductDetailScreen extends StatefulWidget{
  final ProductsModel products;
  const ProductDetailScreen({super.key, required this.products});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isSelecting=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isSelecting?
      null:
      FloatingActionButton.extended(
        onPressed:()async{
          context.read<CartProvider>().addToCart(widget.products);
          Navigator.pop(context);
        },
        backgroundColor: Color(0xFF1B2333),
        foregroundColor: Colors.white,
        icon: Icon(Icons.add),
        label: Text("Add to Cart "),
      ),
      appBar: AppBar(
        title: Text(widget.products.title??"Product"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(widget.products.thumbnail??"",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(widget.products.title??"No Product Found",
                  style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold),),
                SizedBox(height: 8,),
                Text("\$${widget.products.price??0}"
                  ,
                  style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold),),
                SizedBox(height: 8,),
                Text(widget.products.description??"")
              ],
            ),

          ),

        ),
      ),
    );
  }
}

