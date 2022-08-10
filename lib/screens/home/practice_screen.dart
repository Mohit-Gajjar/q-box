import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/practice_model.dart';
import 'package:notes_app/screens/home/totalMarksScreen.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:video_player/video_player.dart';
import '../../helpers/helpers.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/testTimer.dart';

class Practice extends StatefulWidget {
  final String subjectName, chapter;
  const Practice({Key? key, required this.subjectName, required this.chapter})
      : super(key: key);
  static const routeName = '/practice-screen';

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  int questionNumber = 1;
  bool isCorrenctOptionChosen1 = false;
  bool isCorrenctOptionChosen2 = false;
  bool isCorrenctOptionChosen3 = false;
  bool isCorrenctOptionChosen4 = false;
  bool isVideoSolenabled = false;
  int totalMarks = 0;
  bool open =false;
  bool isSliderOpen = true;
  // final List<int> _allSelectedChoices = List.filled(20, 0);
  PracticeModel? practiceModel;
  // ignore: unused_field
  Map<String, dynamic>? _userQuestions = {};
  Map<String, dynamic>? _options = {};
  Map<String, dynamic>? _correctAnswers = {};
  List<int> marks=[];
  List<int> counts=[];
  List<Color> colors = [];
  void initializeMarksCounts(int n){
    for(int i=0;i<n;i++){
      setState(() {
        marks.add(0);
        counts.add(0);
        colors.add(Colors.grey);
      });
    }
  }
  @override
  void initState() {
    getQuestions().then((value){
      print(_userQuestions!.keys.length);
      initializeMarksCounts(_userQuestions!.keys.length);
    });
    getUserEmail();
    super.initState();
  }

  bool isLoading = false;

  FlickManager? flickManager;
  Map<String, dynamic> data = {};

  Future<Map<String, dynamic>> getQuestions() async {
    final docData = FirebaseFirestore.instance
        .collection('practice')
        .where("subject", isEqualTo: widget.subjectName)
        .where("chapter", isEqualTo: widget.chapter);
    final snapshot = await docData.get();
    if (snapshot.docs.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      Map<String, dynamic> data = snapshot.docs[0].data();
      _userQuestions = data['questions'] as Map<String, dynamic>;

      setState(() {
        _options = _userQuestions!["id" + questionNumber.toString()]['options']
            as Map<String, dynamic>;
        _correctAnswers = _userQuestions!["id" + questionNumber.toString()]
            ['correct_answers'] as Map<String, dynamic>;
      });

      return data;
    }
    return {};
  }

  String userEmail = "";
  List<bool> correctOptions = [];
  List<String> options = [];
  getUserEmail() async {
    var email = await FirebaseAuth.instance.currentUser!.email;
    setState(() {
      userEmail = email!;
    });
  }

  @override
  void dispose() {
    super.dispose();
    flickManager?.dispose();
  }

