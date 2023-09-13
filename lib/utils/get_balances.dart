import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> getBalances(String address, String chain) async {
  String baseUrl = dotenv.env['BACKEND_BASE_URL'] ?? '';
  baseUrl = baseUrl.replaceFirst(RegExp('^https?://'), '');
  final url = Uri.http(baseUrl, '/get_token_balance', {
    'address': address,
    'chain': chain,
  });

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to get balances');
  }
}
