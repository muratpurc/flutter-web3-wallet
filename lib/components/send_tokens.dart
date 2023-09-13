import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'dart:developer' as developer;

class SendTokensPage extends StatelessWidget {

  final String privateKey;
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  SendTokensPage({Key? key, required this.privateKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void sendTransaction(String receiver, EtherAmount txValue) async {
      var apiUrl = "Your RPC Url"; // Replace with your API
      // Replace with your API
      var httpClient = http.Client();
      var ethClient = Web3Client(apiUrl, httpClient);

      EthPrivateKey credentials = EthPrivateKey.fromHex('0x$privateKey');
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
    }

    TextField addressTextFieldWidget() {
      return TextField(
        controller: recipientController,
        decoration: const InputDecoration(
          labelText: 'Recipient Address',
        ),
      );
    }

    TextField amountTextFieldWidget() {
      return TextField(
        controller: amountController,
        decoration: const InputDecoration(
          labelText: 'Amount',
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      );
    }

    ElevatedButton sendButtonWidget() {
      return ElevatedButton(
        onPressed: () {
          String recipient = recipientController.text;
          double amount = double.parse(amountController.text);
          BigInt bigIntValue = BigInt.from(amount * pow(10, 18));
          developer.log("BigIntValue: $bigIntValue");
          EtherAmount ethAmount = EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue);
          developer.log("Ether amount: $ethAmount");
          // Convert the amount to EtherAmount
          sendTransaction(recipient, ethAmount);
        },
        child: const Text('Send'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Tokens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            addressTextFieldWidget(),

            const SizedBox(height: 16.0),

            amountTextFieldWidget(),

            const SizedBox(height: 16.0),

            sendButtonWidget(),
          ],
        ),
      ),
    );
  }

}
