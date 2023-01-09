import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../mail.dart';

final _formkey = GlobalKey<FormState>();
String _recipient = "";
String _writer = "";
String _title = "";
String _content = "";
late DateTime _dateTime;

class ShowTemporaryStorage extends StatelessWidget {
  ShowTemporaryStorage(this.mailDoc, {Key? key}) : super(key: key);
  Mail mailDoc;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            TextButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  _formkey.currentState!.save();

                  CollectionReference mail =
                  FirebaseFirestore.instance.collection('mail');
                  _dateTime = DateTime.now();

                  FirebaseFirestore.instance.collection('mail').doc(mailDoc.mail_id).update(
                      {'title':_title,
                        'content': _content,
                        'recipient': _recipient,
                        'time': _dateTime,
                      });

                  Get.back();
                }
              },
              child: Text("취소",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 15)),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("임시메일",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30)),
              IconButton(
                  onPressed: (){
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();

                      CollectionReference mail =
                      FirebaseFirestore.instance.collection('mail');
                      _dateTime = DateTime.now();

                      FirebaseFirestore.instance.collection('mail').doc(mailDoc.mail_id).update(
                          {'title':_title,
                            'content': _content,
                            'recipient': _recipient,
                            'time': _dateTime,
                            'sent': true,
                          });

                      Get.back();
                    }
                  },
                  icon: Icon(CupertinoIcons.arrow_up_circle_fill,
                      color: Colors.grey, size: 30))
            ],
          ),
        ),
        WritingForm(mailDoc),
      ],
    );
  }
}

Widget WritingForm(Mail mailDoc) => Form(
  key: _formkey,
  child: SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
    child: Column(
      children: <Widget>[
        InputField("받는 사람:", 0, mailDoc),
        InputField("보낸 사람:", 1, mailDoc),
        InputField("제목:", 2, mailDoc),
        TextFormField(
            onSaved: (value){
              _content = value as String;
            },
            validator: (value){
              if(value ==null || value!.isEmpty){
                return '내용을 입력하세요';
              }
              return null;
            },
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.multiline,
            initialValue: mailDoc.content,
            minLines: 40,
            maxLines: 100,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "내용을 입력하세요"
            )
        )
      ],
    ),
  ),

);

Widget InputField(String text, int index, Mail mailDoc){
  return TextFormField(
      onSaved: (value){
        if(index==0)
          _recipient = value as String;
        else if(index==1)
          _writer = value as String;
        else if(index==2)
          _title = value as String;
      },
      validator: (value){
        if(value==null || value!.isEmpty){
          if(index==0){
            return '수신인 메일을 입력하세요';
          } else if(index == 2){
            return '제목을 입력하세요';
          }
        }
        return null;
      },
      readOnly: (index==1) ? true: false,
      initialValue: (index ==0)? mailDoc.recipient : (index ==1? mailDoc.writer : mailDoc.title),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      autofocus: true,
      decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(
              fontSize: 12
          )
      )

  );
}

