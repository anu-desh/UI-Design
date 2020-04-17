import 'package:animatedui/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'dart:math' as Math;
import 'Details.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin{

  Animation tabAnimation , buttonAnimation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 750),
      vsync: this,
      );

    tabAnimation = Tween(begin: 0.08 ,end: 0).animate(
        CurvedAnimation(
            curve: Curves.easeInOut,
            parent: controller
            ));
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    controller.forward();
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child)
        {
          return Scaffold(
              body: SafeArea(
                  child: Stack(
                    children: <Widget>[
                      background(context,tabAnimation),
                      Positioned(
                        top: height * .35,
                        left: 40,
                        child: Container(
                          transform: Matrix4.translationValues(tabAnimation.value*height, 0, 0),
                          child: Text(
                            'Last Results',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            ),
                        ),
                        ),
                      History(),
                    ],
                    )));
        });
  }
}

Widget background (BuildContext context,Animation tabAnimaton) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: height * .25,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60)),
              color: Colors.lightBlueAccent.withOpacity(.6),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            height: 50,
            width: width,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.indigo),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(MaterialPageRoute(builder: (context) => Home()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.tune, color: Colors.indigo),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: 100,
            left: 50,
            child: Container(
              transform: Matrix4.translationValues(-tabAnimaton.value*width, 0, 0),
              child: Text("Search for...",
                  style: TextStyle(color: Colors.lightBlue, fontSize: 25)),
            )),

        Positioned(
          top: height * .25 - 35,
          left: 40,
          child: Container(
            transform: Matrix4.translationValues(tabAnimaton.value*width,0,0),
              padding: EdgeInsets.only(left: 10),
              height: 70,
              width: width - 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(2, 2),
                        blurRadius: 5)
                  ]),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 55,
                    width: (width - 100) / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.indigo,
                    ),
                    child: Center(
                        child: Text(
                      'Events',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  Center(
                    child: Text(
                      'Organizers',
                      style:
                          TextStyle(fontSize: 18, color: Colors.indigoAccent),
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }


class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HistoryState();
  }
}

class HistoryState extends State<History> with SingleTickerProviderStateMixin{

  Animation cardAnimation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      );

    cardAnimation = Tween(begin: 0.1 ,end: 0).animate(
        CurvedAnimation(
            curve: Curves.decelerate,
            parent: controller
            ));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    controller.forward();
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child)
    {
      return Positioned(
        top: height * .4,
        child: Container(
          height: height * 0.6,
          width: width,
          child: ListView(
            children: <Widget>[
              card(
                  "Book Talk and Signing Conference",
                  "Cos Cob,Library",
                  "Sun",
                  10,
                  "assets/books.jpeg",
                  context),
              card(
                  "World Dog Expo by WDE",
                  "520 8th Avenue",
                  "Thu",
                  12,
                  "assets/dog.jpg",
                  context),
              card(
                  "Training: Complete Hair Solution",
                  "145 Front Street",
                  "Mon",
                  23,
                  "assets/bottle.jpg",
                  context),
            ],
            ),
          ),
        );
    });
  }

  Widget card(String name, String address, String day, int date, String img,
      BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Container(
        width: width - 40,
        height: 120,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    day,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '$date',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Details(heroTag: img,name: name,address: address,)
                    ));
                },
                child: Container(
                  transform: Matrix4.translationValues(0, cardAnimation.value*height, 0),
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            offset: Offset(2, 2),
                            blurRadius: 5)
                      ]),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Hero(
                            tag:img,
                            child: Image(
                              height: 100,
                              image: AssetImage(img),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  name,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  address,
                                  style:
                                      TextStyle(fontSize: 15, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
