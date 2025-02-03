class TokenStats {
  final String marketCap;
  final String volume24h;
  final String circulatingSupply;
  final String maxSupply;
  final String high24h;
  final String low24h;
  final String rank;
  final String dominance;

  TokenStats({
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

class TokenStatsService {
  static TokenStats getTokenStats(String symbol) {
    switch (symbol.toUpperCase()) {
      case 'ETH':
        return TokenStats(
          marketCap: '225.8B',
          volume24h: '8.2B',
          circulatingSupply: '120.2M ETH',
          maxSupply: 'Unlimited',
          high24h: '\$1,950.00',
          low24h: '\$1,750.00',
          rank: '#2',
          dominance: '17.2%',
        );
      case 'BTC':
        return TokenStats(
          marketCap: '845.2B',
          volume24h: '15.5B',
          circulatingSupply: '19.5M BTC',
          maxSupply: '21M BTC',
          high24h: '\$43,500.00',
          low24h: '\$41,200.00',
          rank: '#1',
          dominance: '51.2%',
        );
      case 'ADA':
        return TokenStats(
          marketCap: '15.2B',
          volume24h: '450.5M',
          circulatingSupply: '35.2B ADA',
          maxSupply: '45B ADA',
          high24h: '\$0.48',
          low24h: '\$0.42',
          rank: '#8',
          dominance: '1.2%',
        );
      case 'SOL':
        return TokenStats(
          marketCap: '38.5B',
          volume24h: '1.2B',
          circulatingSupply: '410.5M SOL',
          maxSupply: 'Unlimited',
          high24h: '\$98.50',
          low24h: '\$91.20',
          rank: '#5',
          dominance: '2.8%',
        );
      default:
        return TokenStats(
          marketCap: '0',
          volume24h: '0',
          circulatingSupply: '0',
          maxSupply: '0',
          high24h: '0',
          low24h: '0',
          rank: 'N/A',
          dominance: '0%',
        );
    }
  }
}
