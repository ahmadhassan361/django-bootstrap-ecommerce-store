class MainCategories {
  Cat? cat;
  List<SubList>? subList;
  MainCategories({this.cat, this.subList});
  MainCategories.fromJson(Map<String, dynamic> json) {
    cat = json['cat'] != null ? Cat.fromJson(json['cat']) : null;
    if (json['sub_list'] != null) {
      subList = <SubList>[];
      json['sub_list'].forEach((v) {
        subList!.add(SubList.fromJson(v));
      });
    }
  }


}

class Cat {
  int? id;
  String? title;
  String? image;
  String? shortDesc;

  Cat({this.id, this.title, this.image, this.shortDesc});

  Cat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    shortDesc = json['short_desc'];
  }


}

class SubList {
  Sub? sub;
  List<SubSub>? subsublist;

  SubList({this.sub, this.subsublist});

  SubList.fromJson(Map<String, dynamic> json) {
    sub = json['sub'] != null ? Sub.fromJson(json['sub']) : null;
    if (json['subsublist'] != null) {
      subsublist = <SubSub>[];
      json['subsublist'].forEach((v) {
        subsublist!.add(new SubSub.fromJson(v));
      });
    }
  }


}

class Sub {
  int? id;
  String? title;
  int? category;

  Sub({this.id, this.title, this.category});

  Sub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category'] = this.category;
    return data;
  }
}
class SubSub {
  int? id;
  String? title;
  int? category;

  SubSub({this.id, this.title, this.category});

  SubSub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
  }


}
