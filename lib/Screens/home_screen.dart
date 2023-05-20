import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_pad/Screens/note_editor.dart';
import 'package:note_pad/Screens/note_reader%20.dart';
import 'package:note_pad/Style/app_style.dart';
import 'package:note_pad/Widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("FireNotes"),
        centerTitle: true,
        backgroundColor: Appstyle.mainColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your recent Notes",
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  final screenHeight = MediaQuery.of(context).size.height;
                  final appBarHeight = AppBar().preferredSize.height;
                  final availableHeight = screenHeight - appBarHeight - 80;
                  return SizedBox(
                    height: availableHeight,
                    child: GridView(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      children: snapshot.data!.docs.map((note) => noteCard(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteReaderScreen(doc: note),
                          ),
                        );
                      }, note)).toList(),
                    ),
                  );
                }
                return Text(
                  "There's no notes",
                  style: GoogleFonts.nunito(color: Colors.white),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoteEditorScreen()),
          );
        },
        backgroundColor: Appstyle.accentColor,
        label: const Text("Add Note"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
