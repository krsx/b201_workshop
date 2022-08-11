import 'package:b201_flutter_workshop/challenges/add_todo_page.dart';
import 'package:b201_flutter_workshop/challenges/detail_todo_page.dart';
import 'package:b201_flutter_workshop/challenges/theme.dart';
import 'package:b201_flutter_workshop/challenges/edit_todo_page.dart';
import 'package:b201_flutter_workshop/challenges/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List titleList = [];
  List detailList = [];
  List checkValueList = [];

  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(
      Duration.zero,
      () {
        final args = ModalRoute.of(context)!.settings.arguments as TodoModel;
        titleList.add(args.title);
        detailList.add(args.detail);
        checkValueList.add(false);
      },
    );

    super.initState();
  }

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
    print(titleList.length);
    Widget todoListTile() {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: titleList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: checkValueList[index],
                      onChanged: (value) {
                        setState(() {
                          checkValueList[index] = value;
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
                              builder: (context) => const DetailTodoPage(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              titleList[index],
                              style: GoogleFonts.poppins(fontWeight: medium),
                            ),
                            Text(
                              detailList[index],
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
                        Navigator.pushNamed(context, "/edit");
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
        },
      );
    }

    return SafeArea(
      child: Scaffold(
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
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            todoListTile(),
          ],
        ),
      ),
    );
  }
}
