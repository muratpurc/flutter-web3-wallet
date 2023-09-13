import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_wallet/providers/wallet_provider.dart';
import 'package:web3_wallet/pages/wallet.dart';
import 'package:web3_wallet/utils/text_widget.dart';

class VerifyMnemonicPage extends StatefulWidget {

  final String mnemonic;

  const VerifyMnemonicPage({Key? key, required this.mnemonic})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VerifyMnemonicPageState createState() => _VerifyMnemonicPageState();

}

class _VerifyMnemonicPageState extends State<VerifyMnemonicPage> {

  bool isVerified = false;
  String verificationText = '';

  @override
  Widget build(BuildContext context) {

    void verifyMnemonic() {
      final walletProvider = Provider.of<WalletProvider>(context, listen: false);

      if (verificationText.trim() == widget.mnemonic.trim()) {
        walletProvider.getPrivateKey(widget.mnemonic).then((privateKey) {
          setState(() {
            isVerified = true;
          });
        });
      }
    }

    TextField mnemonicPhraseTextFieldWidget(String title) {
      return TextField(
        onChanged: (value) {
          setState(() {
            verificationText = value;
          });
        },
        decoration: InputDecoration(
          labelText: title,
        ),
      );
    }

    void navigateToWalletPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WalletPage()),
      );
    }

    ElevatedButton verifyElevatedButtonWidget(String title) {
      return ElevatedButton(
        onPressed: verifyMnemonic,
        child: Text(title),
      );
    }

    ElevatedButton nextElevatedButtonWidget(String title) {
      return ElevatedButton(
        onPressed: isVerified ? navigateToWalletPage : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        child: Text(title),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Mnemonic and Create'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextWidget.textM('Please verify your mnemonic phrase:'),

            const SizedBox(height: 24.0),

            mnemonicPhraseTextFieldWidget('Enter mnemonic phrase'),

            const SizedBox(height: 16.0),

            verifyElevatedButtonWidget('Verify'),

            const SizedBox(height: 24.0),

            nextElevatedButtonWidget('Next'),
          ],
        ),
      ),
    );
  }

}
