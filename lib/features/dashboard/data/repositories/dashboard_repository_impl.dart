import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../shared/models/transaction.dart';
import '../../../../shared/models/financial_intelligence.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<BalanceSummary> getBalanceSummary() async {
    // Simulated delay
    await Future.delayed(const Duration(milliseconds: 500));
    return BalanceSummary(
      totalBalance: 8000,
      committedBalance: 6400,
      recurringExpenses: 3000,
      upcomingBills: 2000,
      creditCardBills: 1400,
    );
  }

  @override
  Future<List<Transaction>> getRecentTransactions() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      Transaction(
        id: '1',
        title: 'Mercado Livre',
        description: 'Compra parcelada • 1/10',
        amount: -159.90,
        date: DateTime.now(),
        category: 'Compras',
        type: TransactionType.expense,
        icon: LucideIcons.shoppingBag,
        color: Colors.orange,
        userId: '1',
      ),
      Transaction(
        id: '2',
        title: 'Salário Lukas',
        description: 'Depósito recebido',
        amount: 12500.00,
        date: DateTime.now().subtract(const Duration(days: 1)),
        category: 'Salário',
        type: TransactionType.income,
        icon: LucideIcons.briefcase,
        color: Colors.green,
        userId: '1',
      ),
    ];
  }

  @override
  Future<FinancialHealth> getFinancialHealth() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return FinancialHealth(
      score: 82,
      status: 'ESTÁVEL',
      indicators: [
        HealthIndicator(label: 'Reserva de Emergência', value: 0.65, isPositive: true),
        HealthIndicator(label: 'Controle de Dívidas', value: 0.90, isPositive: true),
        HealthIndicator(label: 'Sobra Mensal', value: 0.45, isPositive: false),
      ],
      emergencyFundProgress: 0.65,
    );
  }
}
