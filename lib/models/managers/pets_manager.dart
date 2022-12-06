import 'package:flutter/foundation.dart';
import 'package:pet_adopt/models/auth_token.dart';
import 'package:pet_adopt/models/pets_model.dart';
import 'package:pet_adopt/services/pet_service.dart';

class PetsManager with ChangeNotifier {

  List<Pet> _pets = [];

  final PetsService _petsService;

  PetsManager([AuthToken? authToken]) : _petsService = PetsService(authToken);

  set authToken(AuthToken? authToken) {
    _petsService.authToken = authToken;
  }

  Future<void> fetchPets([bool filterByUser = false]) async {
    _pets = await _petsService.fetchPets(filterByUser);
    notifyListeners();
  }

  Future<void> addPet(Pet pet) async {
    final newPet = await _petsService.addPet(pet);
    if (newPet != null) {
      _pets.add(newPet);
      notifyListeners();
    }
  }

  Future<void> updatePet(Pet pet) async {
    final index = _pets.indexWhere((item) => item.id == pet.id);
    if (index >= 0) {
      if (await _petsService.updatePet(pet)) {
        _pets[index] = pet;
        notifyListeners();
      }
    }
  }

  Future<void> deletePet(String id) async {
    final index = _pets.indexWhere((item) => item.id == id);
    Pet? existingPet = _pets[index];
    _pets.removeAt(index);
    notifyListeners();

    if (!await _petsService.deletePet(id)) {
      _pets.insert(index, existingPet);
      notifyListeners();
    }
  }

  int get itemCount {
    return _pets.length;
  }

  List<Pet> get pets {
    return [..._pets];
  }

  List<Pet> get petIsfav {
    return _pets.where((pet) => pet.isFavorite).toList();
  }

  List<Pet> getListPet(String name) {
    return _pets.where((pet) => pet.type == name).toList();
  }

  Pet findById(String id) {
    return _pets.firstWhere((prod) => prod.id == id);
  }

  Future<void> toggleFavoriteStatus(Pet pet) async {
    final savedStatus = pet.isFavorite;
    pet.isFavorite = !savedStatus;

    if (!await _petsService.saveFavoriteStatus(pet)) {
      pet.isFavorite = savedStatus;
    }
  }
}
