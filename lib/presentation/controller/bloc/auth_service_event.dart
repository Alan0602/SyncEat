part of 'auth_service_bloc.dart';

class AuthServiceEvent extends Equatable {
  const AuthServiceEvent();

  @override
  List<Object> get props => [];
}

class GetUserDetailsEvent extends AuthServiceEvent {
  final Map<String, dynamic> userdetails;
  final String uid;
  const GetUserDetailsEvent({required this.userdetails, required this.uid});
}
