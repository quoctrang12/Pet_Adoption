import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_adopt/models/owner_model.dart';
import '../models/auth_token.dart';
import 'firebase_service.dart';

class OwnersService extends FirebaseService {
  OwnersService([AuthToken? authToken]) : super(authToken);

  Future<List<Owner>> fetchOwners([bool filterByUser = false]) async {
    final List<Owner> owners = [];

    try {
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final ownersUrl =
          Uri.parse('$databaseUrl/owners.json?auth=$token&$filters');
      final response = await http.get(ownersUrl);
      final ownersMap = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        print(ownersMap['error']);
        return owners;
      }
      ownersMap.forEach((ownerId, owner) {
        owners.add(
          Owner.fromJson({
            'id': ownerId,
            ...owner,
          }),
        );
      });
      return owners;
    } catch (error) {
      print(error);
      return owners;
    }
  }

  Future<Owner?> addOwner(Owner owner, AuthToken token) async {
    try {
      final url = Uri.parse('$databaseUrl/owners.json?auth=${token.token}');
      final response = await http.post(
        url,
        body: json.encode(
          owner.toJson()
            ..addAll({
              'creatorId': token.userId,
            }),
        ),
      );
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return owner.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateOwner(Owner owner) async {
    try {
      final url = Uri.parse('$databaseUrl/owners/${owner.id}.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(owner.toJson()),
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
