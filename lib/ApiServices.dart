import 'package:dio/dio.dart';
import 'package:productsapp/Products.dart';
import 'package:productsapp/productModel.dart';


class ApiServices {
final Dio dio = Dio();
static const String baseUrl="https://dummyjson.com";
Future<Products>getProduct()async{
  final response= await dio.get("$baseUrl/products");
  return Products.fromJson(response.data);
}
Future<ProductsModel>getProductByid(int id)async{
  final response=await dio.get("$baseUrl/products/$id");
  return ProductsModel.fromJson(response.data);

}
Future<Products>searchProduct(String query)async{
  final response =await dio.get("$baseUrl/products/search?q=$query");
  return Products.fromJson(response.data);
}
}