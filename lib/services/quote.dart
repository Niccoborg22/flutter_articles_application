import 'package:articles_app/models/quote.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Quote> fetchQuote() async {
  final response = await http.get(Uri.parse('xxx')); 

  if (response.statusCode == 200) {
    return Quote.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load quote');
  }
}