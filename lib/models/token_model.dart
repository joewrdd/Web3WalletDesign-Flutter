class TokenModel {
  final String name;
  final String symbol;
  final String balance;
  final String price;
  final String iconPath;
  final double change24h;

  TokenModel({
    required this.name,
    required this.symbol,
    required this.balance,
    required this.price,
    required this.iconPath,
    required this.change24h,
  });
}
