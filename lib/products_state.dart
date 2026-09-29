part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}
final class ProductsLoading extends ProductsState {}
final class ProductsSuccess extends ProductsState {
  final List<ProductsModel> products;
ProductsSuccess(this.products);
}
final class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}

