// import 'dart:convert';
// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// import '../../Modules/Book Subjects and View/Models/topic_model.dart';
// import '../../Modules/Category/Models/category_model.dart';
// import '../../Modules/Home/Model/latest_book_model.dart';
// import '../../Modules/Home/Model/slider_model.dart';

// class DBProvider {
//   static Database? _database;
//   static final DBProvider db = DBProvider._();

//   DBProvider._();

//   Future<Database> get database async {
//     // If database exists, return database
//     if (_database != null) return _database!;
//     // If database don't exists, create one
//     _database = await initDB();
//     return _database!;
//   }

//   Future<bool> databaseExists() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     final path = join(documentsDirectory.path, 'learninghut.db');
//     return databaseFactory.databaseExists(path);
//   }

//   // Create the database and the Employee table
//   initDB() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     final path = join(documentsDirectory.path, 'learninghut.db');
//     return await openDatabase(path, version: 1, onOpen: (db) {},
//         onCreate: (Database db, int version) async {
//       //TODO Latest Book Table
//       await db.execute('CREATE TABLE LatestBook('
//           'id INTEGER PRIMARY KEY,'
//           'name TEXT,'
//           'image TEXT,'
//           'is_free INTEGER,'
//           'description TEXT,'
//           'category_id INTEGER,'
//           'language_id INTEGER,'
//           'created_at TEXT,'
//           'updated_at TEXT,'
//           'chapters TEXT,'
//           'category_name TEXT,'
//           'category_image TEXT,'
//           'language_name TEXT,'
//           'language_image TEXT'
//           ')');

//       //TODO Topics Table
//       await db.execute('CREATE TABLE Topics('
//           'id INTEGER PRIMARY KEY,'
//           'title TEXT,'
//           'bookId INTEGER,'
//           'chapterId INTEGER,'
//           'content TEXT'
//           ')');

//       //TODO Favourite Table
//       await db.execute('CREATE TABLE Favourite('
//           'id INTEGER PRIMARY KEY,'
//           'title TEXT,'
//           'bookId INTEGER,'
//           'chapterId INTEGER,'
//           'content TEXT'
//           ')');

//       //TODO Categories Table
//       await db.execute('CREATE TABLE Categories('
//           'id INTEGER PRIMARY KEY,'
//           'name TEXT,'
//           'image TEXT,'
//           'createdAt TEXT,'
//           'updatedAt TEXT'
//           ')');

//       //TODO Languages Table
//       await db.execute('CREATE TABLE Languages('
//           'id INTEGER,'
//           'name TEXT,'
//           'image TEXT,'
//           'createdAt TEXT,'
//           'updatedAt TEXT,'
//           'category_id INTEGER'
//           ')');

//       //TODO Books Table
//       await db.execute('CREATE TABLE Books('
//           'id INTEGER PRIMARY KEY,'
//           'name TEXT,'
//           'image TEXT,'
//           'is_free INTEGER,'
//           'description TEXT,'
//           'category_id INTEGER,'
//           'language_id INTEGER,'
//           'created_at TEXT,'
//           'updated_at TEXT,'
//           'chapters TEXT,'
//           'category_name TEXT,'
//           'category_image TEXT,'
//           'language_name TEXT,'
//           'language_image TEXT'
//           ')');

//       //TODO Slider Table
//       await db.execute('CREATE TABLE Sliders('
//           'id INTEGER PRIMARY KEY,'
//           'image TEXT,'
//           'url TEXT,'
//           'createdAt TEXT,'
//           'updatedAt TEXT'
//           ')');
//     });
//   }

//   createTABLE(String name) async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     final path = join(documentsDirectory.path, 'learninghut.db');
//     return await openDatabase(path, version: 1, onOpen: (db) {},
//         onCreate: (Database db, int version) async {
//       await db.execute('CREATE TABLE $name('
//           'id INTEGER PRIMARY KEY,'
//           '${name.toLowerCase()} TEXT'
//           ')');
//     });
//   }

