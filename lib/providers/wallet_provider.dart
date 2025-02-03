import 'package:web3dart/web3dart.dart';
import 'package:flutter/foundation.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicKey(String privateKey);
}

class WalletProvider extends ChangeNotifier implements WalletAddressService {
  String? privateKey;
  String? selectedNetwork;
  bool isDarkMode = true;
  String? selectedCurrency = 'USD';

  // Network settings
  final Map<String, String> networks = {
    'mainnet': 'https://mainnet.infura.io/v3/YOUR_API_KEY',
    'sepolia': 'https://sepolia.infura.io/v3/YOUR_API_KEY',
    'goerli': 'https://goerli.infura.io/v3/YOUR_API_KEY',
  };

  Future<void> loadPrivateKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    privateKey = prefs.getString('privateKey');
    selectedNetwork = prefs.getString('selectedNetwork') ?? 'sepolia';
    isDarkMode = prefs.getBool('isDarkMode') ?? true;
    selectedCurrency = prefs.getString('selectedCurrency') ?? 'USD';
    notifyListeners();
  }

  Future<void> setPrivateKey(String privateKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateKey', privateKey);
    this.privateKey = privateKey;
    notifyListeners();
  }

  Future<void> setNetwork(String network) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedNetwork', network);
    selectedNetwork = network;
    notifyListeners();
  }

  Future<void> setTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
    isDarkMode = isDark;
    notifyListeners();
  }

  Future<void> setCurrency(String currency) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCurrency', currency);
    selectedCurrency = currency;
    notifyListeners();
  }

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    await setPrivateKey(privateKey);
    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    return private.address;
  }

  Future<void> clearWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    privateKey = null;
    notifyListeners();
  }
}
