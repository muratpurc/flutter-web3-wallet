import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web3_wallet/providers/wallet_provider.dart';
import 'package:web3_wallet/pages/verify_mnemonic_page.dart';
import 'package:web3_wallet/utils/text_widget.dart';
import 'dart:developer' as developer;

class GenerateMnemonicPage extends StatelessWidget {

  const GenerateMnemonicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final walletProvider = Provider.of<WalletProvider>(context);
    final mnemonic = walletProvider.generateMnemonic();
    final mnemonicWords = mnemonic.split(' ');
    developer.log("mnemonic: $mnemonic");

    void copyToClipboard() {
      Clipboard.setData(ClipboardData(text: mnemonic));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mnemonic Copied to Clipboard')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyMnemonicPage(mnemonic: mnemonic),
        ),
      );
    }

    Column mnemonicWordsListWidget() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          mnemonicWords.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
            child: TextWidget.textS('${index + 1}. ${mnemonicWords[index]}'),
          ),
        ),
      );
    }

    ElevatedButton copyToClipboardButtonWidget(String title) {
      return ElevatedButton.icon(
        onPressed: copyToClipboard,
        icon: const Icon(Icons.copy),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          textStyle: const TextStyle(fontSize: TextWidget.fontSizeL),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.4),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Mnemonic'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text
            TextWidget.textM('Please store this mnemonic phrase safely:'),

            // Spacer
            const SizedBox(height: 24.0),

            // Mnemonic words list
            mnemonicWordsListWidget(),

            // Spacer
            const SizedBox(height: 24.0),

            // Copy button
            copyToClipboardButtonWidget('Copy to Clipboard'),
          ],
        ),
      ),
    );
  }

}
