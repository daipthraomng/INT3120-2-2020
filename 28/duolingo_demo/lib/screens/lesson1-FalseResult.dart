import 'package:duolingo_demo/screens/lesson1.dart';
import 'package:duolingo_demo/screens/lesson2.dart';
import 'package:flutter/material.dart';
import 'package:duolingo_demo/screens/lesson1-FalseResult.dart';
import 'package:duolingo_demo/screens/lesson1-TrueResult.dart';
import 'home.dart';

class Lesson1_FalseResult extends StatefulWidget {
  @override
  _Lesson1_FalseResultState createState() => _Lesson1_FalseResultState();
}

class _Lesson1_FalseResultState extends State<Lesson1_FalseResult> {
  bool isTapped;
  var numberTapped;
  var isChecked = [false, false, false, false];
  // luu vi tri gan nhat duoc Tap
  var lastChecked;

  @override
  void initState() {
    super.initState();
    isTapped = false;
    numberTapped = 0;
    lastChecked = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 2,
          title: Row(children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Image.asset('assets/images/x_button.png', height: 25)),
            SizedBox(
              width: 20,
            ),
            Container(
              child: Container(
                height: 15,
                width: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: new Container(
                  height: 15,
                  width: 20,
                  decoration: new BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Image.asset('assets/images/heart.png', height: 30),
          ])),
      body: new Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            new Padding(padding: EdgeInsets.all(10.0)),
            Container(
              alignment: Alignment.topLeft,
              height: 30,
              child: Text(
                'Hình nào là "Cà Phê"?',
                style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            new Padding(padding: EdgeInsets.all(30.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                answer(
                    'assets/images/multipleChoiceQuestion/lesson1-1/coffee.PNG',
                    1),
                answer(
                    'assets/images/multipleChoiceQuestion/lesson1-1/bread.PNG',
                    2),
              ],
            ),
            new Padding(padding: EdgeInsets.all(5.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                answer(
                    'assets/images/multipleChoiceQuestion/lesson1-1/rice.PNG',
                    3),
                answer(
                    'assets/images/multipleChoiceQuestion/lesson1-1/cake.PNG',
                    4),
              ],
            ),
            new Padding(padding: EdgeInsets.all(45.0)),
            Container(
              width: 400,
              height: 50,
              //padding: EdgeInsets.all(2.0),
              child: Stack(
                children: <Widget>[
                  new Positioned(
                      top: -70,
                      child: Container(
                        width: 420.0,
                        height: 150.0,
                        decoration: new BoxDecoration(
                          color: Colors.redAccent[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                'coffee',
                                style: new TextStyle(
                                  color: Colors.red[600],
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(1.0)),
                      Center(
                        child: MaterialButton(
                          minWidth: 340.0,
                          // color: isTapped ? Colors.green : Colors.grey,
                          color: Colors.red[600],
                          height: 40.0,
                          onPressed: () {
                            Navigator.push(
                                // EDIT: lesson1 -> lesson1
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Lesson2()));
                          },
                          child: new Text(
                            'TIẾP TỤC',
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                overflow: Overflow.visible,
              ),
            ),
          ],
        ),
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
        height: 185,
        width: 131,
        decoration: new BoxDecoration(
          color: isChecked[number - 1] ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Image.asset(image, height: 190),
      ),
    );
  }
}
