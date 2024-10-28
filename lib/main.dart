import 'package:flutter/material.dart';
import 'services/cat_api_service.dart';
import 'models/cat_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CatApiService catApiService = CatApiService();
  Future<CatImage>? futureCatImage;

  @override
  void initState() {
    super.initState();
    futureCatImage = catApiService.fetchCatImage();
  }

  void _loadNewCatImage() {
    setState(() {
      futureCatImage = catApiService.fetchCatImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Random Cat Image')),
      body: FutureBuilder<CatImage>(
        future: futureCatImage,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final catImage = snapshot.data!;
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(catImage.url),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _loadNewCatImage,
                      child: Text('Get Another Cat'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
