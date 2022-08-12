import 'package:b201_flutter_workshop/challenges/edit_todo_page.dart';
import 'package:b201_flutter_workshop/challenges/theme.dart';
import 'package:b201_flutter_workshop/challenges/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailTodoPage extends StatefulWidget {
  final String? id;
  final String title;
  final String detail;

  const DetailTodoPage({
    Key? key,
    required this.id,
    required this.title,
    required this.detail,
  }) : super(key: key);

  @override
  State<DetailTodoPage> createState() => _DetailTodoPageState();
}

class _DetailTodoPageState extends State<DetailTodoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: blueColor,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTodoPage(
                      id: widget.id,
                      title: widget.title,
                      detail: widget.detail,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.edit),
            ),
            const SizedBox(
              width: 14,
            ),
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.delete),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
          title: Text(
            "Todo Details",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.title,
                style: GoogleFonts.poppins(fontWeight: semiBold, fontSize: 24),
              ),
              Text(
                widget.detail,
                style: GoogleFonts.poppins(fontWeight: reguler, fontSize: 14),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(blueColor)),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/main");
                    final doc = FirebaseFirestore.instance
                        .collection("todos")
                        .doc(widget.id);
                    doc.update({"isDone": true});
                  },
                  child: Text(
                    "MARK AS DONE",
                    style: GoogleFonts.poppins(
                      fontWeight: medium,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
