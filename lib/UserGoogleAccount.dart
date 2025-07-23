import 'package:ap_sara/Scheduler/Class.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';

class GoogleCalendarStuff extends ChangeNotifier {
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
    if (_account == null) {
      return "none";
    } else {
      return _account!.email;
    }
  }


  Future<void> signInHandler() async {
    _account = await _googleSignIn.signIn();
    isAuthorized = _account != null;

    notifyListeners();
  }

  Future<void> signInSilently() async {
    if (!isAuthorized && _googleSignIn.currentUser != null) {
      _account = await _googleSignIn.signInSilently();
      isAuthorized = _account != null;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _googleSignIn.signOut();
    isAuthorized = false;
    _account = null;
    notifyListeners();
  }

  Future<bool> isOccupied(DateTime startTime, DateTime endTime) async {
    final authClient = await _googleSignIn.authenticatedClient();
    final userCalendar = CalendarApi(authClient!);
    final event = await userCalendar.events.list(account, orderBy: "startTime", maxResults: 1, singleEvents: true, timeMin: startTime, timeMax: endTime);
    return event.items!.isNotEmpty;
  }

  Future<void> addToCalendar(Class cls) async {
    final authClient = await _googleSignIn.authenticatedClient();
    final userCalendar = CalendarApi(authClient!);
    Event event = Event(start: EventDateTime(dateTime: cls.start), end: EventDateTime(dateTime: cls.end), summary: cls.moduleID, description: cls.moduleTitle);
    await userCalendar.events.insert(event, account);
  }
}
