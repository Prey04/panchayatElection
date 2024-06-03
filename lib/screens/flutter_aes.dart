import 'dart:convert';

import 'package:encrypt/encrypt.dart';
Object encrypt_aes(data) {
  try {
    final key = Key.fromUtf8("ODUELGJFNDMCBAQFHCBZLOPFGYEDHSCD");
    final iv = IV.fromUtf8("UGHFJELCMDHSUWKG");
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final encrypted = encrypter.encrypt(jsonEncode(data), iv: iv);
    return encrypted.base64;
  }catch(error){
    return {"errorCode":106,"errorMessage":"Encode error. ${error}"};
  }
}

Object decrypt_aes(cipherText) {
  try{
    final key = Key.fromUtf8("ODUELGJFNDMCBAQFHCBZLOPFGYEDHSCD");
    final iv = IV.fromUtf8("UGHFJELCMDHSUWKG");
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final decrypted = encrypter.decrypt64(cipherText, iv: iv);
    return decrypted;
  }catch(error){
    return {"errorCode":106,"errorMessage":"Decode error. ${error}"};
  }
}