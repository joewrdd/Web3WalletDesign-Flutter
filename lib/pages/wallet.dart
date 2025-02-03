import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3_wallet/providers/wallet_provider.dart';
import 'package:web3_wallet/pages/create_or_import.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3_wallet/utils/get_balances.dart';
import 'package:web3_wallet/utils/text_widget.dart';
import 'package:web3_wallet/components/nft_balances.dart';
import 'package:web3_wallet/components/send_tokens.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:web3_wallet/theme/app_theme.dart';
import 'package:web3_wallet/pages/settings_page.dart';
import 'package:web3_wallet/pages/transaction_history_page.dart';
import 'package:web3_wallet/pages/token_details_page.dart';
import 'package:web3_wallet/services/dummy_data_service.dart';
import 'package:web3_wallet/models/token_model.dart';
import 'package:web3_wallet/models/nft_model.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String walletAddress = '';
  String balance = '';
  String pvKey = '';
  List<TokenModel> tokens = [];
  List<NFTModel> nfts = [];

  @override
  void initState() {
    super.initState();
    _loadWalletData();
    // Load dummy data
    tokens = DummyDataService.getDummyTokens();
    nfts = DummyDataService.getDummyNFTs();
  }

  Future<void> _loadWalletData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? privateKey = prefs.getString('privateKey');
    if (privateKey != null) {
      final walletProvider = WalletProvider();
      await walletProvider.loadPrivateKey();
      EthereumAddress address = await walletProvider.getPublicKey(privateKey);
      developer.log("Address: ${address.hex}");
      setState(() {
        walletAddress = address.hex;
        pvKey = privateKey;
      });
      developer.log("Private key: $pvKey");
      String response = await getBalances(address.hex, 'sepolia');
      dynamic data = json.decode(response);
      String newBalance = data['balance'] ?? '0';

      // Transform balance from wei to ether
      EtherAmount latestBalance =
          EtherAmount.fromBigInt(EtherUnit.wei, BigInt.parse(newBalance));
      String latestBalanceInEther =
          latestBalance.getValueInUnit(EtherUnit.ether).toStringAsFixed(1);

      setState(() {
        balance = latestBalanceInEther.isEmpty ? '0.0' : latestBalanceInEther;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void navigateToCreateOrImportPage() {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateOrImportPage(),
        ),
        (route) => false,
      );
    }

    void navigateToSendTokensPage() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SendTokensPage(privateKey: pvKey)),
      );
    }

    Widget balanceCard() {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            TextWidget.textM('Total Balance'),
            const SizedBox(height: 8),
            TextWidget.textXL('$balance ETH'),
            const SizedBox(height: 16),
            Text(
              walletAddress,
              style: const TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    Widget actionButtons() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ActionButton(
              icon: Icons.send,
              label: 'Send',
              onTap: navigateToSendTokensPage,
            ),
            _ActionButton(
              icon: Icons.history,
              label: 'History',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransactionHistoryPage(),
                  ),
                );
              },
            ),
            _ActionButton(
              icon: Icons.refresh,
              label: 'Refresh',
              onTap: _loadWalletData,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        backgroundColor: const Color(0xFF1A1A1A),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('privateKey');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateOrImportPage(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A1A), Color(0xFF0A0A0A)],
          ),
        ),
        child: Column(
          children: [
            balanceCard(),
            actionButtons(),
            const SizedBox(height: 24),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: 'Assets'),
                        Tab(text: 'NFTs'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Assets Tab
                          ListView(
                            padding: const EdgeInsets.all(16),
                            children: tokens
                                .map((token) => AssetCard(
                                      name: token.name,
                                      symbol: token.symbol,
                                      balance: token.balance,
                                      icon: token.iconPath,
                                      price: token.price,
                                      change24h: token.change24h,
                                      address: walletAddress,
                                    ))
                                .toList(),
                          ),
                          // NFTs Tab
                          NFTListPage(address: walletAddress, chain: 'sepolia'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AssetCard extends StatelessWidget {
  final String name;
  final String symbol;
  final String balance;
  final String icon;
  final String price;
  final double change24h;
  final String address;

  const AssetCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.balance,
    required this.icon,
    required this.price,
    required this.change24h,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TokenDetailsPage(
              tokenName: name,
              tokenSymbol: symbol,
              balance: balance,
              price: price,
              address: address,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: AppTheme.cardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.secondaryBackgroundColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    icon,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.currency_bitcoin,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget.textM(name),
                        TextWidget.textM('\$$price'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget.textXSAlternate('$balance $name'),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: change24h >= 0
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextWidget.textXSAlternate(
                            '${change24h >= 0 ? '+' : ''}${change24h.toStringAsFixed(1)}%',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
