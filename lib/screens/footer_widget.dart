import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
          decoration: const BoxDecoration(
            color: Color(0xff21375E),
          ),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          height: 60.0,
          //color: Colors.indigo.shade100,
          child: Row(
            children: [
              Expanded(child: Image(image: AssetImage('img/digi.png'),)),
              Expanded(child: Image(image: AssetImage('img/nic.png'),)),
              Expanded(flex: 2,child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  children:[
                    Flexible(
                        child: new Text('Designed & Developed By NIC, Sikkim',style: TextStyle(color: Colors.white),)
                    ),
                    //Text('NIC, Sikkim',style: TextStyle(color: Colors.white))
                  ], ),
              )),
            ],
          )
      ),
    );
  }
}