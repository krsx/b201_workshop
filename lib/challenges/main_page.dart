import 'package:b201_flutter_workshop/challenges/add_todo_page.dart';
import 'package:b201_flutter_workshop/challenges/detail_todo_page.dart';
import 'package:b201_flutter_workshop/challenges/theme.dart';
import 'package:b201_flutter_workshop/challenges/edit_todo_page.dart';
import 'package:b201_flutter_workshop/challenges/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // List titleList = [];
  // List<String> detailList = [];
  // List checkValueList = [];

  // List<Map<String, dynamic>> data = [
  //   {
  //     'id': 1,
  //     'value': false,
  //   },
  //   {
  //     'id': 2,
  //     'value': false,
  //   },
  //   {
  //     'id': 3,
  //     'value': false,
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    // Widget todoListTile() {
    //   return ListView.builder(
    //     physics: const BouncingScrollPhysics(),
    //     shrinkWrap: true,
    //     itemCount: titleList.length,
    //     itemBuilder: (context, index) {
    //       return Column(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Row(
    //               children: [
    //                 Checkbox(
    //                   value: checkValueList[index],
    //                   onChanged: (value) {
    //                     setState(() {
    //                       checkValueList[index] = value;
    //                     });
    //                   },
    //                 ),
    //                 const SizedBox(
    //                   width: 8,
    //                 ),
    //                 Expanded(
    //                   child: GestureDetector(
    //                     onTap: () {
    //                       Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                           builder: (context) => const DetailTodoPage(),
    //                         ),
    //                       );
    //                     },
    //                     child: Column(
    //                       mainAxisSize: MainAxisSize.max,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           titleList[index],
    //                           style: GoogleFonts.poppins(fontWeight: medium),
    //                         ),
    //                         Text(
    //                           detailList[index],
    //                           style: GoogleFonts.poppins(
    //                             fontWeight: reguler,
    //                             fontSize: 12,
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {
    //                     Navigator.pushNamed(context, "/edit");
    //                   },
    //                   child: const Icon(Icons.edit),
    //                 ),
    //                 const SizedBox(
    //                   width: 14,
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {},
    //                   child: const Icon(Icons.delete),
    //                 ),
    //                 const SizedBox(
    //                   width: 10,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const Divider(
    //             height: 2,
    //             thickness: 1,
    //             color: Colors.grey,
    //           )
    //         ],
    //       );
    //     },
    //   );
    // }

    Stream<List<TodoModel>> readTodos() {
      final doc = FirebaseFirestore.instance.collection("todos").doc();
      return FirebaseFirestore.instance.collection("todos").snapshots().map(
          (snapshot) =>
              snapshot.docs.map((e) => TodoModel.fromJson(e.data())).toList());
    }

    Widget buildTodos(TodoModel todo) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Checkbox(
                  value: todo.isDone,
                  onChanged: (value) {
                    setState(() {
                      final doc = FirebaseFirestore.instance
                          .collection("todos")
                          .doc(todo.id);
                      doc.update({"isDone": value});
                    });
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailTodoPage(
                            id: todo.id,
                            title: todo.title,
                            detail: todo.detail,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.title,
                          style: GoogleFonts.poppins(fontWeight: medium),
                        ),
                        Text(
                          todo.detail,
                          style: GoogleFonts.poppins(
                            fontWeight: reguler,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTodoPage(
                          id: todo.id,
                          title: todo.title,
                          detail: todo.detail,
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
                  onTap: () {
                    final doc = FirebaseFirestore.instance
                        .collection("todos")
                        .doc(todo.id);
                    doc.delete().then((value) {
                      final snackBar = SnackBar(
                        backgroundColor: blueColor,
                        content: Text(
                          "Data berhasil dihapus!",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  },
                  child: const Icon(Icons.delete),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          const Divider(
            height: 2,
            thickness: 1,
            color: Colors.grey,
          )
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            backgroundColor: blueColor,
            onPressed: () {
              Navigator.pushNamed(context, "/add");
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: blueColor,
            title: Text(
              "Todo List",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
          ),
          body: StreamBuilder<List<TodoModel>>(
            stream: readTodos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final todosResult = snapshot.data!;
                return ListView(
                  children: todosResult.map(buildTodos).toList(),
                );
              } else if (snapshot.hasError) {
                return Text("Error pada ${snapshot.error}");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }
}