//   //TODO <= <= <= <= <= <= <= <=  LatestBook  Table  => => => => => => => =>
//   createLatestBook(
//     LatestBook data,
//   ) async {
//     final db = await database;
//     final res = await db.insert(
//         'LatestBook',
//         {
//           'id': data.id,
//           'name': data.name,
//           'image': data.image,
//           'is_free': data.isFree,
//           'description': data.description,
//           'category_id': data.categoryId,
//           'language_id': data.languageId,
//           'created_at': data.createdAt,
//           'updated_at': data.updatedAt,
//           'chapters': json.encode(Chapter.chapterToJsonList(
//               data.chapters)), //jsonEncode(data.chapters),
//           'category_name': data.category.name,
//           'category_image': data.category.image,
//           'language_name': data.language.name,
//           'language_image': data.language.image,
//         },
//         conflictAlgorithm: ConflictAlgorithm.ignore);
//     print("LatestBook Inserted Successfully");
//     return res;
//   }

//   deleteAllLatestBook() async {
//     final db = await database;
//     final res = await db.rawQuery("DELETE FROM LatestBook");
//   }

//   Future<List<LatestBook>> getLatestBookList() async {
//     final db = await database;
//     final res = await db.rawQuery("SELECT * FROM LatestBook");
//     return LatestBook.jsonToServiceModelListDataBase(res);
//   }

//   setLatestBookList(List<LatestBook> data) {
//     for (int i = 0; i < data.length; i++) {
//       createLatestBook(data[i]);
//     }
//   }

//   //TODO <= <= <= <= <= <= <= <=  Categories  Table  => => => => => => => =>
//   createCategories(
//     CategoryModel data,
//   ) async {
//     final db = await database;
//     final res = await db.insert(
//         'Categories',
//         {
//           'id': data.id,
//           'name': data.name,
//           'image': data.image,
//           'createdAt': data.createdAt,
//           'updatedAt': data.updatedAt,
//         },
//         conflictAlgorithm: ConflictAlgorithm.ignore);
//     print("Categories Inserted Successfully");
//     return res;
//   }

//   deleteAllCategories() async {
//     final db = await database;
//     final res = await db.rawQuery("DELETE FROM Categories");
//   }

//   Future<List<CategoryModel>> getCategoriesList() async {
//     final db = await database;
//     final res = await db.rawQuery("SELECT * FROM Categories");
//     return CategoryModel.jsonToServiceModelList(res);
//   }

//   setCategoriesList(List<CategoryModel> data) {
//     for (int i = 0; i < data.length; i++) {
//       createCategories(data[i]);
//     }
//   }

//   //TODO <= <= <= <= <= <= <= <=  Slider  Table  => => => => => => => =>
//   createSlider(
//     SliderModel data,
//   ) async {
//     final db = await database;
//     final res = await db.insert(
//         'Sliders',
//         {
//           'id': data.id,
//           'image': data.image,
//           'url': data.url,
//           'createdAt': data.createdAt,
//           'updatedAt': data.updatedAt,
//         },
//         conflictAlgorithm: ConflictAlgorithm.ignore);
//     print("SliderModel Inserted Successfully");
//     return res;
//   }

//   deleteAllSlider() async {
//     final db = await database;
//     final res = await db.rawQuery("DELETE FROM Sliders");
//   }

//   Future<List<SliderModel>> getSliderList() async {
//     final db = await database;
//     final res = await db.rawQuery("SELECT * FROM Sliders");
//     return SliderModel.jsonToServiceModelList(res);
//   }

//   setSliderList(List<SliderModel> data) {
//     for (int i = 0; i < data.length; i++) {
//       createSlider(data[i]);
//     }
//   }

//   //TODO <= <= <= <= <= <= <= <=  Languages  Table  => => => => => => => =>
//   createLanguage(
//     CategoryModel data,
//     int categoryID,
//   ) async {
//     final db = await database;
//     final res = await db.insert(
//         'Languages',
//         {
//           'id': data.id,
//           'name': data.name,
//           'image': data.image,
//           'createdAt': data.createdAt,
//           'updatedAt': data.updatedAt,
//           'category_id': categoryID,
//         },
//         conflictAlgorithm: ConflictAlgorithm.ignore);
//     print("Languages Inserted Successfully");
//     return res;
//   }

//   deleteAllLanguages() async {
//     final db = await database;
//     final res = await db.rawQuery("DELETE FROM Languages");
//   }

//   languagesLengthExistInTable({required int categoryID}) async {
//     final db = await database;
//     int count = Sqflite.firstIntValue(await db.rawQuery(
//         "SELECT COUNT(*) FROM Languages WHERE category_id = $categoryID"))!;
//     print("count => $count");
//     return count;
//   }

