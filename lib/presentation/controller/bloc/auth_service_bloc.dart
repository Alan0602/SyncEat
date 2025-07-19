import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_service_event.dart';
part 'auth_service_state.dart';

class AuthServiceBloc extends Bloc<AuthServiceEvent, AuthServiceState> {
  AuthServiceBloc() : super(AuthServiceInitial()) {
    on<GetUserDetailsEvent>(getuserdetails);
  }

  FutureOr<void> getuserdetails(
    GetUserDetailsEvent event,
    Emitter<AuthServiceState> emit,
  ) {
    emit(AuthServiceLoading());
    try {
      log('Firebase');
      // Add user Details
      var db = FirebaseFirestore.instance;

      db
          .collection("userdetails")
          .doc(event.uid) // Use UID as document ID
          .set(event.userdetails)
          .then((_) => print("Added Data with ID: ${event.uid}"));
      emit(AuthServiceSuccess(userDetails: event.userdetails));
      ;
    } catch (e) {
      emit(AuthServiceError(errormsg: e.toString()));
    }
  }
}
