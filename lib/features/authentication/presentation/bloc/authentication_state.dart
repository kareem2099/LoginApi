part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError({required this.message});

  @override
  List<Object> get props => [message];
}

class UserUpdateLoading extends AuthenticationState {}

class UserUpdateSuccess extends AuthenticationState {}

class UserUpdateError extends AuthenticationState {
  final String message;

  const UserUpdateError({required this.message});

  @override
  List<Object> get props => [message];
}
