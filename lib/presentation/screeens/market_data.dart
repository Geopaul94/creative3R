// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:http/http.dart' as http;

// class MarketDataScreen extends StatefulWidget {
//   @override
//   _MarketDataScreenState createState() => _MarketDataScreenState();
// }

// class _MarketDataScreenState extends State<MarketDataScreen> {
//   final String adminId =
//       '66e994239654078fd531dc2a'; // Replace with actual admin ID
//   final String socketSecretKey = 'aurify@123'; // Replace with actual secret key
//   final String baseUrl = "https://api.task.aurify.ae";

//   Map<String, dynamic> marketData = {};
//   List<dynamic> commodities = [];
//   String? serverURL;
//   List<dynamic> news = [];
//   String? error;

//   late IO.Socket socket;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       final spotRatesRes = await fetchSpotRates(adminId);
//       final serverURLRes = await fetchServerURL();
//       final newsRes = await fetchNews(adminId);
//       final commoditiesRes = await fetchCommodities(adminId);

//       setState(() {
//         commodities = commoditiesRes['commodities'];
//         serverURL = serverURLRes['info']['serverURL'];
//         news = newsRes['news']['news'];
//       });

//       if (serverURL != null) {
//         connectSocket(serverURL!);
//       }
//     } catch (e) {
//       setState(() => error = "An error occurred while fetching data");
//       print("Error fetching data: $e");
//     }
//   }

//   Future<Map<String, dynamic>> fetchSpotRates(String adminId) async {
//     return _fetchData('$baseUrl/user/get-spotrates/$adminId');
//   }

//   Future<Map<String, dynamic>> fetchServerURL() async {
//     return _fetchData('$baseUrl/user/get-server');
//   }

//   Future<Map<String, dynamic>> fetchNews(String adminId) async {
//     return _fetchData('$baseUrl/user/get-news/$adminId');
//   }

//   Future<Map<String, dynamic>> fetchCommodities(String adminId) async {
//     return _fetchData('$baseUrl/user/get-commodities/$adminId');
//   }

//   Future<Map<String, dynamic>> _fetchData(String url) async {
//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'X-Secret-Key':
//               'IfiuH/Ox6QKC3jP6ES6Y+aGYuGJEAOkbJb', // Add the X-Secret-Key header
//           'Content-Type': 'application/json',
//         },
//       );
//       print("Response: ${response.statusCode}, Body: ${response.body}");
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception(
//             "Failed to load data. Status Code: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//       rethrow;
//     }
//   }

//   // void connectSocket(String url) {
//   //   socket = IO.io(url, <String, dynamic>{
//   //     'query': {'secret': socketSecretKey},
//   //     'transports': ['websocket'],
//   //     'autoConnect': false,
//   //   });

//   //   socket.connect();

//   //   socket.on('connect', (_) {
//   //     print('Connected to WebSocket server');
//   //     socket.emit('request-data', []);
//   //   });

//   //   socket.on('disconnect', (_) => print('Disconnected from WebSocket server'));

//   //   socket.on('market-data', (data) {
//   //     if (data != null && data['symbol'] != null) {
//   //       setState(() {
//   //         marketData[data['symbol']] = {
//   //           ...?marketData[data['symbol']],
//   //           ...data,
//   //           'bidChanged': marketData[data['symbol']] != null && data['bid'] != marketData[data['symbol']]['bid']
//   //               ? (data['bid'] > marketData[data['symbol']]['bid'] ? 'up' : 'down')
//   //               : null,
//   //         };
//   //       });
//   //     } else {
//   //       print("Received malformed market data: $data");
//   //     }
//   //   });

//   //   socket.on('error', (error) {
//   //     print("WebSocket error: $error");
//   //     setState(() => this.error = "An error occurred while receiving data");
//   //   });
//   // }

// void connectSocket(String url) {
//   socket = IO.io(url, <String, dynamic>{
//     'query': {'secret': socketSecretKey},
//     'transports': ['websocket'],
//     'autoConnect': false,
//   });

//   socket.connect();

//   socket.on('connect', (_) {
//     print('Connected to WebSocket server');
//     final symbols = commodities
//         .map((commodity) => commodity.toString().toUpperCase())
//         .toList();
//     print("Emitting request-data with payload: {\"symbols\": $symbols}");
//     socket.emit('request-data', {"symbols": symbols});
//   });

//   socket.on('disconnect', (_) => print('Disconnected from WebSocket server'));

//   socket.on('market-data', (data) {
//     try {
//       // Log the full payload for debugging
//       print("Received market data: $data");

//       // Validate the payload structure
//       if (data == null || data['symbol'] == null) {
//         print("Received malformed market data: $data");
//         return;
//       }

//       // Extract and handle numeric fields safely
//       final symbol = data['symbol'].toString();
//       final bid = double.tryParse(data['bid']?.toString() ?? '0.0') ?? 0.0;
//       final ask = double.tryParse(data['ask']?.toString() ?? '0.0') ?? 0.0;

//       // Update the market data state safely
//       setState(() {
//         marketData[symbol] = {
//           ...?marketData[symbol],
//           'symbol': symbol,
//           'bid': bid,
//           'ask': ask,
//           'bidChanged': marketData[symbol] != null &&
//                   bid != (marketData[symbol]['bid'] ?? 0.0)
//               ? (bid > (marketData[symbol]['bid'] ?? 0.0) ? 'up' : 'down')
//               : null,
//         };
//       });
//     } catch (e) {
//       print("Error parsing market data: $e");
//       setState(() => error = "An error occurred while receiving data");
//     }
//   });

//   socket.on('error', (error) {
//     print("WebSocket error: $error");
//     setState(() => this.error = "An error occurred while receiving data");
//   });
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Market Data")),
//       body: error != null
//           ? Center(child: Text(error!))
//           : Column(
//               children: [
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       // Commodities Section
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "Commodities",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Wrap(
//                         spacing: 8.0,
//                         children: commodities.map((commodity) {
//                           return Chip(
//                             label: Text(commodity.toString()),
//                             backgroundColor: Colors.blue.shade100,
//                           );
//                         }).toList(),
//                       ),

//                       // News Section
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "Latest News",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       ...news.map((item) {
//                         return ListTile(
//                           title: Text(item['title']),
//                           subtitle: Text(item['description']),
//                         );
//                       }).toList(),

//                       // Live Market Data Section
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "Live Market Data",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       ...marketData.keys.map((symbol) {
//                         final data = marketData[symbol];
//                         return ListTile(
//                           title: Text(symbol),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Bid: ${data['bid']}"),
//                               Text("Ask: ${data['ask']}"),
//                               if (data['bidChanged'] != null)
//                                 Text(
//                                   "Bid Changed: ${data['bidChanged']}",
//                                   style: TextStyle(
//                                     color: data['bidChanged'] == 'up'
//                                         ? Colors.green
//                                         : Colors.red,
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
