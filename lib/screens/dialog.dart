import 'package:flutter/material.dart';
//import 'package:phed/model/getDefaultData.dart';

class dialogs{
  static showCustomDialog(BuildContext context,String title,String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(title,style: TextStyle (color: Colors.black),),
            content: new Text(msg),
            shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
            actions: <Widget>[
              new TextButton(
                child:Center(
                  child: new Text("OK",),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  static showAlertDialog(context,String msg, success_action,{String actionType = '',String dialogType = 'Alert!'}) {
    BuildContext context1 = context;// set up the buttons
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogType),
          content: Text(msg),
          actions: [
            if(actionType!="reg") ...[
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
            TextButton(
              child: Text("Continue"),
              onPressed:  () {
                  Navigator.pushNamed(
                    context,
                    success_action,
                  );

              },
            ),
          ],
        );
      },
    );
  }


}