import 'package:flutter/material.dart';
import 'package:flutter_db/models/Favorite.dart';
import 'package:flutter_db/providers/favpro.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class FavScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  //controller
  final FlutterTts tts = FlutterTts();
  final messageController = TextEditingController(); //รับค่าข้อความ


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("พิมพ์ข้อความ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'พิมพ์ข้อความที่นี่...',
                  suffixIcon: IconButton(
                    onPressed: messageController.clear,
                    icon: Icon(Icons.clear),
                  ),
                ),
                //autofocus: true,
                controller: messageController,
                validator: (str) {
                  if (str!.isEmpty) {
                    return "กรูณาพิมพ์ข้อความ";
                  }
                  return null;
                },
              ),
              Center(
                child: ElevatedButton(
                  child: Text("อ่านข้อความ"),
                  onPressed: () {
                    tts.speak(messageController.text);
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                    child: Text("รายการโปรด"),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        //แสดงข้อมูลที่ผู้ใช้ป้อนหลังจากกดปุ่ม
                        var message = messageController.text;

                        //เตรียมข้อมูลลง provider ซึ่งเป็นก้อนข้อมูลที่กรอกมา
                        Favorite favor = Favorite(message: message); //object

                        //print(message);
                        //เรียก provider
                        var provider =
                            Provider.of<Favoriteprovider>(context, listen: false);
                        provider.addFavorite(favor);
                        Navigator.pop(context);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
