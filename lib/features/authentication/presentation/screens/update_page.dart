import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:auth_api/features/authentication/presentation/bloc/authentication_bloc.dart';

import '../../data/base/token.dart';

class UpdateUserPage extends StatefulWidget {
  const UpdateUserPage({super.key});
  static String routeName = "updateUserPage";
  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationNameController = TextEditingController();
  final TextEditingController _locationAddressController =
      TextEditingController();
  final TextEditingController _locationCoordinatesController =
      TextEditingController();
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationNameController,
                  decoration: const InputDecoration(labelText: 'Location Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your location name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationAddressController,
                  decoration:
                      const InputDecoration(labelText: 'Location Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your location address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationCoordinatesController,
                  decoration: const InputDecoration(
                      labelText: 'Location Coordinates (comma separated)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your location coordinates';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Pick Image'),
                ),
                if (_selectedImage != null)
                  Image.file(
                    _selectedImage!,
                    height: 100,
                    width: 100,
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      const String token =
                          "FOODAPI eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0OWVmNDExNjFjYWZjOTg5ZGE4YmQ2YSIsImVtYWlsIjoiYW5hcy5yb3V0ZUBnbWFpbC5jb20iLCJuYW1lIjoidGVzdHBob25lIiwiaWF0IjoxNjg4MTYyMDI1fQ.qxLbn5n2g1MXNwAuqMx4nwlmuMbCIsSbY4j_FzHeV9E";
                      // String? token = await getAuthToken();
                      print("Token update retrieved: $token"); // Add this line
                      // final prefixedToken = "FOODAPI $token";
                      // print(
                      //     "Token update retrieved: $prefixedToken"); // Add this line
                      if (token == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('token is missing'),
                        ));
                        return;
                      }
                      List<String> coordinates =
                          _locationCoordinatesController.text.split(',');
                      Map<String, dynamic> location = {
                        "name": _locationNameController.text,
                        "address": _locationAddressController.text,
                        "coordinates": coordinates
                            .map((e) => double.parse(e.trim()))
                            .toList()
                      };

                      context.read<AuthenticationBloc>().add(
                            UpdateUserEvent(
                              token: token,
                              name: _nameController.text,
                              phone: _phoneController.text,
                              location: jsonEncode(location),
                              profilePic: _selectedImage,
                            ),
                          );
                    }
                  },
                  child: const Text('Update'),
                ),
                BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is UserUpdateSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('User updated successfully')),
                      );
                    } else if (state is UserUpdateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is UserUpdateLoading) {
                      return const CircularProgressIndicator();
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
