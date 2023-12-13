import 'package:flutter/material.dart';
import 'package:healthticktask/timerPage1.dart';
import 'package:healthticktask/timerPage2.dart';
import 'package:healthticktask/timerPage3.dart';

class pageview extends StatefulWidget {
  const pageview({super.key});

  @override
  State<pageview> createState() => _pageviewState();
}

class _pageviewState extends State<pageview> {
  int mySlideIndex = 0;
  var pages = const [timerPage1(), timerPage2(), timerPage3()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(26, 26, 38, 1),
        title: const Text(
          "Mindful Meal timer",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        elevation: 1,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color.fromRGBO(26, 26, 38, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mySlideIndex == index
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: PageView.builder(
              itemCount: 3,
              onPageChanged: (index) {
                setState(() {
                  mySlideIndex = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return pages[index];
              },
            ),
          ),
        
        ],
      ),
    );
  }
}
