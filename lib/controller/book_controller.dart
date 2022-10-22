import 'dart:convert';

import 'package:edspert_book_app/models/book_detail_response.dart';
import 'package:edspert_book_app/models/book_list_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookController extends ChangeNotifier {
  BookListResponse? bookList;

  fetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      bookList = BookListResponse.fromJson(jsonBookList);
      notifyListeners();
    }

    // print(await http.read(Uri.parse('https://api.itbook.store/1.0/new/')));
  }

  BookDetailResponse? bookDetail;

  fetchDetailBookApi(isbn) async {
    //print("ini Tes");
    var url = Uri.parse('https://api.itbook.store/1.0/books/$isbn');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBookDetail = jsonDecode(response.body);
      bookDetail = BookDetailResponse.fromJson(jsonBookDetail);
      notifyListeners();
      fetchSimilarBookApi(bookDetail!.title!);
    }

    // print(await http.read(Uri.parse('https://api.itbook.store/1.0/new/')));
  }

  BookListResponse? similarBook;

  fetchSimilarBookApi(String title) async {
    //print("ini Tes");
    var url = Uri.parse('https://api.itbook.store/1.0/search/$title');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBookDetail = jsonDecode(response.body);
      similarBook = BookListResponse.fromJson(jsonBookDetail);
      notifyListeners();
    }
  }
}
