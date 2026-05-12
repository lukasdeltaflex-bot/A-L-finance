import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:al_finance/core/theme/app_colors.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/recent_transactions.dart';
import '../widgets/financial_timeline.dart';
import '../widgets/health_score_card.dart';
import '../widgets/smart_insights_feed.dart';

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
            // Professional Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _buildUserAvatar('L', AppColors.primary),
                        const SizedBox(width: -8), // Overlapping avatars
                        _buildUserAvatar('A', AppColors.secondary),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Operação Família',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Visão Inteligente',
                              style: TextStyle(color: AppColors.textMutedDark, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildHeaderAction(LucideIcons.search),
                        const SizedBox(width: 8),
                        _buildHeaderAction(LucideIcons.bell),
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
                  const HealthScoreCard(),
                  const SizedBox(height: 32),
                  const QuickActions(),
                ]),
              ),
            ),

            const SliverToBoxAdapter(child: FinancialTimeline()),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            const SliverToBoxAdapter(child: SmartInsightsFeed()),
            
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32),
              sliver: SliverToBoxAdapter(
                child: const RecentTransactions(),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(LucideIcons.plus, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        color: AppColors.surfaceDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(LucideIcons.home, true),
            _buildNavItem(LucideIcons.barChart2, false),
            const SizedBox(width: 48), // Space for FAB
            _buildNavItem(LucideIcons.target, false),
            _buildNavItem(LucideIcons.users, false),
          ],
        ),
      ),
    );
  }

  Widget _buildUserAvatar(String initial, Color color) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.backgroundDark, width: 2),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
        ],
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildHeaderAction(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDarkLighter,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.dividerDark.withOpacity(0.5)),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: AppColors.textDark),
        onPressed: () {},
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive) {
    return IconButton(
      icon: Icon(
        icon,
        color: isActive ? AppColors.primary : AppColors.textMutedDark,
      ),
      onPressed: () {},
    );
  }
}
