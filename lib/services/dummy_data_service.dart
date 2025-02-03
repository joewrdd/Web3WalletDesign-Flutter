import 'package:web3_wallet/models/token_model.dart';
import 'package:web3_wallet/models/nft_model.dart';
import 'package:web3_wallet/models/transaction_model.dart';

class DummyDataService {
  static List<TokenModel> getDummyTokens() {
    return [
      TokenModel(
        name: 'Ethereum',
        symbol: 'ETH',
        balance: '2.5',
        price: '1,800.00',
        iconPath:
            'https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/eth.png',
        change24h: 5.2,
      ),
      TokenModel(
        name: 'Bitcoin',
        symbol: 'BTC',
        balance: '0.15',
        price: '35,000.00',
        iconPath:
            'https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/btc.png',
        change24h: -2.1,
      ),
      TokenModel(
        name: 'Cardano',
        symbol: 'ADA',
        balance: '1500.00',
        price: '0.45',
        iconPath:
            'https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/ada.png',
        change24h: 1.8,
      ),
      TokenModel(
        name: 'Solana',
        symbol: 'SOL',
        balance: '25.00',
        price: '95.00',
        iconPath:
            'https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/sol.png',
        change24h: 7.5,
      ),
      TokenModel(
        name: 'Polygon',
        symbol: 'MATIC',
        balance: '2000.00',
        price: '0.85',
        iconPath:
            'https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/matic.png',
        change24h: 3.7,
      ),
      TokenModel(
        name: 'Chainlink',
        symbol: 'LINK',
        balance: '150.00',
        price: '14.20',
        iconPath:
            'https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/link.png',
        change24h: -1.2,
      ),
      TokenModel(
        name: 'Avalanche',
        symbol: 'AVAX',
        balance: '45.00',
        price: '22.50',
        iconPath:
            'https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/avax.png',
        change24h: 4.3,
      ),
    ];
  }

  static List<NFTModel> getDummyNFTs() {
    return [
      NFTModel(
        name: 'Bored Ape #1234',
        description: 'A unique Bored Ape NFT with rare traits',
        imageUrl:
            'https://i.seadn.io/gae/Ju9CkWtV-1Okvf45wo8UctR-M9He2PjILP0oOvxE89AyiPPGtrR3gysu1Zgy0hjd2xKIgjJJtWIc0ybj4Vd7wv8t3pxDGHoJBzDB?auto=format&w=1000',
        collection: 'BAYC',
        tokenId: '1234',
        floorPrice: '50 ETH',
      ),
      NFTModel(
        name: 'CryptoPunk #5678',
        description: 'One of the original CryptoPunks',
        imageUrl:
            'https://i.seadn.io/gae/BdxvLseXcfl57BiuQcQYdJ64v-aI8din7WPk0Pgo3qQFhAUH-B6i-dCqqc_mCkRIzULmwzwecnohLhrcH8A9mpWIZqA7ygc52Sr81hE?auto=format&w=1000',
        collection: 'CryptoPunks',
        tokenId: '5678',
        floorPrice: '30 ETH',
      ),
      NFTModel(
        name: 'Doodle #9012',
        description: 'A colorful and unique Doodle',
        imageUrl:
            'https://i.seadn.io/gae/7B0qai02OdHA8P_EOVK672qUliyjQdQDGNrACxs7WnTgZAkJa_wWURnIFKeOh5VTf8cfTqW3wQpozGedaC9mteKphEOtztls02RlWQ?auto=format&w=1000',
        collection: 'Doodles',
        tokenId: '9012',
        floorPrice: '8 ETH',
      ),
      NFTModel(
        name: 'Azuki #3456',
        description: 'A rare Azuki character',
        imageUrl:
            'https://i.seadn.io/gae/H8jOCJuQokNqGBpkBN5wk1oZwO7LM8bNnrHCaekV2nKjnCqw6UB5oaH8XyNeBDj6bA_n1mjejzhFQUP3O1NfjFLHr3FOaeHcTOOT?auto=format&w=1000',
        collection: 'Azuki',
        tokenId: '3456',
        floorPrice: '15 ETH',
      ),
      NFTModel(
        name: 'Moonbird #7890',
        description: 'A rare Moonbird with unique traits',
        imageUrl:
            'https://i.seadn.io/gae/H-eyNE1MwL5ohL-tCfn_Xa1Sl9M9B4612tLYeUlQubzt4ewhr4huJIR5OLuyO3Z5PpJFSwdm7rq-TikAh7f5eUw338A2cy6HRH75?auto=format&w=1000',
        collection: 'Moonbirds',
        tokenId: '7890',
        floorPrice: '12 ETH',
      ),
      NFTModel(
        name: 'Clone X #4321',
        description: 'A unique Clone X avatar',
        imageUrl:
            'https://i.seadn.io/gae/XN0XuD8Uh3jyRWGtfunP_3YZ6p_PByk8HPvqGYhYx_H7_0UwX0SxFjdUEVa3HRVDWd0DbH6Y2R2LQCh_m8diCpqQPW6Y3I3OTb1dQw?auto=format&w=1000',
        collection: 'Clone X',
        tokenId: '4321',
        floorPrice: '20 ETH',
      ),
      NFTModel(
        name: 'Pudgy Penguin #6789',
        description: 'An adorable Pudgy Penguin',
        imageUrl:
            'https://i.seadn.io/gae/yNi-XdGxsgQCPpqSio4o31ygMV2Sb7OOYb5JQ1FTwktlIKA8AH8Dg4C_qxX3Z2x9wjSP3sZvQW_QJgJDT3eZ9YYgCLWCF2GWAVA6?auto=format&w=1000',
        collection: 'Pudgy Penguins',
        tokenId: '6789',
        floorPrice: '10 ETH',
      ),
    ];
  }

