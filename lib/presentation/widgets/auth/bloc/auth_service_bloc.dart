import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'auth_service_event.dart';
part 'auth_service_state.dart';

class AuthServiceBloc extends Bloc<AuthServiceEvent, AuthServiceState> {
  AuthServiceBloc() : super(AuthServiceInitial()) {
    on<GetUSerDetailsEvent>(getuserdetails);
  }

  FutureOr<void> getuserdetails(
    GetUSerDetailsEvent event,
    Emitter<AuthServiceState> emit,
  ) {
    emit(AuthServiceLoading());
    try {
      log('Firebase');
      // Add user Details
      var db = FirebaseFirestore.instance;

      db
          .collection("userdetails")
          .add(event.userdetails)
          .then(
            (documentSnapshot) =>
                print("Added Data with ID: ${documentSnapshot.id}"),
          );
      emit(AuthServicesucces());
    } catch (e) {
      emit(AuthServiceError(errormsg: e.toString()));
    }
  }
}