//   Future<List<CategoryModel>> getLanguagesList(
//       {required int categoryID}) async {
//     final db = await database;
//     final res = await db
//         .rawQuery("SELECT * FROM Languages WHERE category_id = $categoryID");
//     return CategoryModel.jsonToServiceModelList(res);
//   }

//   setLanguagesList(List<CategoryModel> data, int categoryID) {
//     for (int i = 0; i < data.length; i++) {
//       createLanguage(data[i], categoryID);
//       print("=> => ${data[i]} === $categoryID");
//     }
//   }

//   //TODO <= <= <= <= <= <= <= <=  LatestBook  Table  => => => => => => => =>
//   createBook(
//     LatestBook data,
//   ) async {
//     final db = await database;
//     final res = await db.insert(
//         'Books',
//         {
//           'id': data.id,
//           'name': data.name,
//           'image': data.image,
//           'is_free': data.isFree,
//           'description': data.description,
//           'category_id': data.categoryId,
//           'language_id': data.languageId,
//           'created_at': data.createdAt,
//           'updated_at': data.updatedAt,
//           'chapters': json.encode(Chapter.chapterToJsonList(data.chapters)),
//           'category_name': data.category.name,
//           'category_image': data.category.image,
//           'language_name': data.language.name,
//           'language_image': data.language.image,
//         },
//         conflictAlgorithm: ConflictAlgorithm.ignore);
//     print("LatestBook Inserted Successfully");
//     return res;
//   }

//   deleteAllBooks() async {
//     final db = await database;
//     final res = await db.rawQuery("DELETE FROM Books");
//   }

//   Future<List<LatestBook>> getBooksList({
//     required int languageID,
//     required int categoryID,
//   }) async {
//     final db = await database;
//     final res = await db.rawQuery(
//         "SELECT * FROM Books WHERE language_id = $languageID AND category_id = $categoryID");
//     return LatestBook.jsonToServiceModelListDataBase(res);
//   }

//   setBooksList(List<LatestBook> data) {
//     for (int i = 0; i < data.length; i++) {
//       createBook(data[i]);
//     }
//   }

//   //TODO <= <= <= <= <= <= <= <=  Topics  Table  => => => => => => => =>
//   createTopic(
//     TopicModel data,
//   ) async {
//     final db = await database;
//     final res = await db.insert(
//         'Topics',
//         {
//           'id': data.id,
//           'title': data.title,
//           'bookId': data.bookId,
//           'chapterId': data.chapterId,
//           'content': data.content,
//         },
//         conflictAlgorithm: ConflictAlgorithm.ignore);
//     print("Topics Inserted Successfully");
//     return res;
//   }

//   Future<List<TopicModel>> getTopicsList({
//     required int chapterId,
//     required int bookId,
//   }) async {
//     final db = await database;
//     final res = await db.rawQuery(
//         "SELECT * FROM Topics WHERE bookId = $bookId AND chapterId = $chapterId");
//     return TopicModel.jsonToServiceModelList(res);
//   }

//   topicLengthExistInTable({
//     required int chapterId,
//     required int bookId,
//   }) async {
//     final db = await database;
//     int count = Sqflite.firstIntValue(await db.rawQuery(
//         "SELECT COUNT(*) FROM Topics WHERE bookId = $bookId AND chapterId = $chapterId"))!;
//     return count;
//   }

//   setTopicsList(List<TopicModel> data) {
//     for (int i = 0; i < data.length; i++) {
//       createTopic(data[i]);
//     }
//   }

//   //TODO <= <= <= <= <= <= <= <=  Favourite  Table  => => => => => => => =>
//   setFavourite(
//     TopicModel data,
//   ) async {
//     final db = await database;
//     final res = await db.insert(
//         'Favourite',
//         {
//           'id': data.id,
//           'title': data.title,
//           'bookId': data.bookId,
//           'chapterId': data.chapterId,
//           'content': data.content,
//         },
//         conflictAlgorithm: ConflictAlgorithm.ignore);
//     print("Topics Inserted Successfully");
//     return res;
//   }

