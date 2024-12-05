import 'package:chattest/core/firebase_service/firebase_store.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class Nofifcation {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Nofifcation() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      if (firebaseAuth.currentUser != null) {
        print("Token refreshed: $newToken");

      }
    });
  }




}
