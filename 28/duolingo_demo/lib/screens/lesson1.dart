import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duolingo_demo/screens/screens.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Lesson1 extends StatefulWidget {
  String homeIndex;
  Lesson1(this.homeIndex);
  @override
  _Lesson1State createState() => _Lesson1State(homeIndex);
}

class _Lesson1State extends State<Lesson1> {
  String homeIndex;
  _Lesson1State(this.homeIndex);

  String lesson; // lay ten cua bai hoc trong homeIndex
  var question = []; // mang chua cac cau hoi trong 1 homeIndex
  int countQuestion; // dem so cau hoi cung dang bai
  String resultText;
  int process; // tien do hoan thanh
  static const int totalQuestionLesson1 = 2;
  static const int totalQuestionOfLesson = 8;

  // ignore: missing_return
  Future<String> getData() async {
    final DocumentReference document =
        // ignore: deprecated_member_use
        FirebaseFirestore.instance.collection("home").document(homeIndex);

    // ignore: missing_return
    await document.get().then<String>((DocumentSnapshot snapshot) async {
      setState(() {
        lesson = snapshot.data()['lesson1'];
        question = lesson.split(" ").map((e) => int.parse(e)).toList();
      });
    });
  }

  bool isTapped;
  var numberTapped;
  int result; // var dung trong body de hien thi widget button nao.
  var isChecked = [false, false, false, false];
  // luu vi tri gan nhat duoc Tap
  var lastChecked;

