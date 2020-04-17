import 'package:animatedui/SearchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin{

  AnimationController controller ;
Animation tabAnimation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this
    );

    controller.addStatusListener((status){
      if(status==AnimationStatus.completed){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SearchPage(),
          ));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

   controller.reset();
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          background(context),
          Positioned(top: height * .4,
                         child:SingleChildScrollView(
                           child: Column(
                             children: <Widget>[
                               tabBar(context),
                               events(context)
                             ],
                           ),
                         )),
//          Positioned(top: height * .48, child: events(context)),
        ],
      ),
    ));
  }

  Widget background(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: height,
            width: width * .42,
            color: Colors.lightBlueAccent.withOpacity(.1),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            height: width * .7,
            width: width * .8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
              color: Colors.lightBlueAccent.withOpacity(.6),
            ),
          ),
        ),
        Positioned(
          top: height * .13,
          left: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "You're in",
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                decoration:BoxDecoration(
                  border: Border(bottom: BorderSide(
                    color:  Colors.red,
                    width: 2
                  ))
                ),
                child: Text(
                  "New York",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                ))
              )],
          ),
        ),
        Positioned(
          top: width * .7 - 35,
          right: width * .1,
          child: AnimatedBuilder(
            animation: controller.view,
            builder: (context,child){
              return Transform.rotate(
                angle: controller.value*3.14*.5,
                child: child,);
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.redAccent),
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  controller.forward();
                  },
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            width: width,
            height: height * .12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40)),
                color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Home",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.indigo),
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ),
                Text(
                  "Chat",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget tabBar(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var active = [true, false, false, false, false];
    var tabs = ["Popular", "Featured", "Trending", "Recent", "Favourites"];
    List<Widget> list = new List<Widget>();

    for (int i = 0; i < tabs.length; i++) {
      var tab = Container(
        padding: EdgeInsets.all(10),
        height: 50,
        width: 100,
        child: Center(
            child: Column(
          children: <Widget>[
            Text(
              tabs[i],
              style: TextStyle(
                  fontWeight: active[i] ? FontWeight.bold : null,
                  fontSize: 15,
                  color: active[i] ? Colors.black : Colors.black54),
            ),
            SizedBox(
              height: 2,
            ),
            active[i]
                ? CircleAvatar(
                    radius: 3,
                    backgroundColor: Colors.black,
                  )
                : Container()
          ],
        )),
      );
      list.add(tab);
    }

    return Container(
      width: width,
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: list,
        shrinkWrap: true,
        primary: false,
      ),
    );
  }

  Widget events(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: width * 11 / 16,
      width: width,
      child: Center(
        child: PageView(
          controller: PageController(viewportFraction: .78, initialPage: 0),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            card(context, "Tea cermony", "1270 Madison Avenue",
                "assets/tea.jpeg"),
            card(context, "Pottery", "430 Chruch Street", "assets/pottery.jpg"),
            card(context, "Painting", "500 Madison Avenue", "assets/paint.png"),
          ],
        ),
      ),
    );
  }

  Widget card(BuildContext context, String name, String address, String img) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          height: width * 9 / 16,
          width: width * 10 / 16,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black54, offset: Offset(2, 2), blurRadius: 5)
              ]),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                child: Image(
                    height: 170, image: AssetImage(img), fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 50,
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
                              style:
                                  TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            address,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
