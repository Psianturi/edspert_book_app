import 'dart:convert';

import 'package:edspert_book_app/models/book_detail_response.dart';
import 'package:edspert_book_app/views/imag_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({Key? key, required this.isbn}) : super(key: key);
  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookDetailResponse? bookDetail;

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
    // ignore: todo
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
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.end, //ini supaya text kebawah
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageViewScreen(
                                    imageUrl: bookDetail!.image!),
                              ),
                            );
                          },
                          child: Image.network(
                            bookDetail!.image!,
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
                                  bookDetail!.title!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  bookDetail!.subtitle!,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      // fontWeight: FontWeight.bold
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => Icon(
                                      Icons.star,
                                      color:
                                          index < int.parse(bookDetail!.rating!)
                                              ? Colors.yellow
                                              : Colors.grey,
                                    ),
                                  ),
                                ),
                                Text(
                                  bookDetail!.authors!,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  bookDetail!.price!,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.lightGreen,
                                      fontWeight: FontWeight.bold),
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // fixedSize: Size(double.infinity, 50)
                              ),
                          onPressed: () {},
                          child: Text("BUY")),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Text(bookDetail!.desc!),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Publisher : " + bookDetail!.publisher!),
                        Text(bookDetail!.pages! + " Pages"),
                        Text("ISBN : " + bookDetail!.isbn13!),
                        Text("Year : " + bookDetail!.year!),
                        // Text("Rating : " + bookDetail!.rating!),
                      ],
                    ),
                  ],
                ),
              ));
  }
}
