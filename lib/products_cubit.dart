import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:productsapp/ApiServices.dart';
import 'package:productsapp/productModel.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  final ApiServices apiServices=ApiServices();
  Future<void> loadProducts() async{
    emit(ProductsLoading());
    try{
      final result=await apiServices.getProduct();
      emit(ProductsSuccess(result.products??[]));
    }catch(e)
    {
      emit(ProductsError(e.toString()));
    }
  }
  Future<void>searchProduct(String query) async{
    final text =query.trim();
    if(text.isEmpty){
      await loadProducts();
      return;
    } try{
      final reult=await apiServices.searchProduct(text);
      emit(ProductsSuccess(reult.products??[]));
    }catch(e){
      emit(ProductsError(e.toString()));
    }
  }
}
