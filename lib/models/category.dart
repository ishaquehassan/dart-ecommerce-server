import 'package:alfred_test_project/base/base_model.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class Category extends BaseModel{
  int id;
  String title;
  String icon;

  Category({this.id = 0,required this.title,required this.icon});

  static box(Function(Box<Category> box) transaction){
    store((store) => transaction(store.box<Category>()));
  }

  static store(Function(Store store) transaction){
    var store = openStore();
    transaction(store);
    store.close();
  }

  int save(){
    box((box){
      var id = box.put(this);
      this.id = id;
    });
    return id;
  }

  static Category? fromBox({int? id,String? title}){
    Category? catData;
    if(id != null){
      catData = listFromBox().firstWhere((c) => c.id == id);
    }else if(title != null){
      catData = listFromBox().firstWhere((c) => c.title == title);
    }
    return catData;
  }

  static List<Category> listFromBox(){
    List<Category> categories = [];
    box((box) => categories = box.getAll());
    return categories;
  }

  void delete(){
    if(id != null){
      box((box){
        box.remove(id);
      });
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      title: map['title'] as String,
      icon: map['icon'] as String,
    );
  }
}