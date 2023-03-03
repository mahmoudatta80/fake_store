import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_app/models/db_models/cards.dart';
import 'package:store_app/models/db_models/favourites.dart';

class DbHelper {
  Database? database;

  Future<Database?> createDatabase() async{
    if(database != null) {
      return database;
    }else {
      String path = join(await getDatabasesPath(), 'store.db');
      Database database = await openDatabase(
          path,
          version: 1,
          onCreate: (db,v) {
            db.execute('CREATE TABLE cards(id INTEGER, title TEXT, image TEXT, price REAL,counter INTEGER)');
            db.execute('CREATE TABLE favourites (id INTEGER, title TEXT, image TEXT, price REAL)');
          }
      );
      return database;
    }
  }

  //cards
  Future<int> insertToCard(CardsModel cardsModel) async{
    Database? database = await createDatabase();
    return database!.insert('cards', cardsModel.toMap());
  }

  Future<List> readAllCard() async{
    Database? database = await createDatabase();
    return database!.query('cards');
  }

  Future<int> deleteFromCard(int id) async{
    Database? database = await createDatabase();
    return database!.delete('cards',where: 'id = ?',whereArgs: [id]);
  }

  //favourites
  Future<int> insertToFavourites(FavouritesModel favouritesModel) async{
    Database? database = await createDatabase();
    return database!.insert('favourites', favouritesModel.toMap());
  }

  Future<List> readAllFavourites() async{
    Database? database = await createDatabase();
    return database!.query('favourites');
  }

  Future<int> deleteFromFavourites(int id) async{
    Database? database = await createDatabase();
    return database!.delete('favourites',where: 'id = ?',whereArgs: [id]);
  }
}