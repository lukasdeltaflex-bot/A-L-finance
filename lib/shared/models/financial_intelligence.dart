class BalanceSummary {
  final double totalBalance;
  final double committedBalance;
  final double recurringExpenses;
  final double upcomingBills;
  final double creditCardBills;

  BalanceSummary({
    required this.totalBalance,
    required this.committedBalance,
    required this.recurringExpenses,
    required this.upcomingBills,
    required this.creditCardBills,
  });

  double get freeBalance => totalBalance - committedBalance;
  double get committedPercentage => (committedBalance / totalBalance).clamp(0, 1);
}

class FinancialHealth {
  final int score;
  final String status; // e.g., "Excelente", "Estável", "Atenção"
  final List<HealthIndicator> indicators;
  final double emergencyFundProgress; // 0.0 to 1.0

  FinancialHealth({
    required this.score,
    required this.status,
    required this.indicators,
    required this.emergencyFundProgress,
  });
}

class HealthIndicator {
  final String label;
  final double value; // 0.0 to 1.0
  final bool isPositive;

  HealthIndicator({
    required this.label,
    required this.value,
    required this.isPositive,
  });
}
