import 'package:alfred_test_project/base/base_model.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class User extends BaseModel{
  int id;
  String email;
  String phone;
  String password;

  User({this.id = 0,required this.email,required this.phone,required this.password});

  static Box<User> box(){
    var store = openStore();
    Box<User> userBox = store.box<User>();
    store.close();
    return userBox;
  }



  int save(){
    var id  = box().put(this);
    this.id = id;
    return id;
  }

  static User? fromBox({int? id,String? email}){
    User? userData;
    QueryBuilder<User>? user;
    if(id != null){
      user = box().query(User_.id.equals(id));
    }else if(email != null){
      user = box().query(User_.email.equals(email));
    }
    userData = user?.build().findFirst();
    return userData;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'phone': this.phone,
      'password': this.password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      email: map['email'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }
}