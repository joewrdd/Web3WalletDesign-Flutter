import 'package:flutter/material.dart';
import 'package:web3_wallet/theme/app_theme.dart';
import 'package:web3_wallet/utils/text_widget.dart';
import 'package:web3_wallet/services/dummy_data_service.dart';
// import 'package:web3_wallet/models/token_model.dart';
import 'package:web3_wallet/models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  String _selectedFilter = 'All';

  List<TransactionModel> _getFilteredTransactions(
      List<TransactionModel> transactions) {
    if (_selectedFilter == 'All') return transactions;

    return transactions.where((tx) {
      switch (_selectedFilter) {
        case 'Sent':
          return tx.type == TransactionType.sent;
        case 'Received':
          return tx.type == TransactionType.received;
        case 'Swaps':
          return tx.type == TransactionType.swap;
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = DummyDataService.getDummyTokens();
    final allTransactions = tokens
        .expand((token) => DummyDataService.getDummyTransactions(token.symbol))
        .toList();
    allTransactions.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    final filteredTransactions = _getFilteredTransactions(allTransactions);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _FilterChip(
                    label: 'All',
                    isSelected: _selectedFilter == 'All',
                    onTap: () => setState(() => _selectedFilter = 'All'),
                  ),
                  _FilterChip(
                    label: 'Sent',
                    isSelected: _selectedFilter == 'Sent',
                    onTap: () => setState(() => _selectedFilter = 'Sent'),
                  ),
                  _FilterChip(
                    label: 'Received',
                    isSelected: _selectedFilter == 'Received',
                    onTap: () => setState(() => _selectedFilter = 'Received'),
                  ),
                  _FilterChip(
                    label: 'Swaps',
                    isSelected: _selectedFilter == 'Swaps',
                    onTap: () => setState(() => _selectedFilter = 'Swaps'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  final tx = filteredTransactions[index];
                  return _TransactionCard(transaction: tx);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const _FilterChip({
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.accentColor : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppTheme.accentColor : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextWidget.textXS(label),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const _TransactionCard({required this.transaction});

  String _getTransactionTypeString() {
    switch (transaction.type) {
      case TransactionType.sent:
        return 'Sent';
      case TransactionType.received:
        return 'Received';
      case TransactionType.swap:
        return 'Swapped';
      case TransactionType.stake:
        return 'Staked';
      case TransactionType.unstake:
        return 'Unstaked';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: AppTheme.cardDecoration,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: transaction.type == TransactionType.sent
                ? Colors.red.withOpacity(0.1)
                : Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            transaction.type == TransactionType.sent
                ? Icons.arrow_upward
                : Icons.arrow_downward,
            color: transaction.type == TransactionType.sent
                ? Colors.red
                : Colors.green,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget.textM(_getTransactionTypeString()),
            TextWidget.textM('${transaction.amount} ${transaction.symbol}'),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            TextWidget.textXSAlternate(transaction.hash),
            const SizedBox(height: 4.0),
            TextWidget.textXSAlternate(
              DateFormat('MMM dd, yyyy HH:mm').format(transaction.timestamp),
            ),
          ],
        ),
      ),
    );
  }
}

class _MockTransaction {
  final String hash;
  final String type;
  final String amount;
  final DateTime date;
  final String status;

  _MockTransaction({
    required this.hash,
    required this.type,
    required this.amount,
    required this.date,
    required this.status,
  });
}
