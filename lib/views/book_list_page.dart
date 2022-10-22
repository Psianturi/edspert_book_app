import 'package:edspert_book_app/controller/book_controller.dart';
import 'package:edspert_book_app/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookController? bookController;

  // BookListResponse? bookList;

  // fetchBookApi() async {
  //   var url = Uri.parse('https://api.itbook.store/1.0/new');
  //   var response = await http.get(url);
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');

  //   if (response.statusCode == 200) {
  //     final jsonBookList = jsonDecode(response.body);
  //     bookList = BookListResponse.fromJson(jsonBookList);
  //     setState(() {});
  //   }

  //   // print(await http.read(Uri.parse('https://api.itbook.store/1.0/new/')));
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Catalogue'),
      ),
      body: Consumer<BookController>(
        child: const Center(child: CircularProgressIndicator()),
        builder: (context, controller, child) => Container(
            child: bookController!.bookList == null
                ? child
                : ListView.builder(
                    itemCount: bookController!.bookList!.books!.length,
                    itemBuilder: (context, index) {
                      final currentBook =
                          bookController!.bookList!.books![index]; //
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailBookPage(
                                      isbn: currentBook.isbn13!,
                                    )));
                          },
                          child: Row(
                            children: [
                              Image.network(currentBook.image!, height: 100),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentBook.title!),
                                    Text(currentBook.subtitle!),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(currentBook.price!),
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ));
                    })),
      ),
    );
  }
}
