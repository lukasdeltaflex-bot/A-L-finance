import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:al_finance/core/theme/app_colors.dart';
import '../providers/dashboard_providers.dart';

class HealthScoreCard extends ConsumerWidget {
  const HealthScoreCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthAsync = ref.watch(financialHealthProvider);

    return healthAsync.when(
      loading: () => const SizedBox(height: 150, child: Center(child: CircularProgressIndicator())),
      error: (err, stack) => const Text('Erro ao carregar saúde financeira'),
      data: (health) => Container(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Saúde Financeira', style: TextStyle(color: AppColors.textDark, fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text('Baseado nos últimos 30 dias', style: TextStyle(color: AppColors.textMutedDark, fontSize: 12)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    health.status,
                    style: const TextStyle(color: AppColors.secondary, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: health.score / 100,
                        strokeWidth: 8,
                        backgroundColor: Colors.white.withOpacity(0.05),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondary),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      children: [
                        Text('${health.score}', style: const TextStyle(color: AppColors.textDark, fontSize: 24, fontWeight: FontWeight.bold)),
                        const Text('/100', style: TextStyle(color: AppColors.textMutedDark, fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    children: health.indicators.map((indicator) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildHealthIndicator(
                        indicator.label, 
                        indicator.value, 
                        indicator.value > 0.7 ? AppColors.secondary : (indicator.value > 0.4 ? AppColors.warning : AppColors.error)
                      ),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
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
