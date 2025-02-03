import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web3_wallet/theme/app_theme.dart';
import 'package:web3_wallet/utils/text_widget.dart';
import 'dart:developer' as developer;

class SendTokensPage extends StatefulWidget {
  final String privateKey;

  const SendTokensPage({super.key, required this.privateKey});

  @override
  State<SendTokensPage> createState() => _SendTokensPageState();
}

class _SendTokensPageState extends State<SendTokensPage> {
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  bool isLoading = false;

  void sendTransaction(String receiver, EtherAmount txValue) async {
    setState(() {
      isLoading = true;
    });

    try {
      var apiUrl = "Your RPC Url"; // Replace with your API
      var httpClient = http.Client();
      var ethClient = Web3Client(apiUrl, httpClient);

      EthPrivateKey credentials =
          EthPrivateKey.fromHex('0x${widget.privateKey}');
      EtherAmount etherAmount = await ethClient.getBalance(credentials.address);
      EtherAmount gasPrice = await ethClient.getGasPrice();

      developer.log("Ether amount: $etherAmount");

      await ethClient.sendTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex(receiver),
          gasPrice: gasPrice,
          maxGas: 100000,
          value: txValue,
        ),
        chainId: 11155111,
      );

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transaction sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Tokens'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Stack(
        children: [
          // Background gradient container that fills the entire screen
          Container(
            decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
          ),
          // Scrollable content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildInfoCard(),
                    const SizedBox(height: 24),
                    _buildInputCard(),
                    const SizedBox(height: 24),
                    _buildSendButton(),
                    const SizedBox(height: 24), // Add bottom padding
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget.textM('Send ETH'),
          const SizedBox(height: 8),
          TextWidget.textXSAlternate(
            'Send ETH to any wallet address. Make sure you have enough ETH to cover gas fees.',
          ),
        ],
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAddressInput(),
          const SizedBox(height: 16),
          _buildAmountInput(),
        ],
      ),
    );
  }

  Widget _buildAddressInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget.textXSAlternate('Recipient Address'),
        const SizedBox(height: 8),
        TextField(
          controller: recipientController,
          decoration: InputDecoration(
            hintText: '0x...',
            filled: true,
            fillColor: AppTheme.secondaryBackgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.paste),
              onPressed: () async {
                final data = await Clipboard.getData('text/plain');
                if (data?.text != null) {
                  recipientController.text = data!.text!;
                }
              },
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget.textXSAlternate('Amount (ETH)'),
        const SizedBox(height: 8),
        TextField(
          controller: amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: '0.0',
            filled: true,
            fillColor: AppTheme.secondaryBackgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            suffixText: 'ETH',
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSendButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration,
      child: ElevatedButton(
        style: AppTheme.elevatedButtonStyle.copyWith(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        onPressed: isLoading
            ? null
            : () {
                String recipient = recipientController.text;
                double amount = double.parse(amountController.text);
                BigInt bigIntValue = BigInt.from(amount * pow(10, 18));
                developer.log("BigIntValue: $bigIntValue");
                EtherAmount ethAmount =
                    EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue);
                developer.log("Ether amount: $ethAmount");
                sendTransaction(recipient, ethAmount);
              },
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send),
                  const SizedBox(width: 8),
                  TextWidget.textM('Send ETH'),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    recipientController.dispose();
    amountController.dispose();
    super.dispose();
  }
}
