import 'package:alfred_test_project/base/base_model.dart';
import 'package:alfred_test_project/models/product.dart';
import 'package:alfred_test_project/models/user.dart';
import 'package:alfred_test_project/storage/data_store.dart';
import 'package:objectbox/objectbox.dart';

import '../objectbox.g.dart';

@Entity()
class CustomerOrder extends BaseModel {
  int id;
  final customer = ToOne<User>();
  final items = ToMany<Product>();
  String name;
  String email;
  String phoneNumber;
  String address;
  String zip;
  String city;
  String country;

  CustomerOrder(
      {this.id = 0,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.address,
      required this.zip,
      required this.city,
      required this.country});

  static box(Function(Box<CustomerOrder> box) transaction) {
    store((store) => transaction(store.box<CustomerOrder>()));
  }

  static store(Function(Store store) transaction) async {
    var store = DataStore.getStore();
    transaction(store);
    await Future.delayed(Duration(milliseconds: 1));
    store.close();
  }

  int save() {
    box((box) {
      var id = box.put(this);
      this.id = id;
    });
    return id;
  }

  static CustomerOrder? fromBox({int? id, int? uid}) {
    CustomerOrder? orderData;
    if (id != null) {
      orderData = listFromBox().firstWhere((c) => c.id == id);
    } else if (uid != null) {
      orderData = listFromBox().firstWhere((c) => c.customer.target?.id == uid);
    }
    return orderData;
  }

  static List<CustomerOrder> listFromBox({int? uid}) {
    List<CustomerOrder> orders = [];
    box((box) => orders = box.getAll());
    return orders
        .where((element) =>
            uid != null ? element.customer.target?.id == uid : true)
        .toList();
  }

  void delete() {
    box((box) {
      box.remove(id);
    });
  }

  @override
  Map<String, dynamic> toMap() {
    var res = {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'zip': zip,
      'city': city,
      'country': country,
      'customer': customer.target?.toMap(),
    };
    res['items'] = <Map<String, dynamic>>[];
    for (var element in items) {
      (res['items'] as List<Map<String, dynamic>>).add(element.toMap());
    }
    return res;
  }

  factory CustomerOrder.fromMap(Map<String, dynamic> map) {
    return CustomerOrder(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      zip: map['zip'] as String,
      city: map['city'] as String,
      country: map['country'] as String,
    );
  }
}
