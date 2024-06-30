import 'dart:io';

import 'package:auth_api/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:auth_api/features/authentication/presentation/components/text_format_field.dart';
import 'package:auth_api/features/authentication/presentation/components/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


import '../../../home/home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String routName = "registerPage";
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> nkey = GlobalKey();
  GlobalKey<FormState> ekey = GlobalKey();
  GlobalKey<FormState> pkey = GlobalKey();
  GlobalKey<FormState> pwkey = GlobalKey();
  GlobalKey<FormState> cpwkey = GlobalKey();
  GlobalKey<FormState> locNkey = GlobalKey();
  GlobalKey<FormState> locAkey = GlobalKey();
  GlobalKey<FormState> locCkey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  TextEditingController locationName = TextEditingController();
  TextEditingController locationAddress = TextEditingController();
  TextEditingController locationCoordinates = TextEditingController();
  File? _selectedImage;

  Future<void> _picImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/giphy.gif"),
              )),
            ),
            TextFromatField(
              controller: name,
              label: "Name",
              fKey: nkey,
            ),
            TextFromatField(
              controller: email,
              label: "Email",
              fKey: ekey,
            ),
            TextFromatField(
              controller: phone,
              label: "Phone",
              fKey: pkey,
            ),
            PasswordFormatField(
              controller: password,
              fKey: pwkey,
              label: "Password",
            ),
            PasswordFormatField(
              controller: confirmPass,
              fKey: cpwkey,
              label: "Confirm Password",
            ),
            TextFromatField(
              controller: locationName,
              label: "Location Name",
              fKey: locNkey,
            ),
            TextFromatField(
              controller: locationAddress,
              label: "Location Address",
              fKey: locAkey,
            ),
            TextFromatField(
              controller: locationCoordinates,
              label: "Location Coordinates (comma separated)",
              fKey: locCkey,
            ),
            ElevatedButton(
              onPressed: _picImage,
              child: const Text('choose Profile Picture'),
            ),
            if(_selectedImage != null) Image.file(_selectedImage!),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  if (nkey.currentState!.validate() &&
                      ekey.currentState!.validate() &&
                      pkey.currentState!.validate() &&
                      pwkey.currentState!.validate() &&
                      cpwkey.currentState!.validate() &&
                      locNkey.currentState!.validate() &&
                      locAkey.currentState!.validate() &&
                      locCkey.currentState!.validate()) {
                    List<String> coordinates =
                        locationCoordinates.text.split(',');
                    Map<String, dynamic> location = {
                      "name": locationName.text,
                      "address": locationAddress.text,
                      "coordinates": coordinates
                          .map((e) => double.parse(e.trim()))
                          .toList()
                    };

                    context.read<AuthenticationBloc>().add(
                          RegisterEvent(
                              name: name.text,
                              email: email.text,
                              phone: phone.text,
                              password: password.text,
                              confirmPassword: confirmPass.text,
                              location: location,
                            profilePic: _selectedImage,
                          ),
                        );
                  }
                },
                child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationSuccess) {
                      // Navigate to home or login page
                      Navigator.pushNamed(context, Home.routeName);
                    } else if (state is AuthenticationError) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthenticationLoading) {
                      return const CircularProgressIndicator();
                    } else {
                      return const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      );
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
