enum TransactionType {
  sent,
  received,
  swap,
  stake,
  unstake,
}

class TransactionModel {
  final String hash;
  final String from;
  final String to;
  final String amount;
  final String symbol;
  final DateTime timestamp;
  final TransactionType type;
  final bool isPending;
  final double? gasUsed;
  final String? error;

  TransactionModel({
    required this.hash,
    required this.from,
    required this.to,
    required this.amount,
    required this.symbol,
    required this.timestamp,
    required this.type,
    this.isPending = false,
    this.gasUsed,
    this.error,
  });
}
