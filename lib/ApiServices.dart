import 'package:dio/dio.dart';
import 'package:productsapp/model/Products.dart';
import 'package:productsapp/model/productModel.dart';


class ApiServices {
final Dio dio = Dio();
static const String baseUrl="https://dummyjson.com";
Future<Products>getProduct()async{
  final response= await dio.get("$baseUrl/products",
    queryParameters: {"limit": 0},

  );
  return Products.fromJson(response.data);
}
Future<ProductsModel>getProductByid(int id)async{
  final response=await dio.get("$baseUrl/products/$id");
  return ProductsModel.fromJson(response.data);

}
Future<Products>searchProduct(String query)async{
  final response =await dio.get("$baseUrl/products/search",
  queryParameters: {"q":query,"limit":0},

  );
  return Products.fromJson(response.data);
}
Future<List<ProductsModel>>getByCategory(String slug)async{
  final response =await dio.get("$baseUrl/products/category/$slug");
  return Products.fromJson(response.data).products?? [];
}
Future<List<ProductsModel>> getByCategories(List<String> slugs) async {
  final results = await Future.wait(slugs.map(getByCategory));
  return results.expand((list) => list).toList();
}
}