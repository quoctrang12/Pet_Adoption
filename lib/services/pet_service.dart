import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_adopt/models/pets_model.dart';
import '../models/auth_token.dart';
import 'firebase_service.dart';

class PetsService extends FirebaseService {
  PetsService([AuthToken? authToken]) : super(authToken);

  Future<List<Pet>> fetchPets([bool filterByUser = false]) async {
    final List<Pet> pets = [];
    try {
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final petsUrl = Uri.parse('$databaseUrl/pets.json?auth=$token&$filters');
      final response = await http.get(petsUrl);
      final petsMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(petsMap['error']);
        return pets;
      }

      final userFavoriteUrl =
          Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');
      final userFavoritesResponse = await http.get(userFavoriteUrl);
      final userFavoritesMap = json.decode(userFavoritesResponse.body);

      petsMap.forEach((petId, pet) {
        final isFavorite = (userFavoritesMap == null)
            ? false
            : (userFavoritesMap[petId] ?? false);
        pets.add(
          Pet.fromJson({
            'id': petId,
            ...pet,
          }).copyWith(fav: isFavorite),
        );
      });
      return pets;
    } catch (error) {
      print(error);
      return pets;
    }
  }

  Future<Pet?> addPet(Pet pet) async {
    try {
      final url = Uri.parse('$databaseUrl/pets.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          pet.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return pet.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updatePet(Pet pet) async {
    try {
      final url = Uri.parse('$databaseUrl/pets/${pet.id}.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(pet.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deletePet(String id) async {
    try {
      final url = Uri.parse('$databaseUrl/pets/$id.json?auth=$token');
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> saveFavoriteStatus(Pet pet) async {
    try {
      final url = Uri.parse(
          '$databaseUrl/userFavorites/$userId/${pet.id}.json?auth=$token');
      final response = await http.put(
        url,
        body: json.encode(pet.isFavorite),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
