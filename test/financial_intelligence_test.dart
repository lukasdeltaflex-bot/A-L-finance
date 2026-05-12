import 'package:flutter_test/flutter_test.dart';
import 'package:al_finance/shared/models/financial_intelligence.dart';

void main() {
  group('BalanceSummary Tests', () {
    test('calculate free balance correctly', () {
      final summary = BalanceSummary(
        totalBalance: 8000,
        committedBalance: 6400,
        recurringExpenses: 3000,
        upcomingBills: 2000,
        creditCardBills: 1400,
      );

      expect(summary.freeBalance, 1600);
    });

    test('calculate committed percentage correctly', () {
      final summary = BalanceSummary(
        totalBalance: 10000,
        committedBalance: 5000,
        recurringExpenses: 0,
        upcomingBills: 0,
        creditCardBills: 0,
      );

      expect(summary.committedPercentage, 0.5);
    });
  });
}
