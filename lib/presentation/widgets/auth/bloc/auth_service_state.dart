part of 'auth_service_bloc.dart';

class AuthServiceState extends Equatable {
  const AuthServiceState();

  @override
  List<Object> get props => [];
}

class AuthServiceInitial extends AuthServiceState {}

class AuthServicesucces extends AuthServiceState {}

class AuthServiceError extends AuthServiceState {
  String errormsg;
  AuthServiceError({required this.errormsg});
}

class AuthServiceLoading extends AuthServiceState {}
