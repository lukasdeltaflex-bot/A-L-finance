import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:al_finance/core/theme/app_colors.dart';

class FinancialTimeline extends StatelessWidget {
  const FinancialTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Timeline Futura',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildTimelineCard('Amanhã', 'Aluguel', r'- R$ 3.200', AppColors.accent, LucideIcons.home),
              _buildTimelineCard('15 Mai', 'Nubank', r'- R$ 1.850', AppColors.warning, LucideIcons.creditCard),
              _buildTimelineCard('18 Mai', 'Salário', r'+ R$ 12.500', AppColors.success, LucideIcons.arrowDownLeft),
              _buildTimelineCard('20 Mai', 'Internet', r'- R$ 120', AppColors.primary, LucideIcons.wifi),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineCard(String date, String title, String amount, Color color, IconData icon) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dividerDark.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: const TextStyle(color: AppColors.textMutedDark, fontSize: 11, fontWeight: FontWeight.bold)),
              Icon(icon, size: 14, color: color),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: AppColors.textDark, fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(
                amount,
                style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