  static List<TransactionModel> getDummyTransactions(String symbol) {
    switch (symbol.toUpperCase()) {
      case 'ETH':
        return [
          TransactionModel(
            hash: '0x1234...5678',
            from: '0xf1cb...3797',
            to: '0x9876...4321',
            amount: '0.5',
            symbol: 'ETH',
            timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
            type: TransactionType.sent,
            gasUsed: 0.002,
          ),
          TransactionModel(
            hash: '0x1357...2468',
            from: '0xf1cb...3797',
            to: 'Lido Protocol',
            amount: '2',
            symbol: 'ETH',
            timestamp: DateTime.now().subtract(const Duration(days: 2)),
            type: TransactionType.stake,
            gasUsed: 0.003,
          ),
        ];
      case 'BTC':
        return [
          TransactionModel(
            hash: '0x8765...4321',
            from: '0x5432...8765',
            to: '0xf1cb...3797',
            amount: '0.025',
            symbol: 'BTC',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            type: TransactionType.received,
          ),
          TransactionModel(
            hash: '0x9999...8888',
            from: '0xf1cb...3797',
            to: '0x1111...2222',
            amount: '0.01',
            symbol: 'BTC',
            timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
            type: TransactionType.sent,
            isPending: true,
          ),
        ];
      case 'SOL':
        return [
          TransactionModel(
            hash: '0x2468...1357',
            from: '0xf1cb...3797',
            to: 'Uniswap V3',
            amount: '100',
            symbol: 'SOL',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            type: TransactionType.swap,
            gasUsed: 0.005,
          ),
        ];
      case 'MATIC':
        return [
          TransactionModel(
            hash: '0x4444...3333',
            from: '0xf1cb...3797',
            to: 'Aave V3',
            amount: '500',
            symbol: 'MATIC',
            timestamp: DateTime.now().subtract(const Duration(hours: 6)),
            type: TransactionType.stake,
            gasUsed: 0.001,
          ),
        ];
      case 'LINK':
        return [
          TransactionModel(
            hash: '0x6666...5555',
            from: 'Binance',
            to: '0xf1cb...3797',
            amount: '100',
            symbol: 'LINK',
            timestamp: DateTime.now().subtract(const Duration(hours: 12)),
            type: TransactionType.received,
          ),
        ];
      case 'AVAX':
        return [
          TransactionModel(
            hash: '0x8888...7777',
            from: '0xf1cb...3797',
            to: 'Trader Joe',
            amount: '25',
            symbol: 'AVAX',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            type: TransactionType.swap,
            gasUsed: 0.003,
          ),
        ];
      default:
        return [];
    }
  }
}
