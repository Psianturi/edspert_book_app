import 'dart:convert';

import 'package:edspert_book_app/models/book_detail_response.dart';
import 'package:edspert_book_app/views/imag_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({Key? key, required this.isbn}) : super(key: key);
  final isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookDetailResponse bookDetail = BookDetailResponse();

  fetchDetailBookApi() async {
    //print("ini Tes");
    var url = Uri.parse('https://api.itbook.store/1.0/books/${widget.isbn}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBookDetail = jsonDecode(response.body);
      bookDetail = BookDetailResponse.fromJson(jsonBookDetail);
      setState(() {});
    }

    // print(await http.read(Uri.parse('https://api.itbook.store/1.0/new/')));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetailBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Book'),
        ),
        body: bookDetail == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ImageViewScreen(imageUrl: bookDetail.image!),
                          ),
                        );
                      }
                        ,child:
                      Image.network(
                        bookDetail.image!,
                        height: 150,
                      ),
                      ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              bookDetail.title!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              bookDetail.subtitle!,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              bookDetail.price!,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              bookDetail.isbn10!,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            // Text(
                            //   bookDetail.desc!,
                            //   style: const TextStyle(
                            //       fontSize: 14, fontWeight: FontWeight.bold),
                            // ),
                          ],
                        ),
                      ),
                      ),
                    ],
                  ),
              Align (
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    bookDetail.desc!,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                ),
              ),
                ],
              ));



  }
}
