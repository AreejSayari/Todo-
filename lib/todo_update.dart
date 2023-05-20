import 'package:correction/todo_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateItemView extends StatelessWidget {
  final Todo document; // Assuming Todo is the data model for a task
  final TextEditingController titleFieldController = TextEditingController();
  final TextEditingController descriptionFieldController = TextEditingController();
  UpdateItemView({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleFieldController,
              decoration: const InputDecoration(
                labelText: 'Title',

              ),
            ),
            TextField(
              controller: descriptionFieldController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 70.0),
            ElevatedButton(
              onPressed: () => save(context),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void save(BuildContext context) async {
    if (titleFieldController.text.isNotEmpty) {
      Todo updatedTask = Todo(
        titleFieldController.text,
        descriptionFieldController.text,
      );

      DocumentReference docRef =
      FirebaseFirestore.instance.collection('list').doc();

      Map<String, dynamic> updatedData = {
        'title': updatedTask.title,
        'description': updatedTask.description,
      };

      await docRef.update(updatedData);

      Navigator.of(context).pop(updatedTask);
    }
  }

}