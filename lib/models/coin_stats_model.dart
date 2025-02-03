class CoinStatsModel {
  final String marketCap;
  final String volume24h;
  final String circulatingSupply;
  final String maxSupply;
  final String high24h;
  final String low24h;
  final String rank;
  final String dominance;

  CoinStatsModel({
    required this.marketCap,
    required this.volume24h,
    required this.circulatingSupply,
    required this.maxSupply,
    required this.high24h,
    required this.low24h,
    required this.rank,
    required this.dominance,
  });
}
