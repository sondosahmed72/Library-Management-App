import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, String> book;

  DetailsPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Book Name:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(book['name']!, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Genre:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(book['genre']!, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
