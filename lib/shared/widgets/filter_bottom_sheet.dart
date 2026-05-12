import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:al_finance/core/theme/app_colors.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(0, 10000);
  String _selectedCategory = 'Todas';
  final List<String> _categories = ['Todas', 'Alimentação', 'Moradia', 'Transporte', 'Lazer', 'Saúde'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Filtros Avançados', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(LucideIcons.x), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 24),
          
          const Text('Categoria', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: _categories.map((cat) => ChoiceChip(
              label: Text(cat),
              selected: _selectedCategory == cat,
              onSelected: (val) => setState(() => _selectedCategory = cat),
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(color: _selectedCategory == cat ? Colors.white : (isDark ? AppColors.textDark : AppColors.textLight)),
            )).toList(),
          ),
          
          const SizedBox(height: 32),
          const Text('Faixa de Valor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 10000,
            divisions: 20,
            activeColor: AppColors.primary,
            labels: RangeLabels('R\$ ${_priceRange.start.toInt()}', 'R\$ ${_priceRange.end.toInt()}'),
            onChanged: (val) => setState(() => _priceRange = val),
          ),
          
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Aplicar Filtros', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
