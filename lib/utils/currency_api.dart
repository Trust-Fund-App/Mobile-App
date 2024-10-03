import 'dart:convert';
import 'package:http/http.dart' as http;

class PriceFeed {
  Future<double> getUSD() async {
    const String key = '53a2e08c-55ec-4c71-97e4-c868710aecb8';
    const String newUrl =
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=ETH&convert=USD';
    try {
      http.Response response = await http.get(
        (Uri.parse(newUrl)),
        headers: {
          'X-CMC_PRO_API_KEY': key,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        double ghsPrice = body["data"]["ETH"]["quote"]["USD"]["price"];
        return ghsPrice;
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      throw Exception(e.toString());
      // debugPrint(e.toString());
    }
  }
}
