import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3_wallet/providers/wallet_provider.dart';
import 'package:web3_wallet/pages/create_or_import.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3_wallet/utils/get_balances.dart';
import 'package:web3_wallet/utils/text_widget.dart';
import 'package:web3_wallet/components/nft_balances.dart';
import 'package:web3_wallet/components/send_tokens.dart';
import 'dart:convert';
import 'dart:developer' as developer;

class WalletPage extends StatefulWidget {

  const WalletPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WalletPageState createState() => _WalletPageState();

}

class _WalletPageState extends State<WalletPage> {

  String walletAddress = '';
  String balance = '';
  String pvKey = '';

  @override
  void initState() {
    super.initState();
    _loadWalletData();
  }

  Future<void> _loadWalletData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? privateKey = prefs.getString('privateKey');
    if (privateKey != null) {
      final walletProvider = WalletProvider();
      await walletProvider.loadPrivateKey();
      EthereumAddress address = await walletProvider.getPublicKey(privateKey);
      developer.log("Address: ${address.hex}");
      setState(() {
        walletAddress = address.hex;
        pvKey = privateKey;
      });
      developer.log("Private key: $pvKey");
      String response = await getBalances(address.hex, 'sepolia');
      dynamic data = json.decode(response);
      String newBalance = data['balance'] ?? '0';

      // Transform balance from wei to ether
      EtherAmount latestBalance = EtherAmount.fromBigInt(EtherUnit.wei, BigInt.parse(newBalance));
      String latestBalanceInEther = latestBalance.getValueInUnit(EtherUnit.ether).toString();

      setState(() {
        balance = latestBalanceInEther;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    void navigateToCreateOrImportPage() {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateOrImportPage(),
        ),
        (route) => false,
      );
    }

    void navigateToSendTokensPage() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SendTokensPage(privateKey: pvKey)
        ),
      );
    }

    ElevatedButton logoutButtonWidget(String title) {
      return ElevatedButton.icon(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('privateKey');
          navigateToCreateOrImportPage();
        },
        icon: const Icon(Icons.logout),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          textStyle: const TextStyle(fontSize: TextWidget.fontSizeL),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.4),
        ),
      );
    }

    List<Widget> sendButtonWidget(String title) {
      return [
        FloatingActionButton(
          heroTag: 'sendButton', // Unique tag for send button
          onPressed: navigateToSendTokensPage,
          child: const Icon(Icons.send),
        ),
        const SizedBox(height: 8.0),
        Text(title),
      ];
    }

    List<Widget> refreshButtonWidget(String title) {
      return [
        FloatingActionButton(
          heroTag: 'refreshButton', // Unique tag for send button
          onPressed: () {
            setState(() {
              // Update any necessary state variables or perform any actions to refresh the widget
            });
          },
          child: const Icon(Icons.replay_outlined),
        ),
        const SizedBox(height: 8.0),
        Text(title),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget.textXLCenter('Wallet Address'),
                const SizedBox(height: 16.0),
                TextWidget.textLCenter(walletAddress),
                const SizedBox(height: 32.0),
                TextWidget.textXLCenter('Balance'),
                const SizedBox(height: 16.0),
                TextWidget.textXLCenter(balance),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: sendButtonWidget('Send'),
              ),
              Column(
                children: refreshButtonWidget('Refresh'),
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.blue,
                    tabs: [
                      Tab(text: 'Assets'),
                      Tab(text: 'NFTs'),
                      Tab(text: 'Options'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Assets Tab
                        Column(
                          children: [
                            Card(
                              margin: const EdgeInsets.all(16.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget.textXL('Sepolia ETH'),
                                    TextWidget.textXL(balance),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        // NFTs Tab
                        SingleChildScrollView(
                            child: NFTListPage(
                                address: walletAddress, chain: 'sepolia')),
                        // Activities Tab
                        Center(
                          child: logoutButtonWidget("Logout"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
