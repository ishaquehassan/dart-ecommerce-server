import 'package:alfred_test_project/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

abstract class DataStore {
  static Store getStore() => openStore(directory: "../data/");
}
