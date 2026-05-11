import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:al_finance/core/theme/app_colors.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTransaction(
          context,
          'Mercado Livre',
          'Cartão Nubank •••• 1234',
          r'- R$ 159,90',
          LucideIcons.shoppingBag,
          Colors.orange,
          0,
        ),
        _buildTransaction(
          context,
          'Salário Lukas',
          'Conta Corrente',
          r'+ R$ 12.500,00',
          LucideIcons.briefcase,
          AppColors.success,
          100,
        ),
        _buildTransaction(
          context,
          'Netflix',
          'Cartão Apple •••• 9999',
          r'- R$ 55,90',
          LucideIcons.monitorPlay,
          Colors.red,
          200,
        ),
        _buildTransaction(
          context,
          'Restaurante Madero',
          'Cartão XP •••• 4432',
          r'- R$ 240,00',
          LucideIcons.utensils,
          Colors.purple,
          300,
        ),
      ],
    );
  }

  Widget _buildTransaction(
    BuildContext context,
    String title,
    String subtitle,
    String amount,
    IconData icon,
    Color iconColor,
    int delay,
  ) {
    final theme = Theme.of(context);
    final isIncome = amount.startsWith('+');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.cardTheme.shape is RoundedRectangleBorder 
            ? (theme.cardTheme.shape as RoundedRectangleBorder).side.color 
            : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textMutedLight),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isIncome ? AppColors.success : null,
            ),
          ),
        ],
      ),
    ).animate().fade(delay: delay.ms).slideX(begin: 0.1, end: 0, delay: delay.ms);
  }
}
