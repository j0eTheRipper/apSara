import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';

class UserGoogleAccount extends ChangeNotifier {
  final _googleSignIn = GoogleSignIn(
      serverClientId: dotenv.env["SERVER_ID"],
      clientId: dotenv.env["CLIENT_ID"],
      scopes: <String>[
        CalendarApi.calendarEventsScope,
      ]
  );

  GoogleSignInAccount? _account;
  bool isAuthorized = false;

  String get account {
    if (!isAuthorized) {
      return "No man yet...";
    }
    return _account!.email;
  }


  Future<void> signInHandler() async {
    _account = await _googleSignIn.signIn();
    isAuthorized = _account != null;
    notifyListeners();
  }

  Future<void> getEvents() async {
    if (_account == null) {
      signInHandler();
    }

    final authClient = await _googleSignIn.authenticatedClient();
    final calendarApi = CalendarApi(authClient!);
    final events = await calendarApi.events.list(account, orderBy: "startTime", maxResults: 1, singleEvents: true, timeMin: DateTime.now());

    print(events.items?.last.summary);
  }

}