//   Future<List<TopicModel>> getFavouriteList() async {
//     final db = await database;
//     final res = await db.rawQuery("SELECT * FROM Favourite");
//     return TopicModel.jsonToServiceModelList(res);
//   }

//   deleteFavourite({
//     required int topicID,
//   }) async {
//     final db = await database;
//     final res = await db.rawQuery("DELETE FROM Favourite WHERE id = $topicID");
//     print("Delete Successfully");
//   }

//   favouriteExistInTable({
//     required int topicID,
//   }) async {
//     final db = await database;
//     int count = Sqflite.firstIntValue(await db
//         .rawQuery("SELECT COUNT(*) FROM Favourite WHERE id = $topicID"))!;
//     return count == 0 ? false : true;
//   }

//   // setFavouriteList(List<TopicModel> data) {
//   //   for (int i = 0; i < data.length; i++) {
//   //     createFavourite(data[i]);
//   //   }
//   // }

//   // ///TODO: Location  DB ===================================================>>
//   // createLocation(
//   //   ServiceLocation location,
//   // ) async {
//   //   final db = await database;
//   //
//   //   final res = await db.insert(
//   //       'Location',
//   //       {
//   //         'id': location.id,
//   //         'title': location.title,
//   //       },
//   //       conflictAlgorithm: ConflictAlgorithm.ignore);
//   //   return res;
//   // }
//   //
//   // deleteAllLocation() async {
//   //   final db = await database;
//   //   final res = await db.rawQuery("DELETE FROM Location");
//   // }
//   //
//   // Future<List<ServiceLocation>> getLocationList() async {
//   //   final db = await database;
//   //   final res = await db.rawQuery("SELECT * FROM Location");
//   //
//   //   return ServiceLocation.jsonToServiceLocationList(res);
//   // }
//   //
//   // setLocationList(List<ServiceLocation> location) {
//   //   for (int i = 0; i < location.length; i++) {
//   //     createLocation(location[i]);
//   //   }
//   // }
//   //
//   // ///TODO: Interest  DB
//   // createInterests(
//   //   InterestModel interestModel,
//   // ) async {
//   //   final db = await database;
//   //
//   //   final res = await db.insert(
//   //       'Interests',
//   //       {
//   //         'id': interestModel.id,
//   //         // 'modifiedBy': interestModel.modifiedBy,
//   //         // 'createdBy': interestModel.createdBy,
//   //         'name': interestModel.name,
//   //         'photoUrl': interestModel.photoUrl,
//   //         'isActive': interestModel.isActive ? 1 : 0,
//   //       },
//   //       conflictAlgorithm: ConflictAlgorithm.ignore);
//   //   return res;
//   // }
//   //
//   // deleteAllInterests() async {
//   //   final db = await database;
//   //   final res = await db.rawQuery("DELETE FROM Interests");
//   // }
//   //
//   // Future<List<InterestModel>> getInterestsList() async {
//   //   final db = await database;
//   //   final res = await db.rawQuery("SELECT * FROM Interests");
//   //
//   //   return InterestModel.localToInterestList(res);
//   // }
//   //
//   // setInterestsList(List<InterestModel> interests) {
//   //   for (int i = 0; i < interests.length; i++) {
//   //     createInterests(interests[i]);
//   //   }
//   // }
//   //
//   // ///TODO: Banners  DB
//   //
//   // createBanners(
//   //   BannerModel bannerModel,
//   // ) async {
//   //   final db = await database;
//   //
//   //   final res = await db.insert(
//   //       'Banners',
//   //       {
//   //         'id': bannerModel.id,
//   //         // 'modifiedBy': bannerModel.modifiedBy,
//   //         // 'createdBy': bannerModel.createdBy,
//   //         'name': bannerModel.name,
//   //         'photoUrl': bannerModel.photoUrl,
//   //         'isActive': bannerModel.isActive ? 1 : 0,
//   //       },
//   //       conflictAlgorithm: ConflictAlgorithm.ignore);
//   //   return res;
//   // }
//   //
//   // deleteAllBanners() async {
//   //   final db = await database;
//   //   final res = await db.rawQuery("DELETE FROM Banners");
//   // }
//   //
//   // Future<List<BannerModel>> getBannersList() async {
//   //   final db = await database;
//   //   final res = await db.rawQuery("SELECT * FROM Banners");
//   //
//   //   return BannerModel.localToBannersList(res);
//   // }
//   //
//   // setBannersList(List<BannerModel> Banners) {
//   //   for (int i = 0; i < Banners.length; i++) {
//   //     createBanners(Banners[i]);
//   //   }
//   // }
//   //
//   // ///TODO: Categories  DB
//   //
//   // createCategories(
//   //   CategoryModel categoryModel,
//   // ) async {
//   //   final db = await database;
//   //
//   //   final res = await db.insert(
//   //       'Categories',
//   //       {
//   //         'id': categoryModel.id,
//   //         'modifiedBy': categoryModel.modifiedBy,
//   //         'createdBy': categoryModel.createdBy,
//   //         'name': categoryModel.name,
//   //         'photoUrl': categoryModel.photoUrl,
//   //         'isActive': categoryModel.isActive ? 1 : 0,
//   //       },
//   //       conflictAlgorithm: ConflictAlgorithm.ignore);
//   //   return res;
//   // }
//   //
//   // deleteAllCategories() async {
//   //   final db = await database;
//   //   final res = await db.rawQuery("DELETE FROM Categories");
//   // }
//   //
//   // Future<List<CategoryModel>> getCategoriesList() async {
//   //   final db = await database;
//   //   final res = await db.rawQuery("SELECT * FROM Categories");
//   //
//   //   return CategoryModel.localToCategoriesList(res);
//   // }
//   //
//   // setCategoriesList(List<CategoryModel> Categories) {
//   //   for (int i = 0; i < Categories.length; i++) {
//   //     createCategories(Categories[i]);
//   //   }
//   // }

