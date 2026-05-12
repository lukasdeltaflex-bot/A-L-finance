import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:al_finance/core/theme/app_colors.dart';
import 'package:al_finance/core/services/export_service.dart';
import 'package:al_finance/shared/widgets/filter_chip_bar.dart';
import 'package:al_finance/shared/widgets/filter_bottom_sheet.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/recent_transactions.dart';
import '../widgets/financial_timeline.dart';
import '../widgets/health_score_card.dart';
import '../widgets/smart_insights_feed.dart';
import '../../auth/presentation/providers/auth_provider.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  String _selectedPeriod = 'Este Mês';
  final _exportService = ExportService();

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SafeArea(
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
                        const SizedBox(width: -8),
                        _buildUserAvatar('A', AppColors.secondary),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Operação Família',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Text('Visão Inteligente', style: TextStyle(color: AppColors.textMutedDark, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildHeaderAction(LucideIcons.sliders, _showFilters),
                        const SizedBox(width: 8),
                        _buildHeaderAction(LucideIcons.logOut, () => ref.read(authServiceProvider).signOut()),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Period Filter Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: FilterChipBar(
                  filters: const ['Hoje', 'Esta Semana', 'Este Mês', 'Últimos 90 dias', '2024'],
                  selectedFilter: _selectedPeriod,
                  onFilterSelected: (val) => setState(() => _selectedPeriod = val),
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
                  _buildExportSection(),
                  const SizedBox(height: 32),
                  const QuickActions(),
                ]),
              ),
            ),

            const SliverToBoxAdapter(child: FinancialTimeline()),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            const SliverToBoxAdapter(child: SmartInsightsFeed()),
            
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 32),
              sliver: SliverToBoxAdapter(child: RecentTransactions()),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    ),
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
            const SizedBox(width: 48),
            _buildNavItem(LucideIcons.target, false),
            _buildNavItem(LucideIcons.users, false),
          ],
        ),
      ),
    );
  }

  Widget _buildExportSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Relatórios e Exportação', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildExportButton('PDF Premium', LucideIcons.fileText, AppColors.primary, () => _exportService.exportTransactionsToPdf([])),
            const SizedBox(width: 12),
            _buildExportButton('Excel Planilha', LucideIcons.fileSpreadsheet, AppColors.secondary, () => _exportService.exportTransactionsToExcel([])),
          ],
        ),
      ],
    );
  }

  Widget _buildExportButton(String label, IconData icon, Color color, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDarkLighter : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.dividerDark.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
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
      ),
      child: Center(
        child: Text(initial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
      ),
    );
  }

  Widget _buildHeaderAction(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDarkLighter,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.dividerDark.withOpacity(0.5)),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: AppColors.textDark),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive) {
    return IconButton(
      icon: Icon(icon, color: isActive ? AppColors.primary : AppColors.textMutedDark),
      onPressed: () {},
    );
  }
}
