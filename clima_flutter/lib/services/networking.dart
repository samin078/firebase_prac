import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this._urls);

  final String _urls;


  Future getData() async{

    final Uri _url = Uri.parse(_urls);
    http.Response response = await http.get(_url);

    if(response.statusCode == 200){
      String data = response.body;

      return jsonDecode(data);


    }else {

      print(response.statusCode);
      //return null;
    }

  }
}