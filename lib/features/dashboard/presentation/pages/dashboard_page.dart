import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
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
    
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 80,
              floating: true,
              pinned: true,
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primary.withOpacity(0.2),
                    child: const Text('AL', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Olá, Casal', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      Text('Bem-vindo de volta', style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textMutedLight)),
                    ],
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(LucideIcons.bell),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(LucideIcons.settings),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
              ],
            ).animate().fade().slideY(begin: -0.2, end: 0, duration: 500.ms, curve: Curves.easeOutCubic),
            
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  const BalanceCard(),
                  const SizedBox(height: 24),
                  const QuickActions(),
                  const SizedBox(height: 32),
                  Text('Gastos Recentes', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 16),
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
        backgroundColor: AppColors.primary,
        elevation: 4,
        child: const Icon(LucideIcons.plus, color: Colors.white),
      ).animate().scale(delay: 600.ms, duration: 400.ms, curve: Curves.easeOutBack),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: theme.colorScheme.surface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(LucideIcons.home, color: AppColors.primary), onPressed: () {}),
            IconButton(icon: const Icon(LucideIcons.creditCard), onPressed: () {}),
            const SizedBox(width: 48), // Space for FAB
            IconButton(icon: const Icon(LucideIcons.pieChart), onPressed: () {}),
            IconButton(icon: const Icon(LucideIcons.user), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
