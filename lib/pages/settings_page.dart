import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_wallet/providers/wallet_provider.dart';
import 'package:web3_wallet/theme/app_theme.dart';
import 'package:web3_wallet/utils/text_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: ListView(
          children: [
            _SettingsSection(
              title: 'Network',
              children: [
                _SettingsDropdown(
                  value: walletProvider.selectedNetwork,
                  items: walletProvider.networks.keys.toList(),
                  onChanged: (value) => walletProvider.setNetwork(value!),
                ),
              ],
            ),
            _SettingsSection(
              title: 'Appearance',
              children: [
                SwitchListTile(
                  title: TextWidget.textM('Dark Mode'),
                  value: walletProvider.isDarkMode,
                  onChanged: (value) => walletProvider.setTheme(value),
                ),
              ],
            ),
            _SettingsSection(
              title: 'Currency',
              children: [
                _SettingsDropdown(
                  value: walletProvider.selectedCurrency,
                  items: const ['USD', 'EUR', 'GBP', 'JPY'],
                  onChanged: (value) => walletProvider.setCurrency(value!),
                ),
              ],
            ),
            _SettingsSection(
              title: 'Security',
              children: [
                ListTile(
                  title: TextWidget.textM('Backup Wallet'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Implement backup functionality
                  },
                ),
                ListTile(
                  title: TextWidget.textM('Change Password'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Implement password change
                  },
                ),
              ],
            ),
            _SettingsSection(
              title: 'About',
              children: [
                ListTile(
                  title: TextWidget.textM('Version'),
                  trailing: TextWidget.textXSAlternate('1.0.0'),
                ),
                ListTile(
                  title: TextWidget.textM('Terms of Service'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Show terms of service
                  },
                ),
                ListTile(
                  title: TextWidget.textM('Privacy Policy'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Show privacy policy
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextWidget.textXSAlternate(title.toUpperCase()),
        ),
        Container(
          decoration: AppTheme.cardDecoration,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: children,
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}

class _SettingsDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _SettingsDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: DropdownButton<String>(
        value: value,
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: TextWidget.textM(item),
                ))
            .toList(),
        onChanged: onChanged,
        isExpanded: true,
        dropdownColor: AppTheme.cardColor,
        underline: Container(),
      ),
    );
  }
}
