import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class JoinMeeting extends StatefulWidget {
  final String roomText, subjectText, nameText;
  const JoinMeeting(
      {Key? key,
      required this.roomText,
      required this.subjectText,
      required this.nameText})
      : super(key: key);

  @override
  State<JoinMeeting> createState() => JoinMeetingState();
}

class JoinMeetingState extends State<JoinMeeting> {
  String serverText = "";

  String roomText = "";
  String subjectText = "";

  String nameText = "";
  String emailText = "";

  bool? isAudioOnly = false;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;

  void _onConferenceWillJoin(message) {
    // debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    // debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    // debugPrint("_onConferenceTerminated broadcasted with message: $message");
    Navigator.pop(context);
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  void initialize() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        roomText = widget.roomText;
        subjectText = widget.subjectText;
        nameText = widget.nameText;
        emailText = user.email!;
      });
    }
    _joinMeeting();
  }

  @override
  void initState() {
    super.initState();
    initialize();
    // JitsiMeet.addListener(JitsiMeetingListener(
    //     onConferenceWillJoin: _onConferenceWillJoin,
    //     onConferenceJoined: _onConferenceJoined,
    //     onConferenceTerminated: _onConferenceTerminated,
    //     onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meeting"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              color: Colors.white54,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.60 * 0.70,
                height: MediaQuery.of(context).size.height * 0.60 * 0.70,
                child: JitsiMeetConferencing(
                  extraJS: const [
                    '<script>function echo(){console.log("echo!!!")};</script>',
                    '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                  ],
                ),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          JitsiMeet.closeMeeting();
        },
        label: Text("Leave Meeting"),
      ),
    );
  }

  _joinMeeting() async {
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
      FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
      FeatureFlagEnum.RAISE_HAND_ENABLED: false,
      FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE: false
    };
    setState(() {});
    var options = JitsiMeetingOptions(room: roomText);
    options.serverURL = null;
    options.subject = subjectText;
    options.userDisplayName = nameText;
    options.userEmail = emailText;
    options.audioOnly = isAudioOnly;
    options.audioMuted = isAudioMuted;
    options.videoMuted = isVideoMuted;
    options.featureFlags.addAll(featureFlags);

    featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
    options.iosAppBarRGBAColor = "#0080FF80";
    options.webOptions = {
      "roomName": roomText,
      "width": "100%",
      "height": "100%",
      "enableWelcomePage": false,
      "chromeExtensionBanner": null,
      "userInfo": {"displayName": nameText}
    };

    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            // debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            // debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }
}
