import 'dart:io';

import 'package:auth_api/features/authentication/domain/Reoposetory/register_repo.dart';
import 'package:auth_api/features/authentication/domain/Reoposetory/login_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepo auth;
  final RegisterRepo registerRepo;

  AuthenticationBloc(this.auth, this.registerRepo) : super(AuthenticationInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthenticationLoading());
      final res = await auth.login(email: event.email, password: event.password);

      if (res[1] == 200) {
        emit(AuthenticationSuccess());
      } else if (res[1] == 403) {
        emit(AuthenticationError(message: "Invalid email or password"));
      } else {
        emit(AuthenticationError(
            message: "The service is currently unavailable, please try again."));
      }
    });

    on<RegisterEvent>((event, emit) async {
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
        print("ResposeBody :$responseBody");
        if (responseBody["ErrorMessage"] == "This email already exist but not confirmed") {
          emit(AuthenticationError(message: "This email already exists but is not confirmed."));
        } else if (responseBody["ErrorMessage"] == "This email already exist") {
          emit(AuthenticationError(message: "This email already exists"));
        } else {
          emit(AuthenticationError(message: "Registration failed. Please try again."));
        }
      } else {
        emit(AuthenticationError(
            message: "The service is currently unavailable, please try again."));
      }
    });
  }
}