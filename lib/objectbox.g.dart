// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';

import 'models/category.dart';
import 'models/customer_order.dart';
import 'models/product.dart';
import 'models/user.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 6710561140052512598),
      name: 'User',
      lastPropertyId: const IdUid(5, 2731465705515962186),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4225865444865609860),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 459353931806338352),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8207178628727644771),
            name: 'phone',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1652371919602603281),
            name: 'password',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2731465705515962186),
            name: 'accessToken',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 8434588632493662923),
      name: 'Category',
      lastPropertyId: const IdUid(3, 4428559967660920730),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6785439538671170076),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4030508031879787156),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 4428559967660920730),
            name: 'icon',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 5308136717400361620),
      name: 'Product',
      lastPropertyId: const IdUid(8, 6549784868475348020),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 124710490489434657),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3183216383332318540),
            name: 'catId',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3229071822231286605),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 692543876064400945),
            name: 'unit',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 9146319890237483450),
            name: 'stockAvailable',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 450531800719387099),
            name: 'image',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 5470407319680396238),
            name: 'price',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 6549784868475348020),
            name: 'qty',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 509171822462787999),
      name: 'CustomerOrder',
      lastPropertyId: const IdUid(9, 5227654400572058488),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 246989969681041502),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7819518234981903161),
            name: 'customerId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 1795654455108527773),
            relationTarget: 'User'),
        ModelProperty(
            id: const IdUid(3, 5212646753811760401),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7603386471098345624),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7363144599176806433),
            name: 'phoneNumber',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 8886237038893778426),
            name: 'address',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 7882110451792057495),
            name: 'zip',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 9017888670110827216),
            name: 'city',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5227654400572058488),
            name: 'country',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(2, 5995319986259536989),
            name: 'items',
            targetId: const IdUid(3, 5308136717400361620))
      ],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Store openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) =>
    Store(getObjectBoxModel(),
        directory: directory,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(5, 509171822462787999),
      lastIndexId: const IdUid(2, 1795654455108527773),
      lastRelationId: const IdUid(2, 5995319986259536989),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [5898373637417550088],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        3090132506391061437,
        8522163530019221265,
        5002196926875562103,
        5617315952586991891,
        2282409210486947333,
        6857460874231775031,
        6699517207167113512,
        2830924187115245760,
        6433958162379386659
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    User: EntityDefinition<User>(
        model: _entities[0],
        toOneRelations: (User object) => [],
        toManyRelations: (User object) => {},
        getId: (User object) => object.id,
        setId: (User object, int id) {
          object.id = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          final emailOffset = fbb.writeString(object.email);
          final phoneOffset = fbb.writeString(object.phone);
          final passwordOffset = fbb.writeString(object.password);
          final accessTokenOffset = object.accessToken == null
              ? null
              : fbb.writeString(object.accessToken!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, emailOffset);
          fbb.addOffset(2, phoneOffset);
          fbb.addOffset(3, passwordOffset);
          fbb.addOffset(4, accessTokenOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = User(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              email: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              phone: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              password: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''))
            ..accessToken = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 12);

          return object;
        }),
    Category: EntityDefinition<Category>(
        model: _entities[1],
        toOneRelations: (Category object) => [],
        toManyRelations: (Category object) => {},
        getId: (Category object) => object.id,
        setId: (Category object, int id) {
          object.id = id;
        },
        objectToFB: (Category object, fb.Builder fbb) {
          final titleOffset = fbb.writeString(object.title);
          final iconOffset = fbb.writeString(object.icon);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, iconOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Category(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              title: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              icon: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''));

          return object;
        }),
    Product: EntityDefinition<Product>(
        model: _entities[2],
        toOneRelations: (Product object) => [],
        toManyRelations: (Product object) => {},
        getId: (Product object) => object.id,
        setId: (Product object, int id) {
          object.id = id;
        },
        objectToFB: (Product object, fb.Builder fbb) {
          final titleOffset = fbb.writeString(object.title);
          final unitOffset = fbb.writeString(object.unit);
          final imageOffset = fbb.writeString(object.image);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.catId);
          fbb.addOffset(2, titleOffset);
          fbb.addOffset(3, unitOffset);
          fbb.addInt64(4, object.stockAvailable);
          fbb.addOffset(5, imageOffset);
          fbb.addFloat64(6, object.price);
          fbb.addInt64(7, object.qty);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Product(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              catId: const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
              title: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              unit: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              stockAvailable:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0),
              image: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 14, ''),
              price:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 16, 0))
            ..qty = const fb.Int64Reader()
                .vTableGetNullable(buffer, rootOffset, 18);

          return object;
        }),
    CustomerOrder: EntityDefinition<CustomerOrder>(
        model: _entities[3],
        toOneRelations: (CustomerOrder object) => [object.customer],
        toManyRelations: (CustomerOrder object) =>
            {RelInfo<CustomerOrder>.toMany(2, object.id): object.items},
        getId: (CustomerOrder object) => object.id,
        setId: (CustomerOrder object, int id) {
          object.id = id;
        },
        objectToFB: (CustomerOrder object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final emailOffset = fbb.writeString(object.email);
          final phoneNumberOffset = fbb.writeString(object.phoneNumber);
          final addressOffset = fbb.writeString(object.address);
          final zipOffset = fbb.writeString(object.zip);
          final cityOffset = fbb.writeString(object.city);
          final countryOffset = fbb.writeString(object.country);
          fbb.startTable(10);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.customer.targetId);
          fbb.addOffset(2, nameOffset);
          fbb.addOffset(3, emailOffset);
          fbb.addOffset(4, phoneNumberOffset);
          fbb.addOffset(5, addressOffset);
          fbb.addOffset(6, zipOffset);
          fbb.addOffset(7, cityOffset);
          fbb.addOffset(8, countryOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = CustomerOrder(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              email: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              phoneNumber: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 12, ''),
              address: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 14, ''),
              zip: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 16, ''),
              city: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 18, ''),
              country: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 20, ''));
          object.customer.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.customer.attach(store);
          InternalToManyAccess.setRelInfo(
              object.items,
              store,
              RelInfo<CustomerOrder>.toMany(2, object.id),
              store.box<CustomerOrder>());
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// see [User.id]
  static final id = QueryIntegerProperty<User>(_entities[0].properties[0]);

  /// see [User.email]
  static final email = QueryStringProperty<User>(_entities[0].properties[1]);

  /// see [User.phone]
  static final phone = QueryStringProperty<User>(_entities[0].properties[2]);

  /// see [User.password]
  static final password = QueryStringProperty<User>(_entities[0].properties[3]);

  /// see [User.accessToken]
  static final accessToken =
      QueryStringProperty<User>(_entities[0].properties[4]);
}

