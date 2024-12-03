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
    // 1. In the constructor, listen for any token changes and update the user if it changes
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      if (firebaseAuth.currentUser != null) {
        print("Token refreshed: $newToken");
        await FirebaseStoreService()
            .updateUserToken(firebaseAuth.currentUser!.uid);
      }
    });
  }

  // 3. Request permission to send notifications to this device
  Future<void> requestNotificationPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // 4. Get a unique push token for each device, which will be sent to the user
  Future getDevicesToken() async {
    String? token = await messaging.getToken();
    print("create token for ech dvices $token");
    return token;
  }

  // 5. Obtain an access token for Google Cloud services to use for authentication
  Future<String> getAccesTokenSevcesAccount() async {
    final Map<String, String> serviceAcconJson =
      /// add your file
    {
      // {
      //   "type": "service_account",
      //   "project_id": "chat-752a3",
      //   "private_key_id": "4c066a24b6fefbf5694142fbb36af2564fce2f8b",
      //   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDP4dlmjYcQS9HN\nDWaVUEwM4EMNdRjkso0alEBmHBKoS/Ka2bOL3BXxjURBwOFmJEGDVfFZqy8voljF\nrD9AEXz3I79KkWeIc6G6nWq9cHXWBlW1Jk1WC+m7Qvn9CkzjU5aywTxDJjpoGkBt\nrdaxpu3s754pWjwkRQFGsws4MBug7/fdSolcOtpOOIfHldz1cJcFZI+vEEipH3Pn\ni8mTzSwDkLITjN4EfRphOYo/r6f8+NAXCDCXyI2KTiUttvqr9PJGGEkr06f5pOan\nPNRet1Bsg3gyB34SJY+OMf+3K2KYzlb4azGxnMe3xpKjsDnc0UtXhampHvMlikCz\ndsaZrFd7AgMBAAECggEAKpxfPSOudzsrXo4sJFgItqzzYZtKhnpI7RVNXADOHDwx\nFuef43+x6cjsoFPCf/bXjO29YoVxzyBGdQJZFq9e/6OOruC+KZyWHpPs0LbwGHZE\n9DRNLuGTP+S7LFCDsSctoSd1zEfWOgeDhFfZRaHzbBkzwMMzx7VzTQQfPR2zVBnt\nkGnLen+KPkA2w1jxJEdYbCvzJfDFnLyDsrFkUSk/+PPROwp8wYnpZCFphf0Qonui\nYcPiGG2aGktJd2Sn0T9jAc02bLt76MH00NkIBEjnBxKlLAPpgS7IeVPTlPpoOF+m\npGUBZd6BBAYTKcTf3hAyFJBHs4ZRpo30Cb2Uv0F4zQKBgQDm+PV7FtQH5cDoXkIB\ntRIDEVJmJm4ZjoPeojdy/pGy/eRnyHF0YyUgkwKrYusXVKa8RilG5Bm7hG3AP+GM\nGg9Xez1yDnILFVb8MXVZMkSECMtLDcu36RjnuEblzar1i9rQHmysTDvnVz/b+Nrw\nexSPFTnzDIZDo877XB4/cy8yRwKBgQDmaGE3UF5WRp0WkpnLlR/90FUQj9Q56yTv\nvTu8U405WXNrzrp+UOHrh/l+vdivzhOclra5hTCijep1+NFSNxZRkBujhPna768Q\n8vdr06x3y/UAR1gXlqFaZWQ820akUdDLngUBHYk41C4w5Cyo3gPkEFJlsMlpGovb\nDro7iTL3LQKBgQDIT59t6cVnN/2OSLjMDEIbwPkKOEgCCBQbj+mw5FBtwD1HOJIU\nkyuOzZBiHL6wFC0qWVrQ7V/XvakFMyGjxLILd4k5koebTx2KSEZyXeMH8yyD4eoM\njK6Zv7pU8IJUw764AbrTzqWhI4zxdChEqSmSUaFZRUJoBPesDR76fiWvXwKBgQDV\nUWZQU/RDZHUj5O7G8XYBA9T91Gvkg7Ra0ZRws9pYclzOP0OilzfTXLy9fv8TJXQ6\n0b6y3IE+vq2IM6l4uM/NC+LK7d51uNsYkhpIll1jPE3EyEji7e7NRnobbdhlYeox\n2kc/1RyqpKdvVJGUdpibmhDvXVHcIVvCoEwDuu6YsQKBgQCubU+Ivo8ix9MKjRAM\nKufqzr9Mu22LUOEYA7d7W7LN1qXaE77760Sig1n61TVQlkVI5T2XI+QhFK/Muja0\ndS+eIhJLivlL/aku74RWJsK7QijnES1f3P7NdjWKLINuYVOgho3kDnykVn/rVXjw\nt20lhmn9i/97tWiR5B0Cd9PQgg==\n-----END PRIVATE KEY-----\n",
      //   "client_email": "test-739@chat-752a3.iam.gserviceaccount.com",
      //   "client_id": "107865381473932811395",
      //   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      //   "token_uri": "https://oauth2.googleapis.com/token",
      //   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      //   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/test-739%40chat-752a3.iam.gserviceaccount.com",
      //   "universe_domain": "googleapis.com"
      };

    print("----------------------- Service json");

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAcconJson), scopes);

      auth.AccessCredentials credential =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(serviceAcconJson),
              scopes,
              client);
      client.close();

      return credential.accessToken.data;
    } catch (e) {
      return "error is $e";
    }
  }

  // 6. Send a notification using the API with the HTTP package
  Future senNotifaction(String body, String sendrname, String token) async {
    final String accestoken = await getAccesTokenSevcesAccount();

    const String endpoint =
        'https://fcm.googleapis.com/v1/projects/chat-752a3/messages:send';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accestoken',
    };

    final Map<String, dynamic> messge = {
      "message": {
        "token": token,
        "notification": {"body": body, "title": sendrname}
      }
    };

    try {
      if (accestoken.isEmpty) {
        print("is empty acces token ");
        return "";
      }

      http.Response response = await http.post(Uri.parse(endpoint),
          headers: headers, body: jsonEncode(messge));
      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print(
            'Failed to send notification: ${response.statusCode} - ${response.body}');
      }
      print("////////////////////////////////////////////////");
      print("Access Token: $accestoken");
      print("FCM Endpoint: $endpoint");
      print("Message Payload: ${jsonEncode(messge)}");
    } catch (e) {
      print("erorr when send api $e ");
    }
  }



  Future senNotifactionByDio(String body, String senderName, String token) async {
    final String accessToken = await getAccesTokenSevcesAccount();

    const String endpoint =
        'https://fcm.googleapis.com/v1/projects/chat-752a3/messages:send';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> message = {
      "message": {
        "token": token,
        "notification": {"body": body, "title": senderName}
      }
    };

    try {
      if (accessToken.isEmpty) {
        print("Access token is empty");
        return "";
      }

      // Initialize Dio
      Dio dio = Dio();

      // Make the request
      Response response = await dio.post(
        endpoint,
        options: Options(headers: headers),
        data: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Failed to send notification: ${response.statusCode} - ${response.data}');
      }

      // Log the details
      print("////////////////////////////////////////////////");
      print("Access Token: $accessToken");
      print("FCM Endpoint: $endpoint");
      print("Message Payload: ${jsonEncode(message)}");
    } catch (e) {
      print("Error when sending notification via API: $e");
    }
  }
}
