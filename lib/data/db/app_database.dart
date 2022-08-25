
import 'dart:async';

import 'package:cash_n_carry/data/db/cart_dao.dart';
import 'package:cash_n_carry/domain/models/product.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Product])
abstract class AppDatabase extends FloorDatabase{
  CartDao get cartDao;
}
