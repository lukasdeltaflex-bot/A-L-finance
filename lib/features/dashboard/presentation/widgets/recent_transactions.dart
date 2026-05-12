import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:al_finance/core/theme/app_colors.dart';
import 'package:intl/intl.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Transações Recentes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Ver tudo'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildTransactionItem(
          context,
          'Mercado Livre',
          'Compra parcelada • 1/10',
          -159.90,
          LucideIcons.shoppingBag,
          Colors.orange,
        ),
        _buildTransactionItem(
          context,
          'Salário Lukas',
          'Depósito recebido',
          12500.00,
          LucideIcons.briefcase,
          AppColors.success,
        ),
        _buildTransactionItem(
          context,
          'Netflix',
          'Assinatura mensal',
          -55.90,
          LucideIcons.monitorPlay,
          Colors.red,
        ),
        _buildTransactionItem(
          context,
          'Restaurante Madero',
          'Alimentação',
          -240.00,
          LucideIcons.utensils,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    String title,
    String subtitle,
    double amount,
    IconData icon,
    Color iconColor,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isIncome = amount > 0;
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.divider,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  (isIncome ? '+ ' : '- ') + currencyFormat.format(amount.abs()),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: isIncome ? AppColors.success : (isDark ? AppColors.textDark : AppColors.textLight),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
