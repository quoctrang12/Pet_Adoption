import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_plus/dropdown_plus.dart';

import 'package:pet_adopt/models/pets_model.dart';
import 'package:pet_adopt/models/managers/pets_manager.dart';
import 'package:pet_adopt/shared/dialog_utils.dart';

import 'package:pet_adopt/const.dart';

class UserEditScreen extends StatefulWidget {
  UserEditScreen(
    Pet? pet, {
    super.key,
  }) {
    if (pet == null) {
      this.pet = Pet(
        id: null,
        image: "",
        color: "red",
        description: "",
        type: "",
        name: "",
        location: "",
        sex: "",
        age: 0,
        weight: 0,
        distance: 0,
      );
    } else {
      this.pet = pet;
    }
  }

  late final Pet pet;

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Pet _editedPet;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('assets') ||
        value.startsWith('assets') &&
            (value.endsWith('.png') ||
                value.endsWith('.jpg') ||
                value.endsWith('.jpeg')));
  }

  @override
  void initState() {
    _imageFocusNode.addListener(() {
      if (!_imageFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageController.text)) {
          return;
        }
        setState(() {});
      }
    });

    _editedPet = widget.pet;
    _imageController.text = _editedPet.image;
    super.initState();
  }

  @override
  void dispose() {
    _imageController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  TextFormField buildNameFied() {
    return TextFormField(
      initialValue: _editedPet.name,
      decoration: const InputDecoration(labelText: 'Name'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedPet = _editedPet.copyWith(name: value);
      },
    );
  }

  Widget buildLocationFied() {
    return TextDropdownFormField(
      options: [
        "Ninh Kieu, Can Tho",
        "Cai Rang, Can Tho",
        "Binh Thuy, Can Tho",
        "Phong Dien, Can Tho"
      ],
      decoration: InputDecoration(
          // border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.arrow_drop_down),
          labelText: "Location"),
      dropdownHeight: 240,
      validator: (dynamic value) {
        if (value.toString().isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onChanged: (dynamic value) {
        _editedPet = _editedPet.copyWith(location: value.toString());
      },
    );
  }

  Widget buildTypeFied() {
    return TextDropdownFormField(
      options: ["Cats", "Dogs", "Hamsters"],
      decoration: InputDecoration(
          // border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.arrow_drop_down),
          labelText: "Type"),
      dropdownHeight: 180,
      validator: (dynamic value) {
        if (value.toString().isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onChanged: (dynamic value) {
        _editedPet = _editedPet.copyWith(type: value.toString());
      },
    );
  }

  Widget buildSexFied() {
    return TextDropdownFormField(
      options: ["Male", "Female"],
      decoration: InputDecoration(
          // border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.arrow_drop_down),
          labelText: "Sex"),
      dropdownHeight: 120,
      validator: (dynamic value) {
        if (value.toString().isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onChanged: (dynamic value) {
        _editedPet = _editedPet.copyWith(sex: value.toString());
      },
      onSaved: (dynamic value) {
        _editedPet = _editedPet.copyWith(sex: value.toString());
      },
    );
  }

  TextFormField buildAgeField() {
    return TextFormField(
      initialValue: _editedPet.age.toString(),
      decoration: const InputDecoration(labelText: 'Age'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a age.';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _editedPet = _editedPet.copyWith(age: double.parse(value!));
      },
    );
  }

  TextFormField buildWeightField() {
    return TextFormField(
      initialValue: _editedPet.weight.toString(),
      decoration: const InputDecoration(labelText: 'Weight'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a weight.';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _editedPet = _editedPet.copyWith(weight: double.parse(value!));
      },
    );
  }

  TextFormField buildDistanceField() {
    return TextFormField(
      initialValue: _editedPet.distance.toString(),
      decoration: const InputDecoration(labelText: 'Distance'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a distance.';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (int.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _editedPet = _editedPet.copyWith(distance: int.parse(value!));
      },
    );
  }

  TextFormField buildDesciption() {
    return TextFormField(
      initialValue: _editedPet.description,
      decoration: const InputDecoration(labelText: 'Desciption'),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description.';
        }
        if (value.length < 10) {
          return 'Should be at least 10 characters long.';
        }
        return null;
      },
      onSaved: (value) {
        _editedPet = _editedPet.copyWith(description: value);
      },
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageController,
      focusNode: _imageFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an image URL.';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL.';
        }
        return null;
      },
      onSaved: (value) {
        _editedPet = _editedPet.copyWith(image: value);
      },
    );
  }

  Widget buildPetPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(top: 8, right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageController.text.isEmpty
              ? const Text('Enter a URL')
              : FittedBox(
                  child: Image.asset(
                    _imageController.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(child: buildImageURLField()),
      ],
    );
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }

    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final petsManager = context.read<PetsManager>();
      if (_editedPet.id != null) {
        await petsManager.updatePet(_editedPet);
      } else {
        await petsManager.addPet(_editedPet);
      }
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong');
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        title: const Text('Edit Pet'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: [
                    buildNameFied(),
                    // buildIdOwnerFied(),
                    buildLocationFied(),
                    SizedBox(height: 10),
                    buildTypeFied(),
                    SizedBox(height: 10),
                    buildSexFied(),
                    buildAgeField(),
                    buildWeightField(),
                    buildDistanceField(),
                    buildDesciption(),
                    buildPetPreview(),
                  ],
                ),
              ),
            ),
    );
  }
}
