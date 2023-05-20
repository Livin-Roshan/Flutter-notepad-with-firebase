import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_pad/Style/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
  Map<String, dynamic> docData = snapshot.data();
  String colorId = docData['color_id'];
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Appstyle.cardsColor[int.parse(colorId)],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            docData["note_title"],
            style: Appstyle.mainTitle,
          ),
          const SizedBox(
            height: 4.0,
          ),
          Text(
            docData["creation_date"],
            style: Appstyle.dateTitle,
          ),
          const SizedBox(height: 8.0,),
          Text(
            docData["note_content"],
            style: Appstyle.mainContent,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
