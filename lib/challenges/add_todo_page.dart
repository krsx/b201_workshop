import 'package:b201_flutter_workshop/challenges/theme.dart';
import 'package:b201_flutter_workshop/challenges/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: blueColor,
        title: Text(
          "Add Todo",
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
                    style: GoogleFonts.poppins(),
                  ),
                  hintText: "Todo title...",
                  hintStyle: GoogleFonts.poppins(),
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
                  hintText: "Todo detail...",
                  hintStyle: GoogleFonts.poppins(),
                ),
                controller: detailController,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 10),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(blueColor),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/main",
                      arguments: TodoModel(
                        title: titleController.text,
                        detail: detailController.text,
                      ),
                    );
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

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    detailController.dispose();
    super.dispose();
  }
}
