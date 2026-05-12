import '../../../../shared/models/transaction.dart';
import '../../../../shared/models/financial_intelligence.dart';

abstract class DashboardRepository {
  Future<BalanceSummary> getBalanceSummary();
  Future<List<Transaction>> getRecentTransactions();
  Future<FinancialHealth> getFinancialHealth();
}
