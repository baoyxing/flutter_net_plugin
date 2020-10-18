import 'dart:collection';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
class DataHelper {
  static SplayTreeMap getBaseMap() {
    var map = new SplayTreeMap<String,dynamic>();
    map["time"] = new DateTime.now().microsecondsSinceEpoch.toString();
    return map;
  }

  static encryptParams(SplayTreeMap<String, dynamic> map,String signKey) {
    var buffer = StringBuffer();
    buffer.write(signKey+"&");
    map.forEach((key, value) {
      buffer.write(key + "=" + value+"&");
    });
    buffer.write(signKey);
    var sign = sha512.convert(utf8.encode(buffer.toString())).toString();
    map["sign"] = sign;
    FormData formData = FormData.fromMap(map);
    return formData;
  }
}
