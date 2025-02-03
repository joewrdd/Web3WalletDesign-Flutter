import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_wallet/pages/create_or_import.dart';
import 'providers/wallet_provider.dart';
import 'package:web3_wallet/utils/routes.dart';
import 'package:web3_wallet/pages/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;
import 'package:web3_wallet/theme/app_theme.dart';
import 'package:web3_wallet/pages/wallet.dart';
import 'package:web3_wallet/pages/generate_mnemonic_page.dart';
import 'package:web3_wallet/pages/verify_mnemonic_page.dart';
import 'package:web3_wallet/pages/import_wallet.dart';
import 'package:web3_wallet/pages/settings_page.dart';
import 'package:web3_wallet/pages/transaction_history_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Web3 Wallet',
      theme: AppTheme.darkTheme,
      initialRoute: MyRoutes.loginRoute,
      routes: {
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.walletRoute: (context) => const WalletPage(),
        MyRoutes.createImportRoute: (context) => const CreateOrImportPage(),
        MyRoutes.generateMnemonicRoute: (context) =>
            const GenerateMnemonicPage(),
        MyRoutes.verifyMnemonicRoute: (context) =>
            const VerifyMnemonicPage(mnemonic: ''),
        MyRoutes.importWalletRoute: (context) => const ImportWallet(),
        MyRoutes.settingsRoute: (context) => const SettingsPage(),
        MyRoutes.transactionHistoryRoute: (context) =>
            const TransactionHistoryPage(),
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the .env file
  await dotenv.load(fileName: '.env');

  // Load the private key
  WalletProvider walletProvider = WalletProvider();
  await walletProvider.loadPrivateKey();

  developer.log('log me');

  runApp(
    ChangeNotifierProvider<WalletProvider>.value(
      value: walletProvider,
      child: const MyApp(),
    ),
  );
}
