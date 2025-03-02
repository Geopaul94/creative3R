import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;


















import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class MarketDataScreen extends StatefulWidget {
  @override
  _MarketDataScreenState createState() => _MarketDataScreenState();
}

class _MarketDataScreenState extends State<MarketDataScreen> {
  final String adminId = const String.fromEnvironment('66e994239654078fd531dc2a');
  final String socketSecretKey = const String.fromEnvironment('aurify@123');
  final String baseUrl = "https://api.task.aurify.ae";

  // Updated endpoints
  final String getNews = 'user/get-news';
//  final String spotRates = 'user/get-spotrates';
  final String getCommodities = 'user/get-commodities';
  final String getServer = 'user/get-server';

  Map<String, dynamic> marketData = {};
  List<dynamic> commodities = [];
  String? serverURL;
  List<dynamic> news = [];
  String? error;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
   //   final spotRatesRes = await fetchSpotRates(adminId);
      final serverURLRes = await fetchServerURL();
      final newsRes = await fetchNews(adminId);
      final commoditiesRes = await fetchCommodities(adminId);

      setState(() {
        commodities = commoditiesRes['commodities'];
        serverURL = serverURLRes['info']['serverURL'];
        news = newsRes['news']['news'];
      });

      if (serverURL != null) {
        connectSocket(serverURL!);
      }

      // Process initial commodity data
      for (var commodity in commodities) {
        processCommodity(commodity);
      }
    } catch (e) {
      setState(() => error = "An error occurred while fetching data: $e");
      print("Error fetching data: $e");
    }
  }

  void connectSocket(String url) {
    IO.Socket socket = IO.io(url, <String, dynamic>{
      'query': {'secret': socketSecretKey},
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (_) {
      print('Connected to WebSocket server');
      socket.emit('request-data', []);
    });

    socket.on('disconnect', (_) => print('Disconnected from WebSocket server'));

    socket.on('market-data', (data) {
      if (data != null && data['symbol'] != null) {
        setState(() {
          marketData[data['symbol']] = {
            ...?marketData[data['symbol']],
            ...data,
            'bidChanged': marketData[data['symbol']] != null && data['bid'] != marketData[data['symbol']]['bid']
                ? (data['bid'] > marketData[data['symbol']]['bid'] ? 'up' : 'down')
                : null,
          };
        });
        // Process commodities with updated market data
        for (var commodity in commodities) {
          if (commodity['metal'].toLowerCase() == data['symbol'].toLowerCase()) {
            processCommodity(commodity);
          }
        }
      } else {
        print("Received malformed market data: $data");
      }
    });

    socket.on('error', (error) {
      print("WebSocket error: $error");
      setState(() => this.error = "An error occurred while receiving data");
    });
  }

  void processCommodity(Map<String, dynamic> commodity) {
    String symbol = commodity['metal'].toLowerCase();
    double bid = marketData[symbol]?['bid']?.toDouble() ?? 0.0; // Fetch live bid
    double ask = marketData[symbol]?['ask']?.toDouble() ?? 0.0; // Fetch live ask

    double unit = (commodity['unit'] as num).toDouble();
    String weight = commodity['weight'];
    double buyCharge = (commodity['buyCharge'] as num).toDouble();
    double sellCharge = (commodity['sellCharge'] as num).toDouble();
    double buyPremium = (commodity['buyPremium'] as num).toDouble();
    double sellPremium = (commodity['sellPremium'] as num).toDouble();
    double purity = (commodity['purity'] as num).toDouble();

    Map<String, double> unitMultiplierMap = {
      "GM": 1.0,
      "KG": 1000.0,
      "TTB": 116.64,
      "TOLA": 11.664,
      "OZ": 31.1034768,
    };

    double unitMultiplier = unitMultiplierMap[weight] ?? 1.0;
    double purityPower = calculatePurityPower(purity);

    double biddingValue = bid + buyPremium;
    double askingValue = ask + sellPremium + (symbol == 'gold' ? 0.5 : 0.05); // Gold: +0.5, others: +0.05
    double biddingPrice = (biddingValue / 31.103) * 3.674;
    double askingPrice = (askingValue / 31.103) * 3.674;

    double buyPrice = (biddingPrice * unitMultiplier * unit * purityPower) + buyCharge;
    double sellPrice = (askingPrice * unitMultiplier * unit * purityPower) + sellCharge;

    setState(() {
      marketData[symbol] = {
        ...?marketData[symbol],
        'buyPrice': buyPrice,
        'sellPrice': sellPrice,
      };
    });
  }

  double calculatePurityPower(double purity) {
    return purity / 100.0; // Assuming purity is given as a percentage (e.g., 99.9 -> 0.999)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Market Data")),
      body: error != null
          ? Center(child: Text(error!))
          : Column(
              children: [
                // Live Market Data Section
                Expanded(
                  child: ListView.builder(
                    itemCount: marketData.length,
                    itemBuilder: (context, index) {
                      String symbol = marketData.keys.elementAt(index);
                      var data = marketData[symbol];
                      return ListTile(
                        title: Text(symbol.toUpperCase()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Bid: ${data['bid'] ?? 'N/A'} | Ask: ${data['ask'] ?? 'N/A'}"),
                            Text("Buy Price: \$${data['buyPrice']?.toStringAsFixed(2) ?? 'N/A'}"),
                            Text("Sell Price: \$${data['sellPrice']?.toStringAsFixed(2) ?? 'N/A'}"),
                            if (data['bidChanged'] != null)
                              Row(
                                children: [
                                  Icon(
                                    data['bidChanged'] == 'up' ? Icons.arrow_upward : Icons.arrow_downward,
                                    color: data['bidChanged'] == 'up' ? Colors.green : Colors.red,
                                  ),
                                  Text(data['bidChanged'] == 'up' ? " Up" : " Down"),
                                ],
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Commodities List Section
                Expanded(
                  child: ListView.builder(
                    itemCount: commodities.length,
                    itemBuilder: (context, index) {
                      var commodity = commodities[index];
                      return ListTile(
                        title: Text(commodity['metal']),
                        subtitle: Text("Unit: ${commodity['unit']} ${commodity['weight']}"),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  // Future<Map<String, dynamic>> fetchSpotRates(String adminId) async {
  //   final response = await http.get(Uri.parse('$baseUrl/$spotRates/$adminId'));
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception("Failed to load spot rates: ${response.statusCode}");
  //   }
  // }

  Future<Map<String, dynamic>> fetchServerURL() async {
    final response = await http.get(Uri.parse('$baseUrl/$getServer'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load server URL: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> fetchNews(String adminId) async {
    final response = await http.get(Uri.parse('$baseUrl/$getNews/$adminId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load news: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> fetchCommodities(String adminId) async {
    final response = await http.get(Uri.parse('$baseUrl/$getCommodities/$adminId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load commodities: ${response.statusCode}");
    }}}