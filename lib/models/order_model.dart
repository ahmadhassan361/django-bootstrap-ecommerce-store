class Order {
  int? id;
  String? orderId;
  String? status;
  String? date;
  int? totalPrice;
  int? shippingFee;
  bool? checkOut;
  String? cancelReason;
  int? customer;

  Order(
      {this.id,
        this.orderId,
        this.status,
        this.date,
        this.totalPrice,
        this.shippingFee,
        this.checkOut,
        this.cancelReason,
        this.customer});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    status = json['status'];
    date = json['date'];
    totalPrice = json['total_price'];
    shippingFee = json['shipping_fee'];
    checkOut = json['check_out'];
    cancelReason = json['cancel_reason'];
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    data['date'] = this.date;
    data['total_price'] = this.totalPrice;
    data['shipping_fee'] = this.shippingFee;
    data['check_out'] = this.checkOut;
    data['cancel_reason'] = this.cancelReason;
    data['customer'] = this.customer;
    return data;
  }
}