import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NFTListPage extends StatefulWidget {

  final String address;
  final String chain;

  const NFTListPage({
    Key? key,
    required this.address,
    required this.chain,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NFTListPageState createState() => _NFTListPageState();

}

class _NFTListPageState extends State<NFTListPage> {

  List<dynamic> _nftList = [];

  @override
  void initState() {
    super.initState();
    _loadNFTList();
  }

  Future<void> _loadNFTList() async {
    final response = await http.get(
        Uri.parse(
            '${dotenv.env['BACKEND_BASE_URL']}/get_user_nfts?address=${widget.address}&chain=${widget.chain}'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _nftList = jsonData['result'];
      });
    } else {
      throw Exception('Failed to load NFT list');
    }
  }

  @override
  Widget build(BuildContext context) {

    Card nftCardWidget(nft) {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${nft['name']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 200, // adjust the height as needed
              child: nft['normalized_metadata']['image'] != null
                  ? Image.network(
                      nft['normalized_metadata']['image'],
                      fit: BoxFit.contain,
                    )
                  : const Center(
                      child: Text('Img'),
                    ),
            ),
            Text(
              '${nft['normalized_metadata']['description']}',
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var nft in _nftList)
          nftCardWidget(nft),
      ],
    );
  }

}
