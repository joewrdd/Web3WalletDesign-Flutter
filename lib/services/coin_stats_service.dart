import 'package:web3_wallet/models/coin_stats_model.dart';

class CoinStatsService {
  static final Map<String, CoinStatsModel> _coinStats = {
    'ETH': CoinStatsModel(
      marketCap: '225.8B',
      volume24h: '8.2B',
      circulatingSupply: '120.2M ETH',
      maxSupply: 'Unlimited',
      high24h: '1,950.00',
      low24h: '1,750.00',
      rank: '#2',
      dominance: '17.2%',
    ),
    'BTC': CoinStatsModel(
      marketCap: '845.3B',
      volume24h: '12.5B',
      circulatingSupply: '19.5M BTC',
      maxSupply: '21M BTC',
      high24h: '43,500.00',
      low24h: '41,200.00',
      rank: '#1',
      dominance: '51.2%',
    ),
    'ADA': CoinStatsModel(
      marketCap: '15.2B',
      volume24h: '380.5M',
      circulatingSupply: '35.4B ADA',
      maxSupply: '45B ADA',
      high24h: '0.48',
      low24h: '0.42',
      rank: '#8',
      dominance: '1.2%',
    ),
    'SOL': CoinStatsModel(
      marketCap: '38.7B',
      volume24h: '1.2B',
      circulatingSupply: '410.5M SOL',
      maxSupply: 'Unlimited',
      high24h: '98.50',
      low24h: '91.20',
      rank: '#5',
      dominance: '2.9%',
    ),
  };

  static CoinStatsModel getStatsForCoin(String symbol) {
    return _coinStats[symbol] ?? _getDefaultStats(symbol);
  }

  static CoinStatsModel _getDefaultStats(String symbol) {
    return CoinStatsModel(
      marketCap: 'N/A',
      volume24h: 'N/A',
      circulatingSupply: 'N/A',
      maxSupply: 'N/A',
      high24h: 'N/A',
      low24h: 'N/A',
      rank: 'N/A',
      dominance: 'N/A',
    );
  }
}
