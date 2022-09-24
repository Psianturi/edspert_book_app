
class BookDetailResponse {
  String? error;
  String? title;
  String? subtitle;
  String? authors;
  String? publisher;
  String? language;
  String? isbn10;
  String? isbn13;
  String? pages;
  String? year;
  String? rating;
  String? desc;
  String? price;
  String? image;
  String? url;
  Pdf? pdf;

  BookDetailResponse(
      {this.error,
        this.title,
        this.subtitle,
        this.authors,
        this.publisher,
        this.language,
        this.isbn10,
        this.isbn13,
        this.pages,
        this.year,
        this.rating,
        this.desc,
        this.price,
        this.image,
        this.url,
        this.pdf});

  BookDetailResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    title = json['title'];
    subtitle = json['subtitle'];
    authors = json['authors'];
    publisher = json['publisher'];
    language = json['language'];
    isbn10 = json['isbn10'];
    isbn13 = json['isbn13'];
    pages = json['pages'];
    year = json['year'];
    rating = json['rating'];
    desc = json['desc'];
    price = json['price'];
    image = json['image'];
    url = json['url'];
    pdf = json['pdf'] != null ? new Pdf.fromJson(json['pdf']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['authors'] = this.authors;
    data['publisher'] = this.publisher;
    data['language'] = this.language;
    data['isbn10'] = this.isbn10;
    data['isbn13'] = this.isbn13;
    data['pages'] = this.pages;
    data['year'] = this.year;
    data['rating'] = this.rating;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['image'] = this.image;
    data['url'] = this.url;
    if (this.pdf != null) {
      data['pdf'] = this.pdf!.toJson();
    }
    return data;
  }
}

class Pdf {
  String? freeEBook;

  Pdf({this.freeEBook});

  Pdf.fromJson(Map<String, dynamic> json) {
    freeEBook = json['Free eBook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Free eBook'] = this.freeEBook;
    return data;
  }
}