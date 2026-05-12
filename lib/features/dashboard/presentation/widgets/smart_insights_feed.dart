import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:al_finance/core/theme/app_colors.dart';

class SmartInsightsFeed extends StatelessWidget {
  const SmartInsightsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Insights da Família',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            _buildInsightItem(
              'Economia Detectada',
              'Vocês gastaram 12% a menos com Delivery esta semana. Parabéns!',
              LucideIcons.trendingDown,
              AppColors.secondary,
            ),
            _buildInsightItem(
              'Alerta de Orçamento',
              'A fatura do Nubank está 18% acima da média. Cuidado com o saldo real livre.',
              LucideIcons.alertTriangle,
              AppColors.warning,
            ),
            _buildInsightItem(
              'Meta Próxima',
              'Faltam apenas R\$ 450 para completarem a meta da Viagem de Férias!',
              LucideIcons.target,
              AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInsightItem(String title, String message, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dividerDark.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: AppColors.textDark, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(color: AppColors.textMutedDark.withOpacity(0.8), fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
