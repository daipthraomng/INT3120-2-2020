import 'package:flutter/material.dart';
import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lesson3 extends StatefulWidget {
  final int indexQuestion;

  const Lesson3({Key key, this.indexQuestion}) : super(key: key);
  @override
  _Lesson3State createState() => _Lesson3State();
}

class _Lesson3State extends State<Lesson3> {
  bool isTapped;
  var numberTapped;
  // trang thai man hinh: 0 - chua kiem tra
  // 1 - kiem tra dung; 2 - sai
  int result;
  var isChecked = [false, false, false];
  // luu vi tri gan nhat duoc Tap
  var lastChecked;
  int index; // chi so cua cau hoi

  @override
  void initState() {
    super.initState();
    isTapped = false;
    result = 0;
    numberTapped = 0; // chi so cua o duoc an
    lastChecked = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // thanh trạng thái, chứ nút thoát ra trang chủ chọn bài học,
        // tiến độ làm bài và streak
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 2,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Lesson3(
                                      indexQuestion: 1,
                                    )));
                      },
                      child: Image.asset('assets/images/x_button.png',
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
                        width: 2 * 210 / 8,
                        decoration: new BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )
                    ],
                  ),
                  Image.asset('assets/images/heart.png', height: 30),
                ])),
        body: StreamBuilder(
            // tạo luồng firebase tới collection 'lesson2'
            stream:
                FirebaseFirestore.instance.collection('lesson2').snapshots(),
            // lấy dữ liệu từ firebase thông qua snapshot
            builder: (context, snapshot) {
              //if (!snapshot.hasData) return Text('Loading data...');
              return createBody(
                  snapshot.data.documents[1]['question'],
                  snapshot.data.documents[1]['answer1'],
                  snapshot.data.documents[1]['answer2'],
                  snapshot.data.documents[1]['answer3']);
            })
        // body('Họ thích cà phê hơn.', 'They prefer coffee.',
        //     'They prefer food.', 'They prefer juice.'),
        );
  }

  Widget createBody(
      String question, String answer1, String answer2, String answer3) {
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 0, bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              margin:
                  EdgeInsets.only(left: 15.0, right: 0.0, top: 10, bottom: 0),
              alignment: Alignment.topLeft,
              height: 100,
              child: ListView(
                children: <Widget>[
                  Text(
                    'Chọn bản dịch đúng',
                    style: new TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Câu cần dịch
                  Text(
                    question,
                    style: new TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ],
              )),
          new Padding(padding: EdgeInsets.all(5.0)),

          // các đáp án
          SizedBox(
            height: 200, // set this
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                answer(answer1, 1),
                new Padding(padding: EdgeInsets.all(5.0)),
                answer(answer2, 2),
                new Padding(padding: EdgeInsets.all(5.0)),
                answer(answer3, 3),
              ],
            ),
          ),
          new Padding(padding: EdgeInsets.all(30.0)),

          // nút kiểm tra
          // MaterialButton(
          //   minWidth: 340.0,
          //   color: isTapped ? Colors.green : Colors.grey,
          //   height: 40.0,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          //   onPressed: () {
          //     if (numberTapped == 1) {
          //       debugPrint("true");
          //       Navigator.push(
          //           // EDIT: lesson1 -> lesson1
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => Lesson2_TrueResult()));
          //     } else {
          //       debugPrint("wrong");
          //       Navigator.push(
          //           // EDIT: lesson1 -> lesson1
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => Lesson2_FalseResult()));
          //     }
          //   },
          //   child: new Text(
          //     'KIỂM TRA',
          //     style: new TextStyle(fontSize: 20.0, color: Colors.white),
          //   ),
          // ),
          if (result == 0) CheckButton(),
          if (result == 1) RightCheckButton(),
          if (result == 2) FalseCheckButton(),
        ],
      ),
    );
  }

  // tạo nội dung cho các ô đáp án, xử lý sự kiện khi ô được chọn
  Widget answer(String answer, var number) {
    return GestureDetector(
      // hàm xử lý sự kiện chọn ô
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
        height: 40,
        width: 350,
        margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
        decoration: new BoxDecoration(
          color: isChecked[number - 1] ? Colors.blue[100] : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
              color: isChecked[number - 1] ? Colors.blue : Colors.grey,
              width: 2),
        ),

        // thêm nội dung, định dạng text trong các ô đáp án
        child: Center(
          child: new Text(
            answer,
            style: new TextStyle(fontSize: 18.0, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget CheckButton() {
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
            if (numberTapped == 2) {
              result = 1;
              setState(() {});
            } else {
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
}

class FalseCheckButton extends StatelessWidget {
  const FalseCheckButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        'They drink juice.',
                        style: new TextStyle(
                          color: Colors.red[400],
                          fontSize: 17.0,
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
                  Navigator.push(
                      // EDIT: lesson1 -> lesson2
                      context,
                      MaterialPageRoute(builder: (context) => Lesson3()));
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

class RightCheckButton extends StatelessWidget {
  const RightCheckButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Navigator.push(
                      // EDIT: lesson1 -> lesson2
                      context,
                      MaterialPageRoute(builder: (context) => Lesson3()));
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