//   // TODO Extra Down Files ====================================================>

// // // product model DB  on database
// // createProduct(
// //   ProductModel productModel,
// //   bool isFeaturedProducts,
// // ) async {
// //   final db = await database;
// //   final res = await db.insert('Products', {
// //     'id': productModel.id,
// //     'name': productModel.name,
// //     'rating': productModel.rating,
// //     'featured': isFeaturedProducts ? 1 : 0,
// //     'price': productModel.price,
// //     'categoryId': productModel.categoryId,
// //     'disco
// //     unted_price': productModel.discountedPrice,
// //     'discount': productModel.discount,
// //     // 'category_id': productModel.categoryId,
// //     'image': productModel.variantsImages.isNotEmpty
// //         ? productModel.variantimg_basepath +
// //             productModel.variantsImages.first.img
// //         : productModel.variantimg_basepath,
// //   });
// //
// //   // final res = await db.rawInsert(
// //   // 'INSERT INTO Products(id, name, rating,price,categoryId,discounted_price,discount,image) VALUES(${productModel.id}, ${productModel.name}, ${productModel.rating},${productModel.price},${categoryID},${productModel.discountedPrice},${productModel.discount},${productModel.variantimg_basepath + productModel.variantsImages.first.img}) WHERE NOT EXISTS(SELECT 1 FROM Products WHERE id = ${productModel.id})');
// //   return res;
// // }
// //
// // // product model DB  on database
// // createCategoryProducts(
// //   ProductModel productModel,
// //   String categoryID,
// // ) async {
// //   final db = await database;
// //   final res = await db.insert('CategoryProducts', {
// //     'id': productModel.id,
// //     'name': productModel.name,
// //     'rating': productModel.rating,
// //     'price': productModel.price,
// //     'categoryId': productModel.categoryId,
// //     'discounted_price':productModel.discountedPrice,
// //     'discount': productModel.discount,
// //     'category_id': categoryID,
// //     'image': productModel.variantsImages.isNotEmpty
// //         ? productModel.variantimg_basepath +
// //             productModel.variantsImages.first.img
// //         : productModel.variantimg_basepath,
// //   });
// //
// //   // final res = await db.rawInsert(
// //   // 'INSERT INTO Products(id, name, rating,price,categoryId,discounted_price,discount,image) VALUES(${productModel.id}, ${productModel.name}, ${productModel.rating},${productModel.price},${categoryID},${productModel.discountedPrice},${productModel.discount},${productModel.variantimg_basepath + productModel.variantsImages.first.img}) WHERE NOT EXISTS(SELECT 1 FROM Products WHERE id = ${productModel.id})');
// //   return res;
// // }
// //
// // // Category DB  on database
// // createCategory(
// //   CategoryModel categoryModel,
// // ) async {
// //   final db = await database;
// //   final res = await db.insert('Categories', {
// //     'id': categoryModel.id,
// //     'name': categoryModel.name,
// //     'image': categoryModel.image,
// //     'catbanner2': categoryModel.catbanner2,
// //     'catbanner1': categoryModel.catbanner1,
// //   });
// //   return res;
// // }
// //
// // // Category DB  on database
// // createSubCategory(
// //   CategoryModel categoryModel,
// //   String categoryID,
// // ) async {
// //   final db = await database;
// //   final res = await db.insert('SubCategories', {
// //     'id': categoryModel.id,
// //     'name': categoryModel.name,
// //     'image': categoryModel.image,
// //     'categoryId': categoryID,
// //     'catbanner2': categoryModel.catbanner2,
// //     'catbanner1': categoryModel.catbanner1,
// //   });
// //   return res;
// // }
// //
// // // Future<void> deleteProduct(String productID) async {
// // //   final db = await database;
// // //   await db.delete(
// // //     'Products',
// // //     where: 'id = $productID',
// // //   );
// // // }
// //
// // Future<void> deleteCategory(String categori_id) async {
// //   final db = await database;
// //   await db.delete(
// //     'Categories',
// //     where: 'id = $categori_id',
// //   );
// // }
// //
// // Future<void> deleteSubCategory(String categori_id) async {
// //   final db = await database;
// //   await db.delete(
// //     'SubCategories',
// //     where: 'id = $categori_id',
// //   );
// // }
// //
// // // updateCategory(
// // //   CategoryModel categoryModel,
// // // ) async {
// // //   final db = await database;
// // //   final res = await db.update(
// // //       'Categories',
// // //       {
// // //         'id': categoryModel.id,
// // //         'name': categoryModel.id,
// // //         'name_ar': categoryModel.id,
// // //         'order_by': categoryModel.id,
// // //         'p_id': categoryModel.id,
// // //         'sort_order': categoryModel.id,
// // //         'featured': categoryModel.id,
// // //         'status': categoryModel.id,
// // //         'catbanner2': categoryModel.id,
// // //         'catbanner1': categoryModel.id,
// // //       },
// // //       where: 'id = ?',
// // //       whereArgs: [categoryModel.id]);
// // //   return res;
// // // }
// //
// // getCategoriesList() async {
// //   List<CategoryModel> categories = [];
// //   final db = await database;
// //   final res = await db.rawQuery("SELECT * FROM Categories");
// //   // final res = await db.rawQuery("SELECT home FROM Home WHERE id=0");
// //   for (int i = 0; i < res.length; i++) {
// //     List<CategoryModel> subCategories = [];
// //     List<ProductModel> products = [];
// //     subCategories = await getSubCategoriesList(res[i]["id"].toString());
// //     // products = await getProductsList(res[i]["id"].toString());
// //     categories.add(CategoryModel(
// //       id: res[i]["id"].toString(),
// //       image: res[i]["image"].toString(),
// //       name: res[i]["name"].toString(),
// //       status: 0,
// //       catbanner1: res[i]["catbanner1"].toString(),
// //       catbanner2: res[i]["catbanner2"].toString(),
// //       featured: 0,
// //       name_ar: "",
// //       order_by: "",
// //       p_id: "",
// //       cat_brands: [],
// //       products: [],
// //       sort_order: 0,
// //       sub_cat: subCategories,
// //     ));
// //   }
// //   return categories;
// // }
// //
// // Future<List<ProductModel>> getProductsList(bool isFeaturedProducts) async {
// //   final db = await database;
// //   if (isFeaturedProducts) {
// //     int featured = 1;
// //     final res = await db.rawQuery(
// //         "SELECT * FROM Products WHERE featured LIKE '%${featured}%'");
// //     return ProductModel.localToProductModelList(res);
// //   } else {
// //     int featured = 0;
// //     final res = await db.rawQuery(
// //         "SELECT * FROM Products WHERE featured LIKE '%${featured}%'");
// //     return ProductModel.localToProductModelList(res);
// //   }
// //   // final res = await db.rawQuery(
// //   // "SELECT * FROM Products WHERE categoryId LIKE '%$categoryId%'");
// // }
// //

