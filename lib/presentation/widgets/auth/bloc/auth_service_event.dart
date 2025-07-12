part of 'auth_service_bloc.dart';

class AuthServiceEvent extends Equatable {
  const AuthServiceEvent();

  @override
  List<Object> get props => [];
}

class GetUSerDetailsEvent extends AuthServiceEvent {
  final Map<String, dynamic> userdetails;
  GetUSerDetailsEvent({required this.userdetails});
}
