import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../../../shared/models/transaction.dart';
import '../../../../shared/models/financial_intelligence.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl();
});

final balanceSummaryProvider = FutureProvider<BalanceSummary>((ref) async {
  return ref.watch(dashboardRepositoryProvider).getBalanceSummary();
});

final recentTransactionsProvider = FutureProvider<List<Transaction>>((ref) async {
  return ref.watch(dashboardRepositoryProvider).getRecentTransactions();
});

final financialHealthProvider = FutureProvider<FinancialHealth>((ref) async {
  return ref.watch(dashboardRepositoryProvider).getFinancialHealth();
});
