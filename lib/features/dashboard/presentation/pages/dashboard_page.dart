import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:al_finance/core/theme/app_colors.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/recent_transactions.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Custom Header instead of SliverAppBar for better control
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.primaryLight],
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: Text(
                              'AL',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Olá, Lukas & Aline',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Sua central financeira',
                              style: TextStyle(
                                color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildHeaderAction(LucideIcons.bell),
                        const SizedBox(width: 8),
                        _buildHeaderAction(LucideIcons.settings),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const BalanceCard(),
                  const SizedBox(height: 32),
                  const QuickActions(),
                  const SizedBox(height: 32),
                  const RecentTransactions(),
                  const SizedBox(height: 100), // Bottom padding
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(LucideIcons.plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(LucideIcons.home, 'Início', true),
            _buildNavItem(LucideIcons.creditCard, 'Cartões', false),
            const SizedBox(width: 48), // Space for FAB
            _buildNavItem(LucideIcons.pieChart, 'Relatórios', false),
            _buildNavItem(LucideIcons.user, 'Perfil', false),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderAction(IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDarkLighter : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: isDark ? AppColors.dividerDark : AppColors.divider),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: () {},
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.textMutedLight,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