/// [Category] entity fields to define ObjectBox queries.
class Category_ {
  /// see [Category.id]
  static final id = QueryIntegerProperty<Category>(_entities[1].properties[0]);

  /// see [Category.title]
  static final title =
      QueryStringProperty<Category>(_entities[1].properties[1]);

  /// see [Category.icon]
  static final icon = QueryStringProperty<Category>(_entities[1].properties[2]);
}

/// [Product] entity fields to define ObjectBox queries.
class Product_ {
  /// see [Product.id]
  static final id = QueryIntegerProperty<Product>(_entities[2].properties[0]);

  /// see [Product.catId]
  static final catId =
      QueryIntegerProperty<Product>(_entities[2].properties[1]);

  /// see [Product.title]
  static final title = QueryStringProperty<Product>(_entities[2].properties[2]);

  /// see [Product.unit]
  static final unit = QueryStringProperty<Product>(_entities[2].properties[3]);

  /// see [Product.stockAvailable]
  static final stockAvailable =
      QueryIntegerProperty<Product>(_entities[2].properties[4]);

  /// see [Product.image]
  static final image = QueryStringProperty<Product>(_entities[2].properties[5]);

  /// see [Product.price]
  static final price = QueryDoubleProperty<Product>(_entities[2].properties[6]);

  /// see [Product.qty]
  static final qty = QueryIntegerProperty<Product>(_entities[2].properties[7]);
}

/// [CustomerOrder] entity fields to define ObjectBox queries.
class CustomerOrder_ {
  /// see [CustomerOrder.id]
  static final id =
      QueryIntegerProperty<CustomerOrder>(_entities[3].properties[0]);

  /// see [CustomerOrder.customer]
  static final customer =
      QueryRelationToOne<CustomerOrder, User>(_entities[3].properties[1]);

  /// see [CustomerOrder.name]
  static final name =
      QueryStringProperty<CustomerOrder>(_entities[3].properties[2]);

  /// see [CustomerOrder.email]
  static final email =
      QueryStringProperty<CustomerOrder>(_entities[3].properties[3]);

  /// see [CustomerOrder.phoneNumber]
  static final phoneNumber =
      QueryStringProperty<CustomerOrder>(_entities[3].properties[4]);

  /// see [CustomerOrder.address]
  static final address =
      QueryStringProperty<CustomerOrder>(_entities[3].properties[5]);

  /// see [CustomerOrder.zip]
  static final zip =
      QueryStringProperty<CustomerOrder>(_entities[3].properties[6]);

  /// see [CustomerOrder.city]
  static final city =
      QueryStringProperty<CustomerOrder>(_entities[3].properties[7]);

  /// see [CustomerOrder.country]
  static final country =
      QueryStringProperty<CustomerOrder>(_entities[3].properties[8]);

  /// see [CustomerOrder.items]
  static final items =
      QueryRelationToMany<CustomerOrder, Product>(_entities[3].relations[0]);
}
