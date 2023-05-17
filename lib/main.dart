// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static const color = Color.fromARGB(255, 252, 251, 247);
  final tudoocolor = Colors.black;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final vartudoolist = Tudoo.tudoolist();
  final _tudoocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: MyApp.color,
        appBar: _appBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  // searchBar(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text(
                            ' Your Tudoos',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        for (Tudoo tudoofor in vartudoolist)
                          TudooList(
                            tudoovar: tudoofor,
                            onTudooChanged: tudooFunction,
                            onDeleteItem: onDelete,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 1,
                      ),
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                        left: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset.zero,
                            blurRadius: 11.0,
                            spreadRadius: 0.0,
                            color: Color.fromARGB(255, 244, 236, 236),
                          ),
                        ], //because applying to a list
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _tudoocontroller,
                        decoration: const InputDecoration(
                          hintText: 'Hey! Add a new Tudoo...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 25.0,
                      right: 15.0,
                    ),
                    child: Container(
                      height: 45.0,
                      width: 45,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 254, 253, 250),
                      ),
                      child: IconButton(
                        onPressed: () {
                          addTudoo(_tudoocontroller.text);
                        },
                        icon: const Icon(Icons.add_box,
                            color: Color.fromARGB(255, 144, 0, 255), size: 30),
                        iconSize: 30.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void tudooFunction(Tudoo tudoo) {
    setState(() {
      tudoo.isDone = !tudoo.isDone;
    });
    //it will make it opposite
  }

  void onDelete(String id) {
    setState(() {
      vartudoolist.removeWhere((tudoo) => tudoo.id == id);
    });
  }

  void addTudoo(String tudoo) {
    setState(() {
      if (tudoo.isEmpty) {
        return;
      }
      vartudoolist.add(Tudoo(
        tudoText: tudoo,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      ));
    });
    _tudoocontroller.clear();
  }

  AppBar _appBar() {
    var tudoocolor = Colors.black;
    return AppBar(
      backgroundColor: MyApp.color,
      shadowColor: const Color.fromARGB(62, 230, 228, 221),
      title: const Text(
        'Tudoo',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
        ),
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            padding: const EdgeInsets.only(left: 15),
            onPressed: () {
              debugPrint("Tudoo is pressed!");
            },
            icon: Icon(
              Icons.task_alt,
              color: tudoocolor,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}

class TudooList extends StatelessWidget {
  final Tudoo tudoovar;
  final onTudooChanged;
  final onDeleteItem;

  const TudooList({
    super.key,
    required this.tudoovar,
    required this.onTudooChanged,
    required this.onDeleteItem,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          onTudooChanged(tudoovar);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
          tudoovar.isDone ? Icons.check_circle_rounded : Icons.circle_outlined,
          color: tudoovar.isDone
              ? const Color.fromARGB(255, 123, 100, 198)
              : const Color.fromARGB(255, 123, 100, 198),
        ),
        title: Text(
          tudoovar.tudoText!,
          style: TextStyle(
            fontSize: 17.0,
            color: tudoovar.isDone
                ? Color.fromARGB(108, 123, 100, 198)
                : const Color.fromARGB(255, 81, 0, 221),
            decoration: tudoovar.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            onDeleteItem(tudoovar.id);
          },
          child: const Icon(
            Icons.delete_rounded,
            color: Color.fromARGB(255, 221, 15, 0),
          ),
        ),
      ),
    );
  }
}

class Tudoo {
  String? tudoText;
  String? id;
  bool isDone;

  Tudoo({
    required this.tudoText,
    required this.id,
    this.isDone = false,
  });
  static List<Tudoo> tudoolist() {
    return [
      Tudoo(
        id: '1',
        tudoText: 'Drink enough water.',
      ),
      Tudoo(
        id: '2',
        tudoText: 'Practice Yoga and Meditation.',
      ),
      Tudoo(
        id: '3',
        tudoText: 'Finish your homework.',
      ),
      Tudoo(
        id: '4',
        tudoText: 'Read something.',
      ),
      Tudoo(
        id: '5',
        tudoText: 'Add more Tudoos.',
      ),
    ];
  }
}
