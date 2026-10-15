part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}
final class ProductsLoading extends ProductsState {
  final ProductTab tab;

  ProductsLoading({required this.tab});
}
final class ProductsSuccess extends ProductsState {
  final List<ProductsModel> products;
  final ProductTab tab;
  final String query;
  ProductsSuccess(this.products,{required this.tab,this.query=''});
}
final class ProductsError extends ProductsState {
  final String message;
  final ProductTab? tab;

  ProductsError(this.message, {this.tab});
}

