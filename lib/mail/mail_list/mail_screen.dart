import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reheasal/mail/mail_list/mail_list.dart';
import '../../util/size.dart';
import '../sendMail_modal.dart';

class MailScreen extends StatefulWidget {
  MailScreen(this.title, {Key? key}) : super(key: key);
  String title;

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black, size: 15),
      ),
      body: Container(
          child: Column(
            children: [
              Expanded(child: MailList(widget.title))
            ],
          )
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.equal_circle,
                    color: Colors.blueAccent,
                  )),
              Spacer(),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top:Radius.circular(10),
                          )
                        ),
                        context: context,
                        builder: (context) =>
                        Container(
                          height: getScreenHeight(context)*0.9,
                          child: MailModal(),
                        ));
                  },
                  icon: Icon(
                    CupertinoIcons.pencil_outline,
                    color: Colors.blueAccent,
                  )),
            ],
          )),
    );
  }
}
