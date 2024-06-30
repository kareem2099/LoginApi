part of 'authentication_bloc.dart';


@immutable
sealed class AuthenticationEvent extends Equatable {}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final Map<String, dynamic> location;
  final File? profilePic;

  RegisterEvent({required this.name, required this.email, required this.phone, required this.password, required this.confirmPassword,required this.location,required this.profilePic,});

  @override
  List<Object?> get props => [name,email,phone, password,confirmPassword,location,profilePic];
}


