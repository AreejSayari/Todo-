import 'todo_add.dart';
import 'package:correction/todo_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    /* Change notifier  */
    create: (context) => TodoListProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoApp'),
      ),
      body: Consumer<TodoListProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.getSize(),
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(provider.getElement(index).hashCode.toString()),
                onDismissed: (direction) =>
                    provider.removeTask(provider.getElement(index)),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.red[600],
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 12.0),
                ),
                child: ListTile(
                  title: Text(provider.getTitle(index)),
                  trailing: Checkbox(
                    value: provider.getCompleteness(index),
                    onChanged: null,
                  ),
                  onTap: () {
                    provider.changeCompleteness(provider.getElement(index));
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return NewItemView();
          }));
          //Provider.of<TodoListProvider>(context, listen: false).addNewTask(result);
        },
      ),
    );
  }
}

// StreamBuilder<QuerySnapshot>(
// stream: FirebaseFirestore.instance.collection('list').snapshots(),
// builder: (context, snapshot) {
// if (!snapshot.hasData) {
// return CircularProgressIndicator();
// }
// final documents = snapshot.data!.docs;
// return ListView.builder(
// itemCount: documents.length,
// itemBuilder: (context, index) {
// final document = documents[index];
// TextEditingController updateTitle = TextEditingController(
// text: document['Title']);
// TextEditingController updateDescription = TextEditingController(
// text: document['Description']);
// return Dismissible(
// key: Key(document.id),
// onDismissed: (direction) {
// FirebaseFirestore.instance
//     .collection('list')
//     .doc(document.id)
//     .delete();
// },
// direction: DismissDirection.startToEnd,
// background: Container(
// color: Colors.red[200],
// alignment: Alignment.centerLeft,
// padding: const EdgeInsets.only(left: 12.0),
// child: const Icon(
// Icons.delete,
// color: Colors.white,
// ),
// ),
// child: ListTile(
// title:Text(document['Title']),
// trailing: Row(
// mainAxisSize: MainAxisSize.min,
// children: [
// Checkbox(
// value: document['Completed'],
// onChanged: (value) {
// FirebaseFirestore.instance.collection('list').doc(document.id).update({'Completed': value});
//
// },
// ),
//
// IconButton(
// icon: const Icon(
// Icons.delete,
// color: Colors.red,
// ),
// onPressed: () {
// FirebaseFirestore.instance
//     .collection('list')
//     .doc(document.id)
//     .delete();
// //provider.removeTask(provider.getElement(index));
// },
// ),
// IconButton(
// icon: const Icon(
// Icons.edit,
// color: Colors.blue,
// ),
// onPressed: () {
// showDialog(context: context,
// builder: (context) =>
// AlertDialog(
// title: Text("Update Task"),
// content: SingleChildScrollView(
// child: Container(
// height: 250,
// child: Column(
// children: [
// TextField(
// style: const TextStyle(fontSize: 22,
// color: Colors.purple),
// decoration: const InputDecoration(
// labelText: "Title",
// border: OutlineInputBorder(
// borderRadius: BorderRadius
//     .all(
// Radius.circular(30))),
// ),
// controller: updateTitle,
// ),
// SizedBox(height: 20,),
// TextField(
// style: const TextStyle(fontSize: 22,
// color: Colors.purple),
// decoration: const InputDecoration(
// labelText: "Description",
// border: OutlineInputBorder(
// borderRadius: BorderRadius
//     .all(
// Radius.circular(30))),
// ),
// controller: updateDescription,
// ),
// SizedBox(height: 20,),
// ElevatedButton(
// onPressed: () {
// FirebaseFirestore.instance
//     .collection('list').doc(
// snapshot.data!.docs[index]
//     .id).update({
// 'Title': updateTitle.text,
// 'Description': updateDescription
//     .text
// }
// );
// },
// child: Container(
// width: double.infinity,
// child: Text("Update"),
// )
// ),
// ],
// ),
// ),
// ),
// actions: [
// ElevatedButton(onPressed: () {
// Navigator.pop(context, "Cancel");
// }, child: Text('Cancel'))
// ],
// ),
// );
// },
// )
// ],
// ),
// onTap: () {
// //provider.changeCompleteness(provider.getElement(index));
// },
// ),
// );
// },
// );
// },
// ),

/*
/*Dismissible(
                key: Key(document.id),
                onDismissed: (direction) {
                  FirebaseFirestore.instance
                      .collection('list')
                      .doc(document.id)
                      .delete();
                },
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.red[200],
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 12.0),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: ListTile(
                  title:Text(document['Title'],style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: document['Completed'],
                        onChanged: (value) {
                          FirebaseFirestore.instance.collection('list').doc(document.id).update({'Completed': value});

                          },
                      ),

                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('list')
                              .doc(document.id)
                              .delete();
                          //provider.removeTask(provider.getElement(index));
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          showDialog(context: context,
                            builder: (context) =>
                                AlertDialog(
                                  title: Text("Update Task"),
                                  content: SingleChildScrollView(
                                    child: Container(
                                      height: 250,
                                      child: Column(
                                        children: [
                                          TextField(
                                            style: const TextStyle(fontSize: 22,
                                                color: Colors.purple),
                                            decoration: const InputDecoration(
                                              labelText: "Title",
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius
                                                      .all(
                                                      Radius.circular(30))),
                                            ),
                                            controller: updateTitle,
                                          ),
                                          SizedBox(height: 20,),
                                          TextField(
                                            style: const TextStyle(fontSize: 22,
                                                color: Colors.purple),
                                            decoration: const InputDecoration(
                                              labelText: "Description",
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius
                                                      .all(
                                                      Radius.circular(30))),
                                            ),
                                            controller: updateDescription,
                                          ),
                                          SizedBox(height: 20,),
                                          ElevatedButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection('list').doc(
                                                    snapshot.data!.docs[index]
                                                        .id).update({
                                                  'Title': updateTitle.text,
                                                  'Description': updateDescription
                                                      .text
                                                }
                                                );
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                child: Text("Update"),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(onPressed: () {
                                      Navigator.pop(context, "Cancel");
                                    }, child: Text('Cancel'))
                                  ],
                                ),
                          );
                        },
                      )
                    ],
                  ),
                  onTap: () {
                    //provider.changeCompleteness(provider.getElement(index));
                  },
                ),
              );*/
 */

