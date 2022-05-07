import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GuitarApp extends StatefulWidget {
  const GuitarApp({ Key? key }) : super(key: key);

  @override
  State<GuitarApp> createState() => _GuitarAppState();
}

class _GuitarAppState extends State<GuitarApp> with TickerProviderStateMixin{
  //color
  Color _backgroundColor = Color.fromARGB(236, 226, 209, 1);
  //transform animation
  late AnimationController _transformAnimationController;
  late Animation<double> transformAnimation;
  //slide animation
  late AnimationController _slideAnimationController;
  late Animation<double> slideAnimation;

@override
  void initState() {
    // transform animation
    _transformAnimationController = AnimationController(duration: Duration(seconds: 2),vsync: this)
    ..forward();

    transformAnimation = Tween<double>(begin: 0.0,end: pi / 2 - 0.01).animate(
      CurvedAnimation(parent: _transformAnimationController,
        curve: Curves.fastLinearToSlowEaseIn),
    )
    ..addListener(() {
      setState(() {
        
      });
    })
    ..addStatusListener((status) {
      setState(() {
        if(status == AnimationStatus.completed){
          _transformAnimationController.reverse();
        }else if(status == AnimationStatus.dismissed){
          _transformAnimationController.forward();
        }
      });
    });

    ////////////////////////////////////////////////////
      // slide up animation
    _slideAnimationController = AnimationController(duration: Duration(seconds: 2),vsync: this)
    ..forward();

    slideAnimation = Tween<double>(begin: 0.0,end: 500.0).animate(
      CurvedAnimation(parent: _slideAnimationController,
        curve: Curves.fastLinearToSlowEaseIn),
    )
    ..addListener(() {
      setState(() {
        
      });
    })
    ..addStatusListener((status) {
      setState(() {
        if(status == AnimationStatus.completed){
          _slideAnimationController.reverse();
        }else if(status == AnimationStatus.dismissed){
          _slideAnimationController.forward();
        }
      });
    });

    super.initState();
  }




@override
  void dispose() {
    _transformAnimationController?.dispose();
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      
      body: Stack(
        children: [
          Positioned(
            top: -slideAnimation.value/2,
            left: 0,
            right: 0,
            height: screenHeight,
            
            child: Transform(
              transform: Matrix4.identity()
              ..setEntry(3,2,0.001)
              ..rotateX(-transformAnimation.value),
              alignment: FractionalOffset.center,
              child: Container(
              color: Colors.teal,
              child: Placeholder(),
              ),
            ),
            ),
            //bottom slide page
          Positioned(
            top: screenHeight - slideAnimation.value * 1.17,
            left: 0,
            right: 0,
            height: screenHeight,
            child: Container(
              color: Colors.amber,
              child: Placeholder(),
            ),
          ),  
        ],
      ),
    );
  }
}