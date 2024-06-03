import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dialog.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'flutter_aes.dart' as faes;


TextEditingController id= TextEditingController();
bool hasSpecialCharacter = false;
var userData;
var pollData;
dynamic encryptData = '';
dynamic decryptData = '';
bool hasValidCharacters = false;

var imgStr;
var fn;
String rln = '';
bool showData = false;

class details extends StatefulWidget {
  //const details({super.key});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  final GlobalKey<FormFieldState> formFieldKey = GlobalKey();
  @override
  void initState()
  {
    super.initState();
    DefaultData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AppBar(
          title: Text('Panchayat Election'),
          centerTitle: true,
          backgroundColor: Colors.lightGreen[200],
          elevation: 0.0,
        ),
      ),
      body: SingleChildScrollView(
        child:
        Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (id) {
                      getData();
                    },
                    decoration: InputDecoration(
                      labelText: 'EPIC NO.',
                      hintText: 'Enter your EPIC Number',
                      fillColor: Colors.grey[100], filled: true,
                      suffixIcon: IconButton(
                          onPressed: getData,
                          icon: Icon(Icons.search)
                      ),
                    ),
                    controller: id,
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
            if(showData == true)...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _generatePdf,
                      child: Text('Download Voter Slip'),
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
                Image.memory(base64Decode(imgStr), width: 100, height: 100,),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Name of Elector:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5.0,),
                    Flexible(
                      child: Text(
                        '${userData['Fm_NameEn']} ${userData['LastNameEn']}',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Text(
                      'SEX:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      '${userData['SEX']}',
                    ),
                    SizedBox(width: 40.0,),
                    Text(
                      'AGE:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      '${userData['AGE']}',
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Text(
                      rln,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // if(userData['RLN_TYPE'] == 'F')...[
                    //   Text(
                    //     "Father's Name:",
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //
                    //   ),
                    // ]
                    // else if(userData['RLN_TYPE'] == 'M')...[
                    //   Text(
                    //     "Mother's Name:",
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //
                    //   ),
                    // ]
                    // else if(userData['RLN_TYPE'] == 'H')...[
                    //     Text(
                    //       "Husband's Name:",
                    //       style: TextStyle(fontWeight: FontWeight.bold),
                    //
                    //     ),
                    //   ]
                    // else...[
                    //   Text(
                    //     "Relationship's Name:",
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //
                    //   ),
                    // ],
                    SizedBox(width: 5,),
                    Flexible(
                      child: Text(
                        '${userData['Rln_Fm_NmEn']} ${userData['Rln_L_NmEn']}',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Center(
                  child: Text(
                    'POLLING STATION DETAILS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text(
                      'EPIC NO:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      '${userData['IDCARD_NO']}',
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Center(
                  child:
                  Table(
                    defaultColumnWidth: FixedColumnWidth(180.0),
                    border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "GPU NAME:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text(
                                    '${userData['GPU_NAME']}'),
                                SizedBox(height: 5,),

                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("WARD NAME:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text(
                                    '${userData['WARD_NAME']}'),
                                SizedBox(height: 5,),

                              ],
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("VOTER'S SERIAL NO.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text(
                                    '${userData['SL_NO']}'),
                                SizedBox(height: 5,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("POLLING STATION:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text(
                                    '${pollData['POLLING_STATION']}'),
                                SizedBox(height: 5,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // ],
              SizedBox(height: 20,),
              ],
        if(showData == false)...[
          Text("Enter EPIC Number to view your details.")
        ]

    ],
          ),
        ),
      ),


    );
  }
  void DefaultData() {
    setState(() {
      showData = false;
      id.text = '';
    });
  }
  void getData() async {
    var idvalue = id.text.toString();
    hasSpecialCharacter = idvalue.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if(hasSpecialCharacter== false) {
      var requestParam = {
        "id": idvalue
      };
      encryptData = faes.encrypt_aes(requestParam);
      var url = Uri.parse("http://164.100.244.1:80/api/getinfo");
      // var url = Uri.parse("http://10.0.2.2:5000/api/getinfo");
      var info = await Postdata(url, jsonEncode(encryptData));
      decryptData = faes.decrypt_aes(info);
      dynamic jobj = jsonDecode(decryptData);
      if (jobj['status_code'] == 200) {
        setState(() {
          showData = true;
          userData = jobj['udata'][0];
          imgStr = jobj['img'];
          pollData = jobj['polldata'][0];

          switch(userData['RLN_TYPE']){
            case 'F':{
              rln = "FATHER'S NAME:";
            }
            break;
            case 'M':{
              rln = "MOTHER'S NAME:";
            }
            break;
            case 'H':{
              rln = "HUSBAND'S NAME:";
            }
            break;
            case 'W':{
              rln = "WIFE'S NAME:";
            }
            break;
            case 'O':{
              rln = "OTHERS:";
            }
            break;
            case 'G':{
              rln = "GUARDIAN'S NAME:";
            }
            break;
            default:{
              rln = "NAME:";
            }
          }
        });
      }
      else if (jobj['status_code'] == 504) {
        setState(() {
          showData = false;
        });
        dialogs.showCustomDialog(context, "Failed", "Invalid EPIC Number");
      }
      else {
        showData = false;
      }
    }
    else{
      setState(() {
        showData = false;
      });
      dialogs.showCustomDialog(context, "Error", "No Special Characters Allowed");
    }
  }

  Future Postdata(url, data) async {
    http.Response Response;

    Response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: data
    );
    var returnData = Response.body;
    if (returnData.length > 0) {
      return returnData;
    } else if (returnData.length == 0) {
      return {
        "errorCode": 106,
        "errorMessage": "No record received.!"
      };
    } else {
      return {
        "errorCode": 500,
        "errorMessage": 'Something went wrong!'
      };
    }
  }

  void _generatePdf() async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final image = pw.MemoryImage(base64Decode(imgStr));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        //(20.5 * PdfPageFormat.cm, 20.0 * PdfPageFormat.cm, marginAll: 2.0)
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Table(
                    columnWidths: {
                      0: pw.FractionColumnWidth(1),
                      1: pw.FractionColumnWidth(0),
                    },
                    border: pw.TableBorder.all(
                      style: pw.BorderStyle.solid,
                      width: 1.0,
                    ),
                    children: [
                      pw.TableRow(
                          children: [
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Text("Election to the Zilla/Gram Panchayat Unit Voter's Slip")
                                ]
                            ),
                          ]
                      ),
                    ],
                  ),
                  pw.Center(
                    child: pw.Table(
                      columnWidths: {
                        0: pw.FractionColumnWidth(0.82),
                        1: pw.FractionColumnWidth(0.18),
                      },
                      border: pw.TableBorder.all(
                        style: pw.BorderStyle.solid,
                        width: 1.0,
                      ),
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Column(
                              children: [
                                pw.Row(
                                  children: [
                                    pw.Text('No & Name of TC/GPU: '),
                                    pw.Flexible(
                                      child: pw.Text(
                                          '${pollData['TC_NAME']} / ${userData['GPU_NAME']}'
                                      ),
                                    ),
                                  ],
                                ),
                                pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children: [
                                    pw.Text('Ward No/Ward Name: '),
                                    pw.Text(
                                        '${userData['WARD_NAME']}'
                                    ),
                                  ],
                                ),
                                pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children: [
                                    pw.Text('Name of Elector: '),
                                    pw.Text(
                                        '${userData['Fm_NameEn']} ${userData['LastNameEn']}',
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 10.0,),
                                pw.Row(
                                  children: [
                                    pw.Text(
                                      'SEX: ',
                                    ),
                                    pw.Text(
                                        '${userData['SEX']}',
                                    ),
                                    pw.SizedBox(width: 20.0,),
                                    pw.Text(
                                      'AGE: ',
                                    ),
                                    pw.Text(
                                        '${userData['AGE']}',
                                    ),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Text(
                                      rln,
                                    ),
                                    pw.Flexible(
                                      child: pw.Text(
                                          '${userData['Rln_Fm_NmEn']} ${userData['Rln_L_NmEn']}',
                                      ),
                                    ),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Text(
                                      'EPIC :',
                                    ),
                                    pw.SizedBox(width: 5,),
                                    pw.Text(
                                        '${userData['IDCARD_NO']}',
                                    ),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Text(
                                      'Polling station No and Name: ',
                                    ),
                                    pw.SizedBox(width: 5,),
                                    pw.Flexible(
                                      child: pw.Text(
                                          '${pollData['POLLING_STATION']}',
                                        ),
                                    ),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Text(
                                      "Voter's Serial No: ",
                                    ),
                                    pw.Text(
                                        '${userData['SL_NO']}',
                                    ),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Text(
                                      'Poll Date, Day and Time: ',
                                    ),
                                    pw.Flexible(
                                      child: pw.Text(
                                        '10/11/2022, Thursday, 8 A.M. to 5 P.M.',
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 2,),
                              ],
                            ),
                            pw.Column(
                              children: [
                                pw.Image(
                                  image,
                                  height: 110,
                                  width: 110,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  pw.Table(
                    columnWidths: {
                      0: pw.FractionColumnWidth(1),
                      1: pw.FractionColumnWidth(0),
                    },
                    border: pw.TableBorder.all(
                      style: pw.BorderStyle.solid,
                      width: 1.0,
                    ),
                    children: [
                      pw.TableRow(
                          children: [
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text("Note 1. This voters slip is an approved document for identification."),
                                  pw.Text("Note 2. This authenticated voter's slip is allowed as one of the identify documents"),
                                  pw.Text("Note 3. If this voter slip does not have a photograph or it has wrong particulars or photograph, the voter can still be allowed to vote based on alternate identity document permitted by State Election Commission."),
                                ],
                            )
                          ]
                      ),
                    ],
                  ),

                ],
            ),
          );
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save(), name: '${userData['IDCARD_NO']}');

  }
}

