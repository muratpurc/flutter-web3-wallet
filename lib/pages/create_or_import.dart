import 'package:flutter/material.dart';
import 'package:web3_wallet/pages/generate_mnemonic_page.dart';
import 'package:web3_wallet/pages/import_wallet.dart';
import 'package:web3_wallet/utils/text_widget.dart';

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
      // Add your register logic here
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
          width: 150,
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
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(16.0),
        ),
        child: TextWidget.textM(title),
      );
    }

    ElevatedButton importWalletButtonWidget(String title) {
      return ElevatedButton(
        onPressed: navigateToImportWallet,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.all(16.0),
        ),
        child: TextWidget.textM(title),
      );
    }

    Container footerWidget(String label) {
      return Container(
        alignment: Alignment.center,
        child: TextWidget.textXSAlternate(label),
      );
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            TextWidget.textXLCenter('Moralis Wallet'),

            // Spacer
            const SizedBox(height: 24.0),

            // Logo
            logoWidget('assets/images/logo.png'),

            // Spacer
            const SizedBox(height: 24.0),

            // Create wallet button
            createWalletButtonWidget('Create Wallet'),

            // Spacer
            const SizedBox(height: 16.0),

            // Register button
            importWalletButtonWidget('Import from Seed'),

            // Spacer
            const SizedBox(height: 24.0),

            // Footer
            footerWidget('© 2023 Moralis. All rights reserved.'),
          ],
        ),
      ),
    );
  }

}