  @override
  void initState() {
    super.initState();
    result = 0;
    isTapped = false;
    numberTapped = 0;
    lastChecked = 0;
    countQuestion = 0;
    process = 0;
    resultText = "";
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 2,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Image.asset('assets/images/x_button.jpg',
                          height: 25)),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 15,
                        width: 210,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 216 / totalQuestionOfLesson * countQuestion,
                        decoration: new BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )
                    ],
                  ),
                  Image.asset('assets/images/heart.jpg', height: 30),
                ])),
        body: StreamBuilder(
            // tạo luồng firebase tới collection 'lesson2'
            stream:
                FirebaseFirestore.instance.collection('lesson1').snapshots(),
            // lấy dữ liệu từ firebase thông qua snapshot
            builder: (context, snapshot) {
              //if (!snapshot.hasData) return Text('Loading data...');
              return createBody(
                  snapshot.data.documents[question[countQuestion]]['question'],
                  snapshot.data.documents[question[countQuestion]]
                      ['resultText'],
                  snapshot.data.documents[question[countQuestion]]
                      ['urlAnswer1'],
                  snapshot.data.documents[question[countQuestion]]
                      ['urlAnswer2'],
                  snapshot.data.documents[question[countQuestion]]
                      ['urlAnswer3'],
                  snapshot.data.documents[question[countQuestion]]
                      ['urlAnswer4']);
            }));
  }

  Widget createBody(String question, String resultTextData, String urlAnswer1,
      String urlAnswer2, String urlAnswer3, String urlAnswer4) {
    resultText = resultTextData;
    return new Container(
      //margin: const EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 0, bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // new Padding(padding: EdgeInsets.all(10.0)),
          Container(
            margin: EdgeInsets.only(left: 15.0, right: 0.0, top: 10, bottom: 0),
            alignment: Alignment.topLeft,
            height: 30,
            child: Text(
              question,
              style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              answer(urlAnswer1, 1),
              answer(urlAnswer2, 2),
            ],
          ),
          // new Padding(padding: EdgeInsets.all(5.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              answer(urlAnswer3, 3),
              answer(urlAnswer4, 4),
            ],
          ),
          //checkButton(isTapped: isTapped, numberTapped: numberTapped),
          if (result == 0) checkButton(),
          if (result == 1) rightCheckButton(),
          if (result == 2) falseCheckButton(),
        ],
      ),
    );
  }

  Widget answer(String image, var number) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (lastChecked != 0) {
            isChecked[lastChecked - 1] = false;
          }
          isTapped = true;
          numberTapped = number;
          lastChecked = number;
          isChecked[number - 1] = true;
        });
      },
      child: Container(
        height: 190,
        width: 140,
        decoration: new BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: isChecked[number - 1] ? Colors.blue : Colors.grey,
              width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Image.network(
          image,
          height: 190,
        ),
      ),
    );
  }

  Widget checkButton() {
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
      child: MaterialButton(
        minWidth: 340.0,
        color: isTapped ? Colors.green : Colors.grey,
        height: 40.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () {
          if (isTapped) {
            if (numberTapped == 1) {
              // Navigator.push(
              //     // EDIT: lesson1 -> lesson1
              //     context,
              //     MaterialPageRoute(builder: (context) => Lesson1_TrueResult()));
              result = 1;
              setState(() {});
            } else {
              // Navigator.push(
              //     // EDIT: lesson1 -> lesson1
              //     context,
              //     MaterialPageRoute(builder: (context) => Lesson1_FalseResult()));
              result = 2;
              setState(() {});
            }
          }
        },
        child: new Text(
          'KIỂM TRA',
          style: new TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget falseCheckButton() {
    return Container(
      width: 400,
      height: 50,
      child: Stack(
        children: <Widget>[
          new Positioned(
              top: -70,
              child: Container(
                width: 500,
                height: 150.0,
                decoration: new BoxDecoration(
                  color: Colors.red[100],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    children: [
                      Text(
                        'ĐÁP ÁN ĐÚNG:',
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: Colors.red[600],
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        resultText,
                        style: new TextStyle(
                          color: Colors.red[400],
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
            child: Center(
              child: MaterialButton(
                minWidth: 350.0,
                color: Colors.red[600],
                height: 40.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  if (countQuestion < totalQuestionLesson1 - 1) {
                    countQuestion++;
                    result = 0;
                    isTapped = false;
                    isChecked = [false, false, false, false];
                    setState(() {});
                  } else {
                    Navigator.push(
                        // EDIT: lesson1 -> lesson2
                        context,
                        MaterialPageRoute(builder: (context) => Lesson2()));
                  }
                },
                child: new Text(
                  'TIẾP TỤC',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }

  Widget rightCheckButton() {
    return Container(
      width: 500,
      height: 50,
      //padding: EdgeInsets.all(2.0),
      child: Stack(
        children: <Widget>[
          new Positioned(
              top: -40,
              child: Container(
                width: 500,
                height: 120.0,
                decoration: new BoxDecoration(
                  color: Colors.lightGreenAccent[100],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 0.0, top: 10, bottom: 0),
                  child: Text(
                    'TUYỆT QUÁ!',
                    style: new TextStyle(
                      color: Colors.lightGreenAccent[700],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),
          Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
            child: Center(
              child: MaterialButton(
                minWidth: 350.0,
                color: Colors.lightGreenAccent[700],
                height: 40.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  if (countQuestion < totalQuestionLesson1 - 1) {
                    countQuestion++;
                    result = 0;
                    isTapped = false;
                    isChecked = [false, false, false, false];
                    setState(() {});
                  } else {
                    Navigator.push(
                        // EDIT: lesson1 -> lesson2
                        context,
                        MaterialPageRoute(builder: (context) => Lesson2()));
                  }
                },
                child: new Text(
                  'TIẾP TỤC',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}

// class falseCheckButton extends StatelessWidget {
//   const falseCheckButton({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 400,
//       height: 50,
//       child: Stack(
//         children: <Widget>[
//           new Positioned(
//               top: -70,
//               child: Container(
//                 width: 500,
//                 height: 150.0,
//                 decoration: new BoxDecoration(
//                   color: Colors.red[100],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: ListView(
//                     children: [
//                       Text(
//                         'ĐÁP ÁN ĐÚNG:',
//                         textAlign: TextAlign.left,
//                         style: new TextStyle(
//                           color: Colors.red[600],
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         'coffee',
//                         style: new TextStyle(
//                           color: Colors.red[400],
//                           fontSize: 20.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//           Container(
//             margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
//             child: Center(
//               child: MaterialButton(
//                 minWidth: 350.0,
//                 color: Colors.red[600],
//                 height: 40.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                       // EDIT: lesson1 -> lesson2
//                       context,
//                       MaterialPageRoute(builder: (context) => Lesson2()));
//                 },
//                 child: new Text(
//                   'TIẾP TỤC',
//                   style: new TextStyle(fontSize: 20.0, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//         overflow: Overflow.visible,
//       ),
//     );
//   }
// }

// class rightCheckButton extends StatelessWidget {
//   const rightCheckButton({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 500,
//       height: 50,
//       //padding: EdgeInsets.all(2.0),
//       child: Stack(
//         children: <Widget>[
//           new Positioned(
//               top: -40,
//               child: Container(
//                 width: 500,
//                 height: 120.0,
//                 decoration: new BoxDecoration(
//                   color: Colors.lightGreenAccent[100],
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                       left: 15.0, right: 0.0, top: 10, bottom: 0),
//                   child: Text(
//                     'TUYỆT QUÁ!',
//                     style: new TextStyle(
//                       color: Colors.lightGreenAccent[700],
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               )),
//           Container(
//             margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
//             child: Center(
//               child: MaterialButton(
//                 minWidth: 350.0,
//                 color: Colors.lightGreenAccent[700],
//                 height: 40.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                       // EDIT: lesson1 -> lesson2
//                       context,
//                       MaterialPageRoute(builder: (context) => Lesson2()));
//                 },
//                 child: new Text(
//                   'TIẾP TỤC',
//                   style: new TextStyle(fontSize: 20.0, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//         overflow: Overflow.visible,
//       ),
//     );
//   }
// }
