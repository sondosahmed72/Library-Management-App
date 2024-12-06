import 'package:flutter/material.dart';
import 'details_page.dart';

void main() {
  runApp(LibraryManagementApp());
}

class LibraryManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library Management App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> books = [];
  final TextEditingController bookController = TextEditingController();
  String selectedGenre = 'Fiction';
  final List<String> genres = ['Fiction', 'Non-Fiction', 'Science', 'Biography'];

  void addBook() {
    String bookName = bookController.text.trim();
    if (bookName.isEmpty) return;

    if (books.any((book) => book['name'] == bookName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Duplicate book names are not allowed!')),
      );
      return;
    }

    setState(() {
      books.add({'name': bookName, 'genre': selectedGenre});
    });
    bookController.clear();
  }

  void deleteBook(int index) {
    setState(() {
      books.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library Management App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: bookController,
                    decoration: InputDecoration(labelText: 'Enter book name'),
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedGenre,
                  onChanged: (value) {
                    setState(() {
                      selectedGenre = value!;
                    });
                  },
                  items: genres.map((genre) {
                    return DropdownMenuItem(
                      value: genre,
                      child: Text(genre),
                    );
                  }).toList(),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addBook,
                  child: Text('Add Book'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Total Books: ${books.length}', style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () => deleteBook(index),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(book: books[index]),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(books[index]['name']!),
                        subtitle: Text('Genre: ${books[index]['genre']}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
