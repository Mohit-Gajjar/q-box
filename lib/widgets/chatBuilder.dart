import 'package:flutter/material.dart';

Widget userChat(String msg){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Text(msg),
        ),
        SizedBox(width: 10,),
        CircleAvatar(child: Image.asset("assets/images/img.png",),radius: 40,),
      ],
    ),
  );
}
Widget botChat(String msg){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(child: Image.asset("assets/images/img.png",),radius: 40,),
        SizedBox(width: 10,),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Text(msg),
        ),
      ],
    ),
  );
}

Widget buildChat(List<Map<String, String>> msg){
  return ListView.builder(
    itemCount: msg.length,
    itemBuilder: (context, index){
      return (msg[index]["user"]=="1")
          ? botChat(msg[index]["msg"]??"")
          : userChat(msg[index]["msg"]??"");
    },
  );
}

class ChatUi extends StatefulWidget {
  const ChatUi({Key? key}) : super(key: key);

  @override
  State<ChatUi> createState() => _ChatUiState();
}

class _ChatUiState extends State<ChatUi> {
  List<Map<String, String>> msgs = [{"msg": "hi", "user":"1"}]; // 1--> bot, 2 --> student
  List<String> relatedMsg = ["Hi!", "What's your name", "Today class?"];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top : 8.0),
              child: Container(
                  height: height/1.35,
                  width: width,
                  child: buildChat(msgs)
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Related Questions", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 100,
                    width: width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: relatedMsg.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: GestureDetector(
                            onTap: (){
                              setState((){
                                msgs.add({"msg":relatedMsg[index], "user": "2"});
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey
                              ),
                              child: Text(relatedMsg[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
