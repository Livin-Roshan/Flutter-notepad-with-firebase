import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_pad/Style/app_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(Appstyle.cardsColor.length);
  String date = DateTime.now().toString();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: Appstyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("Add a new Note", style: Appstyle.mainTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _titleController,
            decoration:
            const InputDecoration(border: InputBorder.none, hintText: 'Note Title'),
            style: Appstyle.mainTitle,
          ),
          const SizedBox(height: 8.0),
          Text(date, style: Appstyle.dateTitle),
          const SizedBox(height: 28.0),
          TextField(
            controller: _mainController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration:
            const InputDecoration(border: InputBorder.none, hintText: 'Note Content'),
            style: Appstyle.mainContent,
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Appstyle.accentColor,  
        onPressed: () async {
          FirebaseFirestore.instance
              .collection("Notes")
              .add({
            "note_title": _titleController.text,
            "creation_date": date,
            "note_content": _mainController.text,
            "color_id": color_id
          })
              .then((value) {
            print(value.id);
            Navigator.pop(context);
          })
              .catchError(
                  (error) => print("Failed to add new note due to $error"));
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
