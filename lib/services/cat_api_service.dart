import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cat_image.dart';

class CatApiService {
  final String url = 'https://api.thecatapi.com/v1/images/search';

  Future<CatImage> fetchCatImage() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return CatImage.fromJson(jsonResponse[0]);
    } else {
      throw Exception('Failed to load cat image');
    }
  }
}
