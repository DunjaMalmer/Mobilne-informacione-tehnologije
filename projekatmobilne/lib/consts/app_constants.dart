import 'package:projekatmobilne/models/categories_model.dart';
import 'package:projekatmobilne/services/assets_manager.dart';

class AppConstants {
  static List<String> bannersImages = [
    "${AssetsManager.imagePath}/vocna.jpg",
    "${AssetsManager.imagePath}/cokomalina.jpg",
  ];

  static List<CategoriesModel> categoriesList = [
    CategoriesModel(
      id: "torte",
      name: "Torte",
      image: "${AssetsManager.imagePath}/cokomalina.jpg",
    ),
    CategoriesModel(
      id: "kolaci",
      name: "Kolaci",
      image: "${AssetsManager.imagePath}/mini.jpg",
    ),
    CategoriesModel(
      id: "makaronsi",
      name: "Makaronsi",
      image: "${AssetsManager.imagePath}/pistaci.jpg",
    ),
    CategoriesModel(
      id: "deserti",
      name: "Bez šećera",
      image: "${AssetsManager.imagePath}/vocna.jpg",
    ),
  ];
}
