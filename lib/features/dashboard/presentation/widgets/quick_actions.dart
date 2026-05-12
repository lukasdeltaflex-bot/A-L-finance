import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:al_finance/core/theme/app_colors.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ações Rápidas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAction(context, 'Pix', LucideIcons.send, AppColors.primary),
            _buildAction(context, 'Pagar', LucideIcons.qrCode, AppColors.secondary),
            _buildAction(context, 'Cartões', LucideIcons.creditCard, AppColors.warning),
            _buildAction(context, 'Metas', LucideIcons.target, AppColors.accent),
          ],
        ),
      ],
    );
  }

  Widget _buildAction(BuildContext context, String label, IconData icon, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Action logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ação: $label')),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDarkLighter : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? AppColors.dividerDark : AppColors.divider,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: color, size: 28),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          ),
        ),
      ],
    );
  }
}
