import 'package:flutter/material.dart';
import 'package:productsapp/productTab.dart';

const _accent = Color(0xFFE23B5B);
const _promoPink = Color(0xFFFCE4EA);

class CategoryRow extends StatelessWidget {
  const CategoryRow({
    super.key,
    required this.selected,
    required this.onTap,
  });

  final int selected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: productTabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, i) {
          final tab = productTabs[i];
          final isSelected = i == selected;

          return GestureDetector(
            onTap: () => onTap(i),
            child: Column(
              children: [
                CategoryAvatar(tab: tab, isSelected: isSelected),
                const SizedBox(height: 6),
                Text(
                  tab.title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CategoryAvatar extends StatelessWidget {
  const CategoryAvatar({
    super.key,
    required this.tab,
    required this.isSelected,
  });

  final ProductTab tab;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? _accent : Colors.transparent,
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: _promoPink,
        child: ClipOval(
          child: tab.imageAsset == null
              ? const Icon(Icons.apps, color: _accent)
              : Image.asset(
            tab.imageAsset!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.apps, color: _accent),
          ),
        ),
      ),
    );
  }
}