import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productsapp/model/cartItem.dart';
import 'package:productsapp/productTab.dart';
import 'package:productsapp/screens/cartScreen.dart';
import 'package:productsapp/screens/productDetailScreen.dart';
import 'package:productsapp/model/productModel.dart';
import 'package:productsapp/cubit/products_cubit.dart';
import 'package:productsapp/widgets/categoryRow.dart';
import 'package:productsapp/widgets/productCard.dart';
import 'package:productsapp/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  String searchQuery = '';
  int _selectedTab=0;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  void _selectTab(int index) {
    searchController.clear();
    setState(() {
      _selectedTab = index;
      searchQuery = '';
    });
    context.read<ProductsCubit>().loadProducts(productTabs[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Center(
            child: Text("Stylish",
            style: TextStyle(
              fontSize:18,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(248, 55, 88, 1)
            ),
            )),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen()));
          }, icon: Badge(
            label: Text('${context.watch<CartProvider>().totalItems}'),
            child: Icon(Icons.shopping_cart),
          )),
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
                border: OutlineInputBorder(
                  borderRadius: 
                    BorderRadius.all(Radius.circular(15))
                ),
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
           SizedBox(height: 12,),
            CategoryRow(selected: _selectedTab, onTap: _selectTab),
            SizedBox(height: 8,),
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ProductsError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is ProductsSuccess) {
                    if (state.products.isEmpty) {
                      return const Center(child: Text('No Product Found'));
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      itemCount: state.products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.62,
                      ),
                      itemBuilder: (context, index) {
                        final p = state.products[index];
                        final price = p.price ?? 0;
                        final discount = p.discountPercentage ?? 0;
                        return ProductCard(
                          imageUrl: p.thumbnail ?? '',
                          title: p.title ?? 'No title',
                          description: p.description ?? '',
                          price: price,
                          rating: p.rating ?? 0,
                          oldPrice: discount > 0 ? price / (1 - discount / 100) : null,
                          discountLabel: discount > 0 ? '${discount.round()}%Off' : null,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(products: p),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
