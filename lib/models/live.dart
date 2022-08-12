import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

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
    // _joinMeeting();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meeting"),
      ),
      body: WebViewX(
        ignoreAllGestures: false,
        height: MediaQuery.of(context).size.height,
        initialContent: """
      <!DOCTYPE html>
      <body style="margin: 0;">
          <div id="meet"></div>
         <script src="https://meet.jit.si/external_api.js"></script>
          <script>
              const domain = 'meet.jit.si';
              const options = {
                  roomName: '$roomText',
                  userInfo: {
                    displayName: '$nameText'
                  },
                  width: '100%',
                  height: 750,
                  parentNode: document.querySelector('#meet')
              };
              const api = new JitsiMeetExternalAPI(domain, options);
          </script>
      </body>
      </html>""",
        initialSourceType: SourceType.html,
        width: MediaQuery.of(context).size.width,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // JitsiMeet.closeMeeting();
          Navigator.pop(context);
        },
        label: Text("Leave Meeting"),
      ),
    );
  }

//   _joinMeeting() async {
//     Map<FeatureFlagEnum, bool> featureFlags = {};
//     setState(() {});
//     var options = JitsiMeetingOptions(room: roomText);
//     options.serverURL = null;
//     options.subject = subjectText;
//     options.userDisplayName = nameText;
//     options.userEmail = emailText;
//     options.audioOnly = isAudioOnly;
//     options.audioMuted = isAudioMuted;
//     options.videoMuted = isVideoMuted;
//     options.featureFlags.addAll(featureFlags);

//     featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
//     options.iosAppBarRGBAColor = "#0080FF80";
//     options.webOptions = {
//       "roomName": roomText,
//       "width": "100%",
//       "height": "100%",
//       "enableWelcomePage": false,
//       "chromeExtensionBanner": null,
//       "userInfo": {"displayName": emailText}
//     };

//     await JitsiMeet.joinMeeting(
//       options,
//       listener: JitsiMeetingListener(
//           onConferenceWillJoin: (message) {},
//           onConferenceJoined: (message) {},
//           onConferenceTerminated: (message) {
//             Navigator.pop(context);
//           },
//           genericListeners: [
//             JitsiGenericListener(
//                 eventName: 'readyToClose',
//                 callback: (dynamic message) {
//                   debugPrint("readyToClose callback");
//                 }),
//           ]),
//     );
//   }
// }
}
