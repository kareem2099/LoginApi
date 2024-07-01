part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final Map<String, dynamic> location;
  final File? profilePic;

  const RegisterEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    required this.location,
    this.profilePic,
  });

  @override
  List<Object> get props =>
      [name, email, phone, password, confirmPassword, location];
}

class UpdateUserEvent extends AuthenticationEvent {
  final String token;
  final String name;
  final String phone;
  final String location;
  final File? profilePic;

  const UpdateUserEvent({
    required this.token,
    required this.name,
    required this.phone,
    required this.location,
    this.profilePic,
  });

  @override
  List<Object> get props => [token, name, phone, location];
}
