// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web3_wallet/theme/app_theme.dart';
import 'package:web3_wallet/utils/text_widget.dart';
import 'package:web3_wallet/services/dummy_data_service.dart';
import 'package:web3_wallet/models/nft_model.dart';

class NFTListPage extends StatefulWidget {
  final String address;
  final String chain;

  const NFTListPage({
    super.key,
    required this.address,
    required this.chain,
  });

  @override
  State<NFTListPage> createState() => _NFTListPageState();
}

class _NFTListPageState extends State<NFTListPage> {
  @override
  Widget build(BuildContext context) {
    final nfts = DummyDataService.getDummyNFTs();

    if (nfts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported,
              size: 64,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            TextWidget.textM('No NFTs found'),
            const SizedBox(height: 8),
            TextWidget.textXSAlternate('Your NFT collection will appear here'),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: nfts.length,
      itemBuilder: (context, index) {
        final nft = nfts[index];
        return _NFTCard(nft: nft);
      },
    );
  }
}

class _NFTCard extends StatelessWidget {
  final NFTModel nft;

  const _NFTCard({required this.nft});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NFT Image
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: NetworkImage(nft.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // NFT Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget.textS(nft.name),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget.textXSAlternate(nft.collection),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextWidget.textXS(nft.floorPrice),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
