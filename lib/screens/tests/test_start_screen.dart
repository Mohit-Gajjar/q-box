import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:video_player/video_player.dart';

import '../../helpers/helpers.dart';
import '../../widgets/custom_button.dart';

class TestStartScreen extends StatefulWidget {
  const TestStartScreen({Key? key}) : super(key: key);

  static const routeName = '/Test-Start-Screen';

  @override
  State<TestStartScreen> createState() => _TestStartScreenState();
}

class _TestStartScreenState extends State<TestStartScreen> {
  int questionNumber = 0;
  bool isOptionChosen = false;
  bool isVideoSolenabled = false;
  final List<int> _allSelectedChoices = List.filled(20, 0);

  VideoPlayerController? _controller;

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          child: Text(
            'Test Name',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: Dimensions.width10 * 1.8,
                  right: Dimensions.width10 * 1.8,
                  top: Dimensions.height10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.borderRadius15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.padding20 * 0.75),
                        child: Text(
                          '${questionNumber + 1}.  {questions[questionNumber].question}',
                          style: HelperFunctions.textstyle(),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    for (int i = 0; i < 4; i++)
                      InkWell(
                        onTap: () {
                          // if (_allSelectedChoices[questionNumber] == 0 ||
                          //     _allSelectedChoices[questionNumber] == 2) {
                          //   setState(() {
                          //     isOptionChosen = true;
                          //   });

                          //   //if correct
                          //   if (i ==
                          //       questions[questionNumber].correctOption - 1) {
                          //     setState(() {
                          //       _allSelectedChoices[questionNumber] = 1;
                          //     });
                          //     showCustomSnackbar(
                          //         text: 'Correct',
                          //         icon: Icons.done,
                          //         context: context);
                          //   } //if wrong
                          //   else {
                          //     setState(() {
                          //       _allSelectedChoices[questionNumber] = -1;
                          //     });
                          //     showCustomSnackbar(
                          //         text: 'Wrong',
                          //         icon: Icons.close,
                          //         context: context);
                          //   }
                          // }
                        },
                        borderRadius:
                            BorderRadius.circular(Dimensions.borderRadius5),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 375),
                          padding: EdgeInsets.all(Dimensions.padding20 / 2),
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              vertical: Dimensions.height10 / 2),
                          child: Text(
                            " questions[questionNumber].options[i]",
                            style: isOptionChosen
                                ? HelperFunctions.textstyleWhite()
                                : HelperFunctions.textstyle(),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.8),
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: Dimensions.height10 * 2.5,
                    ),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(Dimensions.borderRadius15),
                      child: Container(
                        height: Dimensions.height10 * 12,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.borderRadius15),
                        ),
                        child: Scrollbar(
                          child: GridView.builder(
                            itemCount: 4,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 7,
                              mainAxisSpacing: 7,
                              childAspectRatio: 1 / 1,
                            ),
                            itemBuilder: (_, idx) {
                              return Scrollbar(
                                child: Container(
                                  margin: EdgeInsets.all(
                                      Dimensions.padding20 * (3 / 20)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.borderRadius5 * 20),
                                    color: HelperFunctions.getColorTests(
                                        _allSelectedChoices[idx]),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10 * 1.5,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        CustomButton(
                          backColor: Colors.purple,
                          onTapHandler: () {
                            setState(() {
                              _allSelectedChoices[questionNumber] = 2;
                            });
                          },
                          text: 'Save for Later',
                        ),
                        if (questionNumber == 0 - 1) const Spacer(),
                        if (questionNumber == 0 - 1)
                          CustomButton(
                              // backColor: Color(0xffFAD207),
                              backColor: const Color(0xff076AFE),
                              text: 'Submit',
                              onTapHandler: () {}),
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
                            if (questionNumber != 0) {
                              setState(() {
                                questionNumber--;
                                isOptionChosen = false;
                              });
                            }
                          },
                          text: 'Previous',
                        ),
                        const Spacer(),
                        CustomButton(
                          backColor: const Color(0xff000088),
                          onTapHandler: () {
                            if (questionNumber < 0 - 1) {
                              setState(() {
                                questionNumber++;
                                isOptionChosen = false;
                                isVideoSolenabled = false;
                              });
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
                        margin: const EdgeInsets.all(15.0),
                        height: Dimensions.height10 * 22,
                        width: double.infinity,
                        child: _controller!.value.isInitialized
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadius15),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    AspectRatio(
                                      aspectRatio:
                                          _controller!.value.aspectRatio,
                                      child: VideoPlayer(_controller!),
                                    ),
                                    Positioned(
                                      bottom: Dimensions.height10 / 2,
                                      left: Dimensions.width10 / 2,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _controller!.value.isPlaying
                                                ? _controller!.pause()
                                                : _controller!.play();
                                          });
                                        },
                                        icon: Icon(
                                          _controller!.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    )
                  : Container(),
            ),
            if (isVideoSolenabled)
              Positioned(
                top: Dimensions.height10 * 1.5,
                right: Dimensions.width15,
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
