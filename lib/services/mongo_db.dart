import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

const mongoDBConnectinoString = 'YOUR CONNECTION STRING';
const userName = 'YOUR USER NAME';
const password = 'PASSWORD';
const transactionsCollectionName = 'transactions';
const notesCollectionName = 'notes';
const serviceProvidersCollectionName = 'service providers';
const agenciesCollectionName = 'agencies';
const notersCollectionName = 'noters';

class MongoDbAPI {
  static Db? _db;
  static init() async {
    _db = await Db.create(mongoDBConnectinoString);
    await _db!.open();
    inspect(_db);
  }

  static Db? get db => _db;
}
