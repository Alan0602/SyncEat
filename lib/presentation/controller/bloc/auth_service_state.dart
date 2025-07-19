part of 'auth_service_bloc.dart';

abstract class AuthServiceState extends Equatable {
  const AuthServiceState();

  @override
  List<Object> get props => [];
}

class AuthServiceInitial extends AuthServiceState {}

class AuthServiceLoading extends AuthServiceState {}

class AuthServiceSuccess extends AuthServiceState {
  final Map<String, dynamic> userDetails;

  const AuthServiceSuccess({required this.userDetails});

  @override
  List<Object> get props => [userDetails];
}

class AuthServiceError extends AuthServiceState {
  final String errormsg;

  const AuthServiceError({required this.errormsg});

  @override
  List<Object> get props => [errormsg];
}