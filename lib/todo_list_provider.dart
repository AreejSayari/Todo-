import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// changeNotifier , changeNotifierProvider , consumer

class Todo{
  String title;
  String description;
  bool complete = false;
  Todo(this.title, this.description);
}
class TodoListProvider extends ChangeNotifier{

  final list  = FirebaseFirestore.instance.collection("list");

  List<Todo> list1 = <Todo>[];
  final db = FirebaseFirestore.instance;


  void changeCompleteness(Todo item){
    item.complete = !item.complete;
    notifyListeners();
  }
  Future CompleteTask (uid) async{
    await list.doc(uid).update({"Completed": true});
  }
  Future updateTask(String documentId , bool value)async{
    await FirebaseFirestore.instance.collection('list').doc(documentId).update({'Completed': value});

  }
  void addNewTask(String title , String description)
  {

    if(title != null){
      if(description != null){
        list1.add(Todo(title ,description));
        addTask(title: title ,description: description);
      }
      else{
        list1.add(Todo(title,""));
        addTask(title: title ,description: "");
      }
      notifyListeners();
    }

  }
  Future addTask({required String title ,required String description})async{
    await db.collection("list").add({
      'Title': title,
      'Description': description,
      'Completed': false
    });
  }

  void removeTask(Todo elt)
  {
    list1.remove(elt);
    notifyListeners();

    db.collection("list").doc(elt.title).delete();

  }

  String getTitle (int index)
  {
    return list1[index].title;
  }
  bool getCompleteness (int index)
  {
    return list1[index].complete;
  }
  Todo getElement(int index)
  {
    return list1[index];
  }
  int getSize()
  {
    return list1.length;
  }

}