  int correctAnswers = 0;
  optionsMaker(int index) {
    if (_userQuestions!.isNotEmpty) {
      setState(() {
        correctOptions.add(_correctAnswers!["answer_a_correct"] ?? false);
        correctOptions.add(_correctAnswers!["answer_b_correct"] ?? false);
        correctOptions.add(_correctAnswers!["answer_c_correct"] ?? false);
        correctOptions.add(_correctAnswers!["answer_d_correct"] ?? false);
        options.add(_options!["optionA"] ?? "No Options");
        options.add(_options!["optionB"] ?? "No Options");
        options.add(_options!["optionC"] ?? "No Options");
        options.add(_options!["optionD"] ?? "No Options");
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    optionsMaker(questionNumber);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          child: Text(
            widget.chapter,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width15,
                        vertical: Dimensions.height10 * 1.5),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          (open)?Text("TOTAL MARKS : $totalMarks"):SizedBox(),
                          TestTimer(),
                          FadeInUp(
                            from: 50,
                            duration: const Duration(milliseconds: 375),
                            child: Card(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadius15),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[200],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimensions.padding20 / 2,
                                        horizontal: Dimensions.padding20 / 2),
                                    child: Text(
                                      questionNumber.toString() +
                                          "). " +
                                          _userQuestions!['id' +
                                                  questionNumber.toString()]
                                              ['question'],
                                      style: HelperFunctions.textstyle(),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          OptionsTile(0, context, () {
                            if (correctOptions[1] == true) {
                              setState(() {
                                counts[questionNumber-1]++;
                                print("count${questionNumber-1} ${counts[questionNumber-1]}");
                                if(counts[questionNumber-1]==1){
                                  marks[questionNumber - 1]++;
                                }
                                print("marks${questionNumber-1} ${marks[questionNumber-1]}");
                                isCorrenctOptionChosen1 = true;
                              });
                              showCustomSnackbar(
                                text: 'Correct',
                                icon: Icons.done,
                                context: context,
                              );
                            } else {
                              setState(() {
                                counts[questionNumber-1]++;
                                if(counts[questionNumber-1]==1){
                                  marks[questionNumber - 1]--;
                                }
                                isCorrenctOptionChosen1 = true;
                              });
                              showCustomSnackbar(
                                text: 'Wrong',
                                icon: Icons.close,
                                context: context,
                              );
                            }
                          },
                              isCorrenctOptionChosen1
                                  ? (correctOptions[1])?Colors.green:Colors.red
                                  : Colors.white),
                          OptionsTile(1, context, () {
                            if (correctOptions[2] == true) {
                              setState(() {
                                counts[questionNumber-1]++;
                                if(counts[questionNumber-1]==1){
                                  marks[questionNumber - 1]++;
                                }
                                isCorrenctOptionChosen2 = true;
                              });
                              showCustomSnackbar(
                                text: 'Correct',
                                icon: Icons.done,
                                context: context,
                              );
                            } else {
                              setState(() {
                                counts[questionNumber-1]++;
                                if(counts[questionNumber-1]==1){
                                  marks[questionNumber - 1]--;
                                }
                                isCorrenctOptionChosen2 = true;
                              });
                              showCustomSnackbar(
                                text: 'Wrong',
                                icon: Icons.close,
                                context: context,
                              );
                            }
                          },
                              isCorrenctOptionChosen2
                                  ? (correctOptions[2])?Colors.green:Colors.red
                                  : Colors.white),
                          OptionsTile(2, context, () {
                            if (correctOptions[3] == true) {
                              setState(() {
                                counts[questionNumber-1]++;
                                if(counts[questionNumber-1]==1){
                                  marks[questionNumber - 1]++;
                                }
                                isCorrenctOptionChosen3 = true;
                              });
                              showCustomSnackbar(
                                text: 'Correct',
                                icon: Icons.done,
                                context: context,
                              );
                            } else {
                              setState(() {
                                counts[questionNumber-1]++;
                                if(counts[questionNumber-1]==1){
                                  marks[questionNumber - 1]--;
                                }
                                isCorrenctOptionChosen3 = true;
                              });
                              showCustomSnackbar(
                                text: 'Wrong',
                                icon: Icons.close,
                                context: context,
                              );
                            }
                          },
                              isCorrenctOptionChosen3
                                  ? (correctOptions[3])?Colors.green:Colors.red
                                  : Colors.white),
                          OptionsTile(3, context, () {
                            if (correctOptions[4] == true) {
                              setState(() {
                                counts[questionNumber-1]++;
                                if(counts[questionNumber-1]==1){
                                  marks[questionNumber - 1]++;
                                }
                                isCorrenctOptionChosen4 = true;
                              });
                              showCustomSnackbar(
                                text: 'Correct',
                                icon: Icons.done,
                                context: context,
                              );
                            } else {
                              setState(() {
                                counts[questionNumber-1]++;
                                if(counts[questionNumber-1]==1){
                                  marks[questionNumber - 1]--;
                                }
                                isCorrenctOptionChosen4 = true;
                              });
                              showCustomSnackbar(
                                text: 'Wrong',
                                icon: Icons.close,
                                context: context,
                              );
                            }
                          },
                              isCorrenctOptionChosen4
                                  ? (correctOptions[4])?Colors.green:Colors.red
                                  : Colors.white),
                          SizedBox(
                            height: Dimensions.height10 * 2,
                          ),
                          Container(
                            height: Dimensions.height10 * 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadius15),
                            ),
                            child: isSliderOpen
                                ? FadeInRight(
                                    from: 50,
                                    duration: const Duration(milliseconds: 375),
                                    animate: true,
                                    child: Scrollbar(
                                      child: GridView.builder(
                                        itemCount: _userQuestions!.keys.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 6,
                                          crossAxisSpacing: 7,
                                          mainAxisSpacing: 7,
                                          childAspectRatio: 1 / 1,
                                        ),
                                        itemBuilder: (_, idx) {
                                          return Material(
                                            elevation: 3.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  colors[questionNumber-1],
                                              child: Center(
                                                  child: Text(
                                                '${idx + 1}',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          SizedBox(
                            height: Dimensions.height10 * 1.6,
                          ),
                          Center(child: Text("obtained mark : ${(marks.isEmpty)?"0"
                              :marks[questionNumber-1].toString()}"),),
                          SizedBox(
                            height: Dimensions.height10 * 1.6,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              CustomButton(
                                backColor: Colors.purple,
                                onTapHandler: () {
                                  if (isCorrenctOptionChosen1 ||
                                      isCorrenctOptionChosen2 ||
                                      isCorrenctOptionChosen3 ||
                                      isCorrenctOptionChosen4) {
                                    setState(() {
                                      isVideoSolenabled = !isVideoSolenabled;
                                    });
                                    flickManager = FlickManager(
                                      videoPlayerController:
                                          VideoPlayerController.network(
                                        'https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/the_valley_compressed.mp4?raw=true',
                                        // closedCaptionFile: _loadCaptions(),
                                      ),
                                    );
                                  }
                                  //Video Controller start
                                },
                                text: 'Video Solution',
                              ),
                              const Spacer(),
                              CustomButton(
                                // backColor: Color(0xffFAD207),
                                backColor: Colors.orange,
                                text: 'Mark as Imp',
                                onTapHandler:(){
                                  setState(() {
                                    colors[questionNumber-1]=Colors.orange;
                                  });
                                }
                                    // _allSelectedChoices[questionNumber] == 0
                                    //     ? () {}
                                    //     : () {
                                    //         setState(() {
                                    //           _allSelectedChoices[
                                    //               questionNumber] = 2;
                                    //         });



                                    //       },
                              ),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              CustomButton(
                                backColor: const Color(0xff0CBC8B),
                                onTapHandler: () {
                                  if (_userQuestions!.keys.toList().length <
                                      questionNumber) {
                                    setState(() {
                                      questionNumber--;
                                      isCorrenctOptionChosen1 = false;
                                      isCorrenctOptionChosen2 = false;
                                      isCorrenctOptionChosen3 = false;
                                      isCorrenctOptionChosen4 = false;
                                      isVideoSolenabled = false;
                                    });
                                  }
                                },
                                text: 'Previous',
                              ),
                              const Spacer(),
                              CustomButton(
                                backColor: const Color(0xff000088),
                                onTapHandler: () {
                                  if (_userQuestions!.keys.toList().length >
                                      questionNumber) {
                                    setState(() {
                                      colors[questionNumber-1]=(marks[questionNumber-1]==1)?Colors.green:Colors.red;
                                    });
                                    print("${questionNumber-1} --> ${colors[questionNumber-1].toString()}");
                                    setState(() {
                                      questionNumber++;
                                      isCorrenctOptionChosen1 = false;
                                      isCorrenctOptionChosen2 = false;
                                      isCorrenctOptionChosen3 = false;
                                      isCorrenctOptionChosen4 = false;
                                      isVideoSolenabled = false;
                                    });
                                  }
                                  else{
                                    setState(() {
                                      marks.forEach((i) {
                                        totalMarks = totalMarks + i;
                                      });
                                      open=true;
                                    });Navigator.push(context, MaterialPageRoute(builder: (context)=>TotalMarksScreen(marks: totalMarks)));
                                    print(totalMarks);
                                  }
                                },
                                text: 'Next',
                              ),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // isVideoSolenabled
                  if (isVideoSolenabled)
                    Container(
                      color: Colors.black.withOpacity(0.8),
                    ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isVideoSolenabled
                        ? Center(
                            child: Container(
                                margin:
                                    EdgeInsets.all(Dimensions.borderRadius15),
                                height: Dimensions.height10 * 22,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadius15),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      FlickVideoPlayer(
                                        flickManager: flickManager!,
                                        flickVideoWithControls:
                                            FlickVideoWithControls(
                                          controls: FlickPortraitControls(),
                                        ),
                                        flickVideoWithControlsFullscreen:
                                            FlickVideoWithControls(
                                          controls: FlickLandscapeControls(),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          )
                        : Container(),
                  ),
                  if (isVideoSolenabled)
                    Positioned(
                      top: 15.0,
                      right: 15.0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        tooltip: 'Close Video Solution',
                        onPressed: () {
                          setState(() {
                            isVideoSolenabled = false;
                          });
                        },
                      ),
                    )
                ],
              ),
            ),
    );
  }

  FadeInUp OptionsTile(
      int i, BuildContext context, void Function() onTap, Color color) {
    return FadeInUp(
      from: 50,
      duration: const Duration(milliseconds: 375),
      delay: Duration(milliseconds: 100 + 100 * i),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimensions.borderRadius5),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 375),
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: Dimensions.width10 / 2),
          child: Text(
            options[i].toString(),
            style: HelperFunctions.textstyle(),
          ),
          decoration: BoxDecoration(
            color: color,
            border:
                Border.all(width: 2, color: Color.fromARGB(255, 115, 129, 115)),
            borderRadius: BorderRadius.circular(Dimensions.borderRadius12),
          ),
        ),
      ),
    );
  }
}

void showCustomSnackbar({
  required String text,
  required IconData icon,
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      elevation: 5.0,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.borderRadius12),
      ),
      duration: const Duration(seconds: 1),
      content: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: Dimensions.width10 * 2,
          ),
          Text(text),
        ],
      ),
    ),
  );
}
