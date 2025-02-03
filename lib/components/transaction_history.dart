import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web3_wallet/models/transaction_model.dart';
import 'package:web3_wallet/services/dummy_data_service.dart';
import 'package:web3_wallet/theme/app_theme.dart';
import 'package:web3_wallet/utils/text_widget.dart';

class TransactionHistory extends StatelessWidget {
  final String address;
  final String symbol;

  const TransactionHistory({
    super.key,
    required this.address,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    final transactions = DummyDataService.getDummyTransactions(symbol);

    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            TextWidget.textM('No transactions yet'),
            const SizedBox(height: 8),
            TextWidget.textXSAlternate(
                'Your transaction history will appear here'),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return _TransactionCard(transaction: tx, userAddress: address);
      },
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final String userAddress;

  const _TransactionCard({
    required this.transaction,
    required this.userAddress,
  });

  IconData _getTransactionIcon() {
    switch (transaction.type) {
      case TransactionType.sent:
        return Icons.arrow_upward;
      case TransactionType.received:
        return Icons.arrow_downward;
      case TransactionType.swap:
        return Icons.swap_horiz;
      case TransactionType.stake:
        return Icons.lock;
      case TransactionType.unstake:
        return Icons.lock_open;
    }
  }

  Color _getTransactionColor() {
    if (transaction.error != null) return Colors.red;
    if (transaction.isPending) return Colors.orange;

    switch (transaction.type) {
      case TransactionType.sent:
        return Colors.red;
      case TransactionType.received:
        return Colors.green;
      case TransactionType.swap:
        return Colors.blue;
      case TransactionType.stake:
        return Colors.purple;
      case TransactionType.unstake:
        return Colors.teal;
    }
  }

  String _getTransactionTitle() {
    if (transaction.error != null) return 'Failed';
    if (transaction.isPending) return 'Pending';

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
    final formattedDate =
        DateFormat('MMM d, h:mm a').format(transaction.timestamp);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: AppTheme.cardDecoration,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getTransactionColor().withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getTransactionIcon(),
            color: _getTransactionColor(),
          ),
        ),
        title: Row(
          children: [
            TextWidget.textM(_getTransactionTitle()),
            if (transaction.isPending) ...[
              const SizedBox(width: 8),
              const SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ],
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget.textXSAlternate(formattedDate),
            if (transaction.error != null)
              Text(
                transaction.error!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextWidget.textM('${transaction.amount} ${transaction.symbol}'),
            if (transaction.gasUsed != null)
              TextWidget.textXSAlternate(
                'Gas: ${transaction.gasUsed!.toStringAsFixed(4)} ETH',
              ),
          ],
        ),
        onTap: () {
          // TODO: Navigate to transaction details
        },
      ),
    );
  }
}
