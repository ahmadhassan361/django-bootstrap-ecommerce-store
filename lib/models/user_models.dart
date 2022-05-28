class AuthModel {
  String? token;
  Customer? customer;

  AuthModel({this.token, this.customer});

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  User? user;
  String? fullname;
  String? mobileNo;
  String? address;
  String? city;
  String? zipcode;
  String? province;

  Customer(
      {this.id,
        this.user,
        this.fullname,
        this.mobileNo,
        this.address,
        this.city,
        this.zipcode,
        this.province});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    fullname = json['fullname'];
    mobileNo = json['mobile_no'];
    address = json['address'];
    city = json['city'];
    zipcode = json['zipcode'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['fullname'] = fullname;
    data['mobile_no'] = mobileNo;
    data['address'] = address;
    data['city'] = city;
    data['zipcode'] = zipcode;
    data['province'] = province;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  bool? isActive;

  User({this.id, this.username, this.email, this.isActive});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['is_active'] = isActive;
    return data;
  }
}