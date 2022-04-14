import 'package:alfred_test_project/base/base_model.dart';
import 'package:alfred_test_project/storage/data_store.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class User extends BaseModel {
  int id;
  String email;
  String phone;
  String password;
  String? accessToken;

  User(
      {this.id = 0,
      required this.email,
      required this.phone,
      required this.password});

  static box(Function(Box<User> box) transaction) {
    store((store) => transaction(store.box<User>()));
  }

  static store(Function(Store store) transaction) {
    var store = DataStore.getStore();
    transaction(store);
    store.close();
  }

  int save() {
    box((box) {
      var id = box.put(this);
      this.id = id;
    });
    return id;
  }

  static User? fromBox(
      {int? id,
      String? email,
      String? password,
      String? phone,
      String? accessToken}) {
    User? userData;
    if (id != null) {
      userData = listFromBox().firstWhere((u) => u.id == id);
    } else if (email != null && password != null) {
      userData = listFromBox()
          .firstWhere((u) => u.email == email && u.password == password);
    } else if (email != null && phone != null) {
      userData =
          listFromBox().firstWhere((u) => u.email == email && u.phone == phone);
    } else if (email != null) {
      userData = listFromBox().firstWhere((u) => u.email == email);
    } else if (phone != null) {
      userData = listFromBox().firstWhere((u) => u.phone == phone);
    } else if (accessToken != null) {
      userData = listFromBox().firstWhere((u) => u.accessToken == accessToken);
    }
    return userData;
  }

  static List<User> listFromBox() {
    List<User> users = [];
    box((box) => users = box.getAll());
    return users;
  }

  void delete() {
    if (id != null) {
      box((box) {
        box.remove(id);
      });
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'phone': this.phone,
      'password': this.password,
      "accessToken": this.accessToken
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] as int,
        email: map['email'] as String,
        phone: map['phone'] as String,
        password: map['password'] as String);
  }
}
