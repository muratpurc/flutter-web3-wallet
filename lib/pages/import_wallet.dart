import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_wallet/providers/wallet_provider.dart';
import 'package:web3_wallet/pages/wallet.dart';
import 'package:web3_wallet/utils/text_widget.dart';

class ImportWallet extends StatefulWidget {

  const ImportWallet({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImportWalletState createState() => _ImportWalletState();

}

class _ImportWalletState extends State<ImportWallet> {

  bool isVerified = false;
  String verificationText = '';

  @override
  Widget build(BuildContext context) {

    void navigateToWalletPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WalletPage()),
      );
    }

    void verifyMnemonic() async {
      final walletProvider =
          Provider.of<WalletProvider>(context, listen: false);

      // Call the getPrivateKey function from the WalletProvider
      // ignore: unused_local_variable
      final privateKey = await walletProvider.getPrivateKey(verificationText);

      // Navigate to the WalletPage
      navigateToWalletPage();
    }

    TextField textFieldWidget(String label) {
      return TextField(
        onChanged: (value) {
          setState(() {
            verificationText = value;
          });
        },
        decoration: InputDecoration(
          labelText: label,
        ),
      );
    }

    ElevatedButton importButtonWidget(String label) {
      return ElevatedButton(
          onPressed: verifyMnemonic,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16.0),
          ),
          child: TextWidget.textM(label),
        );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Import from Seed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextWidget.textM('Please enter your mnemonic phrase:'),

            const SizedBox(height: 24.0),

            textFieldWidget('Enter mnemonic phrase'),

            const SizedBox(height: 16.0),

            importButtonWidget('Import'),

            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

}
