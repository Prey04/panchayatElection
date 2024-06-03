import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'screens/details.dart' as ds;

import 'screens/footer_widget.dart';
Future<void> main () async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeSc(),
  )
  );
}

class HomeSc extends StatefulWidget {
  //const HomeSc({super.key});

  @override
  State<HomeSc> createState() => _HomeScState();
}

class _HomeScState extends State<HomeSc> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(47.0),
        child: AppBar(
          title: Text('Panchayat Election 2022'),
          centerTitle: true,
          backgroundColor: Colors.blue[200],
          elevation: 0.0,
        ),
      ),
      body: Column(
        children: [
          Center(
            //padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 0),
            child: Column(
              children: [
                Image.asset('img/sk.png',
                  width: 190,
                  height: 190,),
                Text("State Election Commission,",
                    style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Sikkim",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15,),
                Image.asset('img/elec.png',
                  width: 170,
                  height: 170,),
                SizedBox(height: 35.0,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    side: BorderSide(width:2, color:Colors.brown), //border width and color
                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(15),
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ds.details()),
                    );
                  },
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          SizedBox(height:40),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('img/nic2.png',
              height: 120,),
          ],
          ),*/
        ],
      ),
      bottomNavigationBar: FooterWidget(),
    );
  }
}


