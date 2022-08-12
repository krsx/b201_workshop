import 'package:b201_flutter_workshop/challenges/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTodoPage extends StatefulWidget {
  final String? id;
  final String title;
  final String detail;
  const EditTodoPage({
    Key? key,
    required this.id,
    required this.title,
    required this.detail,
  }) : super(key: key);

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    titleController = TextEditingController(text: widget.title);
    detailController = TextEditingController(text: widget.detail);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: blueColor,
        title: Text(
          "Edit Todo",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text(
                    "title",
                    style: GoogleFonts.poppins(
                      fontWeight: reguler,
                    ),
                  ),
                ),
                controller: titleController,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text(
                    "detail",
                    style: GoogleFonts.poppins(
                      fontWeight: reguler,
                    ),
                  ),
                  labelStyle: GoogleFonts.poppins(),
                ),
                controller: detailController,
              ),
              Spacer(),
              SizedBox(
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
                    final doc = FirebaseFirestore.instance
                        .collection("todos")
                        .doc(widget.id);
                    doc.update({
                      "id": widget.id,
                      "titleTodo": titleController.text,
                      "detailTodo": detailController.text,
                    }).then((value) {
                      final snackBar = SnackBar(
                        backgroundColor: blueColor,
                        content: Text(
                          "Data berhasil diperbaharui!",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "SUBMIT",
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

// ElevatedButton.styleFrom(
//                     elevation: 0,
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 12,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),