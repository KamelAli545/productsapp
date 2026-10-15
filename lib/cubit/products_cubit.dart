import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:productsapp/ApiServices.dart';
import 'package:productsapp/model/productModel.dart';
import 'package:productsapp/productTab.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  final ApiServices apiServices = ApiServices();
  ProductTab _currentTab = productTabs.first;
  String _currentQuery = '';
  int _requestId = 0;

  Future<void> loadProducts(ProductTab tab) async {
    _currentTab = tab;
    final id = ++_requestId;

    emit(ProductsLoading(tab: tab));
    try {
      final list = tab.slugs == null ?
      (await apiServices.getProduct()).products ?? []
          : await apiServices.getByCategories(tab.slugs!);
      if (id != _requestId) return;
      emit(ProductsSuccess(list, tab: tab));
    } catch (e) {
      if (id != _requestId) return;
      emit(ProductsError(e.toString(), tab: tab));
    }
  }

  Future<void> searchProduct(String query) async {
    final text = query.trim();
    _currentQuery = text;

    if (text.isEmpty) {
      await loadProducts(_currentTab);
      return;
    }
    final id = ++_requestId;
    emit(ProductsLoading(tab: _currentTab));
    try {
      final result = await apiServices.searchProduct(text);
      if (id != _requestId) return;
      final list = _currentTab.slugs == null
          ? result.products ?? []
          : (result.products ?? [])
          .where((p) => _currentTab.slugs!.contains(p.category))
          .toList();
      emit(ProductsSuccess(list, tab: _currentTab, query: text));
    } catch (e) {
      if (id != _requestId) return;
      emit(ProductsError(e.toString(), tab: _currentTab));
    }
  }
}
