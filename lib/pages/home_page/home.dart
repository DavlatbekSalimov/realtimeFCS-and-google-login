import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_fcs/firebase_service/ref_service.dart';
import 'package:realtime_fcs/model/notes_model.dart';

List<Color> colors = [
  Colors.deepPurpleAccent,
  Colors.indigoAccent,
  Colors.teal,
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //? controller
  final titleCtr = TextEditingController();
  final subtitleCtr = TextEditingController();
  List<DataSnapshot> notes = [];
  //? read
  Future<void> readdata() async {
    await FCService.read(
      parentPath: 'notes',
    ).then((value) {
      notes = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    readdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 43, 166),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 22, 43, 166),
        centerTitle: true,
        title: Text(
          'N O T E S',
          style: GoogleFonts.aDLaMDisplay(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: notes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              Map item = (notes[index].value as Map);
              return InkWell(
                onTap: () {
                  final titleCtrr = TextEditingController(text: item['title']);
                  final subtitleCtrr =
                      TextEditingController(text: item['subtitle']);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Editing Notes'),
                                TextField(
                                  controller: titleCtrr,
                                  decoration: const InputDecoration(
                                    hintText: 'Title',
                                  ),
                                ),
                                TextField(
                                  controller: subtitleCtrr,
                                  decoration: const InputDecoration(
                                    hintText: 'SubTitle',
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(244, 67, 54, 1)),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'Save',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      onPressed: () async {
                                        NotesModel data = NotesModel(
                                            title: titleCtrr.text,
                                            subtitle: subtitleCtrr.text);
                                        await FCService.update(
                                            data: data,
                                            id: notes[index].key.toString());
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                        await readdata();
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                  ////////////////////////////////
                },
                onLongPress: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text('Dalete'),
                          actions: [
                            CupertinoButton(
                                child: const Text('Yes'),
                                onPressed: () async {
                                  await FCService.delete(
                                    id: notes[index].key.toString(),
                                  );
                                  await readdata();
                                  // ignore: unused_element, non_constant_identifier_names
                                  SetState() {}
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                })
                          ],
                        );
                      });
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: const Alignment(0.2, 1),
                      colors: [
                        colors[Random().nextInt(3)],
                        colors[Random().nextInt(3)],
                        colors[Random().nextInt(3)],
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: GoogleFonts.tillana(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Text(
                          item['subtitle'].toString(),
                          style: GoogleFonts.coda(
                            textStyle: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Editing Notes'),
                        TextField(
                          controller: titleCtr,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                          ),
                        ),
                        TextField(
                          maxLines: 5,
                          controller: subtitleCtr,
                          decoration: const InputDecoration(
                            hintText: 'SubTitle',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Color.fromRGBO(244, 67, 54, 1)),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: const Text(
                                'Save',
                                style: TextStyle(color: Colors.green),
                              ),
                              onPressed: () async {
                                NotesModel data = NotesModel(
                                    title: titleCtr.text,
                                    subtitle: subtitleCtr.text);
                                await FCService.create(
                                  dbPaht: 'notes',
                                  data: data.toJson(),
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                await readdata();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