// //
// // Future<List<ProductModel>> getCategoryProductsList(String categoryID) async {
// //   final db = await database;
// //   final res = await db.rawQuery(
// //       "SELECT * FROM CategoryProducts WHERE category_id LIKE '%$categoryID%'");
// //
// //   return ProductModel.localToProductModelList(res);
// // }
// //
// // Future<List<CategoryModel>> getSubCategoriesList(String categoryId) async {
// //   List<CategoryModel> categories = [];
// //   final db = await database;
// //   final res = await db.rawQuery(
// //       "SELECT * FROM SubCategories WHERE categoryId LIKE '%$categoryId%'");
// //
// //   // .rawQuery("SELECT * FROM SubCategories WHERE categoryId=${categoryId}");
// //   // final res = await db.rawQuery("SELECT home FROM Home WHERE id=0");
// //   for (int i = 0; i < res.length; i++) {
// //     categories.add(CategoryModel(
// //       id: res[i]["id"].toString(),
// //       image: res[i]["image"].toString(),
// //       name: res[i]["name"].toString(),
// //       status: 0,
// //       catbanner1: res[i]["catbanner1"].toString(),
// //       catbanner2: res[i]["catbanner2"].toString(),
// //       featured: 0,
// //       name_ar: "",
// //       order_by: "",
// //       p_id: "",
// //       cat_brands: [],
// //       products: [],
// //       sort_order: 0,
// //       sub_cat: [],
// //     ));
// //   }
// //   return categories;
// // }
// //
// // setCategoriesList(List<CategoryModel> categories) {
// //   for (int i = 0; i < categories.length; i++) {
// //     createCategory(categories[i]);
// //     if (categories[i].sub_cat.isNotEmpty) {
// //       print("set subcategories by categories");
// //       setSubCategoriesList(categories[i].sub_cat, categories[i].id);
// //     }
// //     // if ((categories[i].products.isNotEmpty)) {
// //     //   print("set product by categories");
// //     //   print(categories[i].products);
// //     //   setProductList(categories[i].products, categories[i].id);
// //     // }
// //   }
// // }
// //
// // setProductList(
// //   List<ProductModel> products,
// //   bool isFeaturedProducts,
// // ) {
// //   for (int i = 0; i < products.length; i++) {
// //     createProduct(products[i], isFeaturedProducts);
// //   }
// // }
// //

