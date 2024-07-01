import 'dart:io';

import 'package:auth_api/features/authentication/domain/Reoposetory/register_repo.dart';
import 'package:auth_api/features/authentication/domain/Reoposetory/login_repo.dart';
import 'package:auth_api/features/authentication/domain/Reoposetory/update_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepo auth;
  final RegisterRepo registerRepo;
  final UserService userService;
  final _secureStorage = const FlutterSecureStorage();

  AuthenticationBloc(this.auth, this.registerRepo, this.userService) : super(AuthenticationInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final res = await auth.login(email: event.email, password: event.password);

    if (res[1] == 200) {

      emit(AuthenticationSuccess());
    } else if (res[1] == 403) {
      emit(AuthenticationError(message: "Invalid user information as email or password."));
    } else {
      emit(AuthenticationError(message: "The service is currently unavailable, please try again."));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final res = await registerRepo.register(
      name: event.name,
      email: event.email,
      phone: event.phone,
      password: event.password,
      confirmPassword: event.confirmPassword,
      location: event.location,
      profilePic: event.profilePic,
    );

    if (res[1] == 200) {
      emit(AuthenticationSuccess());
    } else if (res[1] == 400) {
      final responseBody = res[0]; // Assuming res[0] contains the response body
      print("ResponseBody: $responseBody");
      if (responseBody["ErrorMessage"] == "This email already exist but not confirmed") {
        emit(AuthenticationError(message: "This email already exists but is not confirmed."));
      } else if (responseBody["ErrorMessage"] == "This email already exist") {
        emit(AuthenticationError(message: "This email already exists"));
      } else {
        emit(AuthenticationError(message: "Registration failed. Please try again."));
      }
    } else {
      emit(AuthenticationError(message: "The service is currently unavailable, please try again."));
    }
  }

  Future<void> _onUpdateUser(UpdateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(UserUpdateLoading());
    try {
      final token = await _secureStorage.read(key: 'token'); // Retrieve token from secure storage
      if (token == null) {
        emit(UserUpdateError(message: "Token is missing"));
        return;
      }
      final res = await userService.updateUser(
        token: token, // Use stored token
        name: event.name,
        phone: event.phone,
        location: event.location,
      );
      if (res['status'] == 200) {
        emit(UserUpdateSuccess());
      } else {
        emit(UserUpdateError(message: res['message']));
      }
    } catch (e) {
      emit(UserUpdateError(message: e.toString()));
    }
  }
}
