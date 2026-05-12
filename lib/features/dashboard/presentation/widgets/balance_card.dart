import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:al_finance/core/theme/app_colors.dart';
import 'package:intl/intl.dart';
import '../providers/dashboard_providers.dart';

class BalanceCard extends ConsumerStatefulWidget {
  const BalanceCard({super.key});

  @override
  ConsumerState<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends ConsumerState<BalanceCard> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    final balanceAsync = ref.watch(balanceSummaryProvider);
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return balanceAsync.when(
      loading: () => _buildLoadingState(),
      error: (err, stack) => _buildErrorState(),
      data: (balance) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.backgroundDark, Color(0xFF1E293B)],
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10)),
          ],
          border: Border.all(color: AppColors.dividerDark.withOpacity(0.5)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Saldo Real Livre', style: TextStyle(color: AppColors.textMutedDark, fontSize: 14, fontWeight: FontWeight.w600)),
                      IconButton(
                        onPressed: () => setState(() => _isVisible = !_isVisible),
                        icon: Icon(_isVisible ? LucideIcons.eye : LucideIcons.eyeOff, color: AppColors.textMutedDark, size: 20),
                      ),
                    ],
                  ),
                  Text(
                    _isVisible ? currencyFormat.format(balance.freeBalance) : '••••••••',
                    style: const TextStyle(color: AppColors.secondary, fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: -1),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(LucideIcons.info, color: AppColors.textMutedDark, size: 14),
                      const SizedBox(width: 6),
                      Text('Livre para uso após todas as contas pagas', style: TextStyle(color: AppColors.textMutedDark.withOpacity(0.7), fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.03), borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBalanceDetail('Total em Conta', currencyFormat.format(balance.totalBalance), LucideIcons.wallet),
                  Container(width: 1, height: 30, color: AppColors.dividerDark.withOpacity(0.3)),
                  _buildBalanceDetail('Comprometido', currencyFormat.format(balance.committedBalance), LucideIcons.lock, color: AppColors.accent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.surfaceDark, borderRadius: BorderRadius.circular(32)),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorState() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.error.withOpacity(0.1), borderRadius: BorderRadius.circular(32)),
      child: const Center(child: Text('Erro ao carregar saldo', style: TextStyle(color: AppColors.error))),
    );
  }

  Widget _buildBalanceDetail(String label, String value, IconData icon, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 12, color: AppColors.textMutedDark),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(color: AppColors.textMutedDark, fontSize: 11, fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 4),
        Text(_isVisible ? value : '••••', style: TextStyle(color: color ?? AppColors.textDark, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
