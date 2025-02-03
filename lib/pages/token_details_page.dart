import 'package:flutter/material.dart';
import 'package:web3_wallet/theme/app_theme.dart';
import 'package:web3_wallet/utils/text_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:web3_wallet/services/coin_stats_service.dart';
import 'package:web3_wallet/components/transaction_history.dart';

class TokenDetailsPage extends StatelessWidget {
  final String tokenName;
  final String tokenSymbol;
  final String balance;
  final String price;
  final String address;

  const TokenDetailsPage({
    super.key,
    required this.tokenName,
    required this.tokenSymbol,
    required this.balance,
    required this.price,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final stats = CoinStatsService.getStatsForCoin(tokenSymbol);
    print('Looking up stats for symbol: $tokenSymbol');

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            TextWidget.textL(tokenName),
            const SizedBox(width: 4),
            TextWidget.textXSAlternate('($tokenSymbol)'),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: Column(
          children: [
            _PriceCard(
              balance: balance,
              price: price,
              change24h: '+5.2%',
              high24h: stats.high24h,
              low24h: stats.low24h,
              tokenSymbol: '',
            ),
            const SizedBox(height: 24.0),
            _ChartCard(),
            const SizedBox(height: 24.0),
            _StatsCard(
              marketCap: stats.marketCap,
              volume24h: stats.volume24h,
              circulatingSupply: stats.circulatingSupply,
              maxSupply: stats.maxSupply,
              rank: stats.rank,
              dominance: stats.dominance,
            ),
            const SizedBox(height: 24.0),
            _ActionButtons(
              onSend: () {
                // TODO: Implement send
              },
              onReceive: () {
                // TODO: Implement receive
              },
            ),
            Expanded(
              child: TransactionHistory(
                address: address,
                symbol: tokenSymbol,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  final String balance;
  final String price;
  final String change24h;
  final String high24h;
  final String low24h;
  final String tokenSymbol;

  const _PriceCard({
    required this.balance,
    required this.price,
    required this.change24h,
    required this.high24h,
    required this.low24h,
    required this.tokenSymbol,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance row
          Row(
            children: [
              TextWidget.textXSAlternate('Your Balance'),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextWidget.textXS('$balance $tokenSymbol'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Price row
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$$price',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: change24h.contains('+')
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      change24h.contains('+')
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16,
                      color:
                          change24h.contains('+') ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      change24h,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:
                            change24h.contains('+') ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Additional info row
          Row(
            children: [
              _InfoItem(
                label: '24h High',
                value: '\$$high24h',
              ),
              const SizedBox(width: 24),
              _InfoItem(
                label: '24h Low',
                value: '\$$low24h',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget.textXSAlternate(label),
        const SizedBox(height: 4),
        TextWidget.textS(value),
      ],
    );
  }
}

class _ChartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget.textM('Price Chart'),
              Row(
                children: [
                  _TimeframeButton(
                    label: '1D',
                    isSelected: true,
                    onTap: () {},
                  ),
                  _TimeframeButton(
                    label: '1W',
                    isSelected: false,
                    onTap: () {},
                  ),
                  _TimeframeButton(
                    label: '1M',
                    isSelected: false,
                    onTap: () {},
                  ),
                  _TimeframeButton(
                    label: '1Y',
                    isSelected: false,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 3),
                      const FlSpot(2.6, 2),
                      const FlSpot(4.9, 5),
                      const FlSpot(6.8, 3.1),
                      const FlSpot(8, 4),
                      const FlSpot(9.5, 3),
                      const FlSpot(11, 4),
                    ],
                    isCurved: true,
                    color: AppTheme.accentColor,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppTheme.accentColor.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeframeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimeframeButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 8.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 6.0,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.accentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? AppTheme.accentColor : Colors.grey,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final String marketCap;
  final String volume24h;
  final String circulatingSupply;
  final String maxSupply;
  final String rank;
  final String dominance;

  const _StatsCard({
    required this.marketCap,
    required this.volume24h,
    required this.circulatingSupply,
    required this.maxSupply,
    required this.rank,
    required this.dominance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget.textM('Statistics'),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextWidget.textXS('Rank $rank'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          _StatRow(
            label: 'Market Cap',
            value: '\$$marketCap',
          ),
          const Divider(height: 24.0),
          _StatRow(
            label: '24h Volume',
            value: '\$$volume24h',
          ),
          const Divider(height: 24.0),
          _StatRow(
            label: 'Market Dominance',
            value: dominance,
          ),
          const Divider(height: 24.0),
          _StatRow(
            label: 'Circulating Supply',
            value: circulatingSupply,
          ),
          const Divider(height: 24.0),
          _StatRow(
            label: 'Max Supply',
            value: maxSupply,
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget.textXSAlternate(label),
        TextWidget.textS(value),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final VoidCallback onSend;
  final VoidCallback onReceive;

  const _ActionButtons({
    required this.onSend,
    required this.onReceive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: AppTheme.cardDecoration,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              style: AppTheme.elevatedButtonStyle.copyWith(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
              onPressed: onSend,
              icon: const Icon(Icons.arrow_upward, size: 20),
              label: TextWidget.textM('Send'),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: OutlinedButton.icon(
              style: AppTheme.outlinedButtonStyle.copyWith(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
              onPressed: onReceive,
              icon: const Icon(Icons.arrow_downward, size: 20),
              label: TextWidget.textM('Receive'),
            ),
          ),
        ],
      ),
    );
  }
}
