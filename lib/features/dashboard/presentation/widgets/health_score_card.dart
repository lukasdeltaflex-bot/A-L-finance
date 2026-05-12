import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:al_finance/core/theme/app_colors.dart';

class HealthScoreCard extends StatelessWidget {
  const HealthScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.dividerDark.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saúde Financeira',
                    style: TextStyle(color: AppColors.textDark, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Baseado nos últimos 30 dias',
                    style: TextStyle(color: AppColors.textMutedDark, fontSize: 12),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'ESTÁVEL',
                  style: TextStyle(color: AppColors.secondary, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              // Score Circle
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: 0.82,
                      strokeWidth: 8,
                      backgroundColor: Colors.white.withOpacity(0.05),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondary),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  const Column(
                    children: [
                      Text(
                        '82',
                        style: TextStyle(color: AppColors.textDark, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '/100',
                        style: TextStyle(color: AppColors.textMutedDark, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: [
                    _buildHealthIndicator('Reserva de Emergência', 0.65, AppColors.primary),
                    const SizedBox(height: 12),
                    _buildHealthIndicator('Controle de Dívidas', 0.90, AppColors.secondary),
                    const SizedBox(height: 12),
                    _buildHealthIndicator('Sobra Mensal', 0.45, AppColors.warning),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHealthIndicator(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: AppColors.textMutedDark, fontSize: 11)),
            Text('${(value * 100).toInt()}%', style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.white.withOpacity(0.05),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4,
          ),
        ),
      ],
    );
  }
}
