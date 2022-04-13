import 'package:alfred_test_project/base/base_model.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class Product extends BaseModel{
  int id;
  int catId;
  String title;
  String unit;
  int stockAvailable;
  String image;
  double price;
  int? qty;


  Product({this.id = 0,required this.catId,required this.title,required this.unit, this.stockAvailable = 10,required this.image,
  required this.price});

  static box(Function(Box<Product> box) transaction){
    store((store) => transaction(store.box<Product>()));
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

  static Product? fromBox({int? id,String? title,int? catId}){
    Product? prod;
    if(id != null){
      prod = listFromBox().firstWhere((c) => c.id == id);
    }else if(catId != null){
      prod = listFromBox().firstWhere((c) => c.catId == catId);
    }else if(title != null){
      prod = listFromBox().firstWhere((c) => c.title == title);
    }
    return prod;
  }

  static List<Product> listFromBox({int? catId}){
    List<Product> products = [];
    box((box) => products = box.getAll());
    return products.where((element) => catId != null ? element.catId == catId : true).toList();
  }

  void delete(){
    box((box){
      box.remove(id);
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'catId': catId,
      'title': title,
      'unit': unit,
      'stockAvailable': stockAvailable,
      'image': image,
      'price': price,
      'qty': qty,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      catId: map['catId'] as int,
      title: map['title'] as String,
      unit: map['unit'] as String,
      stockAvailable: map['stockAvailable'] as int,
      image: map['image'] as String,
      price: map['price'] as double,
    )..qty = map.containsKey("qty") ? map['qty'] as int : null;
  }
}