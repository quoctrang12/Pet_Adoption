import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_plus/dropdown_plus.dart';

import 'package:pet_adopt/models/owner_model.dart';
import 'package:pet_adopt/models/managers/owner_manager.dart';
import 'package:pet_adopt/shared/dialog_utils.dart';

import 'package:pet_adopt/const.dart';

class UserEditProfileScreen extends StatefulWidget {
  final Owner owner;
  const UserEditProfileScreen({Key? key, required this.owner})
      : super(key: key);

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Owner _editedOwner;
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

    _editedOwner = widget.owner;
    _imageController.text = _editedOwner.image;
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
      initialValue: _editedOwner.name,
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
        _editedOwner = _editedOwner.copyWith(name: value);
      },
    );
  }

  Widget buildAddressFied() {
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
          labelText: "Address"),
      dropdownHeight: 240,
      validator: (dynamic value) {
        if (value.toString().isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onChanged: (dynamic value) {
        _editedOwner = _editedOwner.copyWith(address: value.toString());
      },
    );
  }

  TextFormField buildEmail() {
    return TextFormField(
      initialValue: _editedOwner.email,
      decoration: const InputDecoration(labelText: 'Email'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a email.';
        }
        return null;
      },
      onSaved: (value) {
        _editedOwner = _editedOwner.copyWith(email: value);
      },
    );
  }

  TextFormField buildPhone() {
    return TextFormField(
      initialValue: _editedOwner.phone,
      decoration: const InputDecoration(labelText: 'Phone'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a phone.';
        }
        return null;
      },
      onSaved: (value) {
        _editedOwner = _editedOwner.copyWith(phone: value);
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
        _editedOwner = _editedOwner.copyWith(image: value);
      },
    );
  }

  Widget buildOwnerPreview() {
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
      final ownersManager = context.read<OwnerManager>();
      await ownersManager.updateOwner(_editedOwner);
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
        title: const Text('Edit Owner'),
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
                    buildAddressFied(),
                    SizedBox(height: 10),

                    buildPhone(),
                    buildEmail(),
                    buildOwnerPreview(),
                  ],
                ),
              ),
            ),
    );
  }
}
