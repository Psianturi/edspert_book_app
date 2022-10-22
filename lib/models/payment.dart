class Payment {
  List<String>? paymentMethodTypes;
  int? paymentDueDate;
  String? tokenId;
  String? url;
  String? expiredDate;

  Payment(
      {this.paymentMethodTypes,
      this.paymentDueDate,
      this.tokenId,
      this.url,
      this.expiredDate});

  Payment.fromJson(Map<String, dynamic> json) {
    paymentMethodTypes = json['payment_method_types'].cast<String>();
    paymentDueDate = json['payment_due_date'];
    tokenId = json['token_id'];
    url = json['url'];
    expiredDate = json['expired_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method_types'] = this.paymentMethodTypes;
    data['payment_due_date'] = this.paymentDueDate;
    data['token_id'] = this.tokenId;
    data['url'] = this.url;
    data['expired_date'] = this.expiredDate;
    return data;
  }
}
