import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productsapp/cartItem.dart';
import 'package:productsapp/cartScreen.dart';
import 'package:productsapp/productDetailScreen.dart';
import 'package:productsapp/productModel.dart';
import 'package:productsapp/products_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  String searchQuery = '';
  List<ProductsModel>products = [];


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen()));
          }, icon: Badge(
            label: Text('${context.watch<CartProvider>().totalItems}'),
            child: Icon(Icons.shopping_cart),
          ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() => searchQuery = value);
                context.read<ProductsCubit>().searchProduct(value);
              },
              decoration: InputDecoration(
                hintText: "Search Product",
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: searchQuery.isNotEmpty ?
                  IconButton(
                    onPressed: () {
                      searchController.clear();
                      setState(()=>searchQuery='');
                      context.read<ProductsCubit>().searchProduct('');
                    },
                    icon: Icon(Icons.clear),
                  ) : null
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if (state is ProductsError) {
                    return Center(child: Text(state.message),);
                  }
                  if (state is ProductsSuccess) {
                    if (state.products.isEmpty) {
                      return Center(child: Text("No Product Found"),);
                    }
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetailScreen(products: product)));
                          },
                          child: Card(
                            margin: EdgeInsetsGeometry.symmetric(
                              vertical: 6,
                              horizontal: 6,
                            ),
                            child: ListTile(
                              leading: Image.network(product.thumbnail ?? '',
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,),
                              title: Text(product.title ?? "No Title"),
                              subtitle: Text("\$${product.price}"),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return SizedBox.shrink();
                }
              )
            )
          ],
        ),
      ),
    );
  }
}
