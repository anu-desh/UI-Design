import 'package:animatedui/SearchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final heroTag;
  final name;
  final address;

  const Details({Key key, this.heroTag, this.name, this.address})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DetailsState();
  }
}

class DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  Animation cardAnimation, anim;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      value: .5,
      vsync: this,
    );

    cardAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo);

    anim = Tween(begin: -0.5, end: 0.01).animate(CurvedAnimation(
      curve: Interval(.5,1,curve: Curves.easeInOut),
      parent: controller,
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
        builder: (BuildContext context, Widget child) {
          return Scaffold(
              body: SafeArea(
            child: Stack(children: <Widget>[
              imageBar(widget.heroTag),
              card(widget.name, widget.address, cardAnimation),
              Positioned(
                top: height * .58,
                left: 50,
                child: Container(
                  transform:Matrix4.translationValues(0,-anim.value*height,0),
                  height: 100,
                  width: width * .8,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "This weekend spectacular event will celebrate dogs everywhere in a large scale",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "See more",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              ),
              map(),
              bottomBar(),
            ]),
          ));
        });
  }

  Widget bottomBar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.only(left: width * .1, right: width * .03),
          width: width,
          height: height * .1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40)),
              color: Colors.redAccent),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text(
                    '\$45.90/guest',
                    style:
                        TextStyle(fontSize: width * .045, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: width * .25,
              ),
              Container(
                height: width * .135,
                width: (width - 100) / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.white,
                ),
                child: Center(
                    child: Text(
                  'Get a Ticket',
                  style: TextStyle(
                      fontSize: width * .045, color: Colors.redAccent),
                )),
              ),
            ],
          ),
        ));
  }

  Widget imageBar(var img) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: img,
            child: Container(
              height: height * .35,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  image: DecorationImage(
                      image: AssetImage(img), fit: BoxFit.cover)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            height: 70,
            width: width,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.indigo),
                  onPressed: () {
                    Navigator.of(context).pop(
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.indigo,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget card(var name, var address, Animation cardAnimation) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Positioned(
          top: height * .4,
          left: width / 5,
          child: Container(
            height: height * .14,
            width: width * 3 / 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 5)
                ]),
          ),
        ),
        Positioned(
          top: height * .3,
          left: width / 8,
          child: ScaleTransition(
            scale: cardAnimation,
            alignment: Alignment.center,
            child: Container(
                padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
                height: height * .22,
                width: width * 6 / 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 5)
                    ]),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: width * .15,
                          width: width * .12,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.lightBlueAccent),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Dec",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "15",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * .04,
                        ),
                        Container(
                          width: width * .4,
                          height: width * .1,
                          child: Text(
                            name,
                            style: TextStyle(
                                fontSize: width * .05,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: width * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                        ),
                        Text(
                          address,
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        )
                      ],
                    ),
                    SizedBox(
                      height: width * .03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Colors.redAccent,
                        ),
                        Text(
                          "8:00 AM - 10:00 PM",
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }

  Widget map() {
    var width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40), topLeft: Radius.circular(40)),
        child: Image(
          image: AssetImage("assets/map.png"),
          fit: BoxFit.cover,
          height: width * .5,
          width: width,
        ),
      ),
    );
  }
}
