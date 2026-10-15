class ProductTab {
  final String title;

  /// DummyJSON category slugs shown in this tab. null = all products.
  final List<String>? slugs;

  /// Asset path for the circle image. null = use a fallback icon.
  final String? imageAsset;

  const ProductTab(this.title, [this.slugs, this.imageAsset]);
}

const List<ProductTab> productTabs = [
  ProductTab('All', null, null),
  ProductTab('Beauty', ['beauty', 'skin-care', 'fragrances'],
      'assets/images/Beauty.png'),
  ProductTab('Fashion', [
    'womens-dresses',
    'tops',
    'mens-shirts',
    'mens-shoes',
    'womens-shoes',
    'sunglasses',
  ], 'assets/images/Fashion.png'),
  ProductTab('Food', ['groceries'], 'assets/images/Food.png'),
  ProductTab('Mens', [
    'mens-shirts',
    'mens-shoes',
    'mens-watches',
    'sunglasses',
  ], 'assets/images/mens.png'),
];