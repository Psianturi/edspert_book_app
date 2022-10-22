// import 'dart:html';

import 'package:edspert_book_app/controller/book_controller.dart';
import 'package:edspert_book_app/views/imag_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({Key? key, required this.isbn}) : super(key: key);
  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookController? controller;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    controller = Provider.of<BookController>(context, listen: false);
    controller!.fetchDetailBookApi(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Book'),
        ),
        body: Consumer<BookController>(builder: (context, controller, child) {
          return controller.bookDetail == null
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
                                      imageUrl: controller.bookDetail!.image!),
                                ),
                              );
                            },
                            child: Image.network(
                              controller.bookDetail!.image!,
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
                                    controller.bookDetail!.title!,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    controller.bookDetail!.subtitle!,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => Icon(
                                        Icons.star,
                                        color: index <
                                                int.parse(controller
                                                    .bookDetail!.rating!)
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    controller.bookDetail!.authors!,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    controller.bookDetail!.price!,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                // fixedSize: Size(double.infinity, 50)
                                ),
                            onPressed: () async {
                              (controller.bookDetail!.url!);
                              Uri uri = Uri.parse(controller.bookDetail!.url!);
                              try {} catch (e) {}
                              await canLaunchUrl(uri)
                                  ? launchUrl(uri)
                                  : print('error');
                            },
                            child: const Text("BUY")),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Text(controller.bookDetail!.desc!),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Publisher : " +
                              controller.bookDetail!.publisher!),
                          Text(controller.bookDetail!.pages! + " Pages"),
                          Text("ISBN : " + controller.bookDetail!.isbn13!),
                          Text("Year : " + controller.bookDetail!.year!),
                          // Text("Rating : " + bookDetail!.rating!),
                        ],
                      ),
                      Divider(),
                      controller.similarBook == null
                          ? CircularProgressIndicator()
                          : Container(
                              height: 180,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    controller.similarBook!.books!.length,
                                // physics: const NeverScrollableScrollPhysics(), //utk scroll kiri - kanan
                                itemBuilder: (context, index) {
                                  final current =
                                      controller.similarBook!.books![index];
                                  return Container(
                                    width: 90,
                                    child: Column(
                                      children: [
                                        Image.network(
                                          current.image!,
                                          height: 100,
                                        ),
                                        Text(
                                          current.title!,
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                    ],
                  ),
                );
        }));
  }
}