// //
// // setCategoryProductsList(List<ProductModel> products, String categoryID) {
// //   for (int i = 0; i < products.length; i++) {
// //     createCategoryProducts(
// //       products[i],
// //       categoryID,
// //     );
// //   }
// // }
// //
// // setSubCategoriesList(List<CategoryModel> categories, String categoryID) {
// //   for (int i = 0; i < categories.length; i++) {
// //     createSubCategory(categories[i], categoryID);
// //   }
// // }
// //
// // deleteAllSUbCategories() async {
// //   final db = await database;
// //   final res = await db.rawQuery("DELETE FROM SubCategories");
// // }
// //

// //
// // deleteAllCategories() async {
// //   final db = await database;
// //   final res = await db.rawQuery("DELETE FROM Categories");
// // }
// //
// // deleteAllHomeSUbCategories() async {
// //   final db = await database;
// //   final res = await db.rawQuery("DELETE FROM HomeSubCategories");
// // }
// //
// // deleteAllHomeCategories() async {
// //   final db = await database;
// //   final res = await db.rawQuery("DELETE FROM HomeCategories");
// // }
// //
// // deleteAllProducts() async {
// //   final db = await database;
// //   final res = await db.rawQuery("DELETE FROM Products");
// // }
// //
// // deleteAllCategoryProducts() async {
// //   final db = await database;
// //   final res = await db.rawQuery("DELETE FROM CategoryProducts");
// // }
// // deleteAllTables(){
// //   deleteAllSUbCategories();
// //   deleteAllCategoryProducts();
// //   deleteAllProducts();
// //   deleteAllHomeCategories();
// //   deleteAllHomeSUbCategories();
// //   deleteAllCategories();
// //   deleteAllBanners();
// // }
// // // Category DB  on database
// // createHomeCategory(
// //   CategoryModel categoryModel,
// // ) async {
// //   final db = await database;
// //   final res = await db.insert('HomeCategories', {
// //     'id': categoryModel.id,
// //     'name': categoryModel.name,
// //     'image': categoryModel.image,
// //     'catbanner2': categoryModel.catbanner2,
// //     'catbanner1': categoryModel.catbanner1,
// //   });
// //   return res;
// // }
// //
// // // Category DB  on database
// // createHomeSubCategory(
// //   CategoryModel categoryModel,
// //   String categoryID,
// // ) async {
// //   final db = await database;
// //   final res = await db.insert('HomeSubCategories', {
// //     'id': categoryModel.id,
// //     'name': categoryModel.name,
// //     'image': categoryModel.image,
// //     'categoryId': categoryID,
// //     'catbanner2': categoryModel.catbanner2,
// //     'catbanner1': categoryModel.catbanner1,
// //   });
// //   return res;
// // }
// //
// // setHomeCategoriesList(List<CategoryModel> categories) {
// //   for (int i = 0; i < categories.length; i++) {
// //     createHomeCategory(categories[i]);
// //     if (categories[i].sub_cat.isNotEmpty) {
// //       setHomeSubCategoriesList(categories[i].sub_cat, categories[i].id);
// //     }
// //     if ((categories[i].products.isNotEmpty)) {
// //       print("set product by categories");
// //       setCategoryProductsList(categories[i].products, categories[i].id);
// //     }
// //   }
// // }
// //
// // setHomeSubCategoriesList(List<CategoryModel> categories, String categoryID) {
// //   for (int i = 0; i < categories.length; i++) {
// //     createHomeSubCategory(categories[i], categoryID);
// //   }
// // }
// //
// // getHomeCategoriesList() async {
// //   List<CategoryModel> categories = [];
// //   final db = await database;
// //   final res = await db.rawQuery("SELECT * FROM HomeCategories");
// //   // final res = await db.rawQuery("SELECT home FROM Home WHERE id=0");
// //   for (int i = 0; i < res.length; i++) {
// //     List<CategoryModel> subCategories = [];
// //     List<ProductModel> products = [];
// //     subCategories = await getHomeSubCategoriesList(res[i]["id"].toString());
// //     products = await getCategoryProductsList(res[i]["id"].toString());
// //     categories.add(CategoryModel(
// //       id: res[i]["id"].toString(),
// //       image: res[i]["image"].toString(),
// //       name: res[i]["name"].toString(),
// //       status: 0,
// //       catbanner1: res[i]["catbanner1"].toString(),
// //       catbanner2: res[i]["catbanner2"].toString(),
// //       featured: 0,
// //       name_ar: "",
// //       order_by: "",
// //       p_id: "",
// //       cat_brands: [],
// //       products: products,
// //       sort_order: 0,
// //       sub_cat: subCategories,
// //     ));
// //   }
// //   return categories;
// // }
// //
// //
// // Future<List<CategoryModel>> getHomeSubCategoriesList(
// //     String categoryId) async {
// //   List<CategoryModel> categories = [];
// //   final db = await database;
// //   final res = await db.rawQuery(
// //       "SELECT * FROM HomeSubCategories WHERE categoryId LIKE '%$categoryId%'");
// //
// //   // .rawQuery("SELECT * FROM SubCategories WHERE categoryId=${categoryId}");
// //   // final res = await db.rawQuery("SELECT home FROM Home WHERE id=0");
// //   for (int i = 0; i < res.length; i++) {
// //     categories.add(CategoryModel(
// //       id: res[i]["id"].toString(),
// //       image: res[i]["image"].toString(),
// //       name: res[i]["name"].toString(),
// //       status: 0,
// //       catbanner1: res[i]["catbanner1"].toString(),
// //       catbanner2: res[i]["catbanner2"].toString(),
// //       featured: 0,
// //       name_ar: "",
// //       order_by: "",
// //       p_id: "",
// //       cat_brands: [],
// //       products: [],
// //       sort_order: 0,
// //       sub_cat: [],
// //     ));
// //   }
// //   return categories;
// // }
// //
//   checkDataExistenceByLength(String table) async {
//     final db = await database;
//     int count = Sqflite.firstIntValue(
//         await db.rawQuery('SELECT COUNT(*) FROM $table'))!;
//     // await createDB(table);
//     // int count=Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
//     // final res = await db.rawQuery('SELECT COUNT(*) FROM $table');
//     return count;
//   }
// }
