import 'package:flutter/material.dart';
import 'package:web3_wallet/pages/generate_mnemonic_page.dart';
import 'package:web3_wallet/pages/import_wallet.dart';
import 'package:web3_wallet/utils/text_widget.dart';
import 'package:web3_wallet/theme/app_theme.dart';

class CreateOrImportPage extends StatelessWidget {
  const CreateOrImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToGenerateMnemonicPage() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GenerateMnemonicPage(),
        ),
      );
    }

    void navigateToImportWallet() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ImportWallet(),
        ),
      );
    }

    Container logoWidget(String name) {
      return Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: SizedBox(
          height: 200,
          child: Image.asset(
            name,
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    ElevatedButton createWalletButtonWidget(String title) {
      return ElevatedButton(
        onPressed: navigateToGenerateMnemonicPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 2,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: TextWidget.fontSizeM,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    }

    ElevatedButton importWalletButtonWidget(String title) {
      return ElevatedButton(
        onPressed: navigateToImportWallet,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: AppTheme.accentColor, width: 1.5),
          ),
          elevation: 0,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: TextWidget.fontSizeM,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    }

    Container footerWidget(String label) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A1A), Color(0xFF0A0A0A)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'WRDD ',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: 'WALLET',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            logoWidget('assets/images/logo.png'),
            const SizedBox(height: 24.0),
            createWalletButtonWidget('Create Wallet'),
            const SizedBox(height: 16.0),
            importWalletButtonWidget('Import from Seed'),
            const SizedBox(height: 24.0),
            footerWidget('© 2025 Wrdd. All Rights Reserved.'),
          ],
        ),
      ),
    );
  }
}
