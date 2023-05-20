import 'package:correction/todo_update.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_list_provider.dart';
import 'todo_add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ToDoCard.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    List<Widget> _pages = [MyHomePage(),NewItemView()];
    void _onItemTapped(int index) {

        _selectedIndex = index;

      // Perform actions based on the selected index
      if (index == 0) {
        // Handle the first item tap
        // Do something specific to the first item
      } else if (index == 1) {
        final result = Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return NewItemView();
            }));
        //Provider.of<TodoListProvider>(context, listen: false).addNewTask(result.title, result.description);
      }
    }

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "My ToDo List",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("images/enit.jpg"),
          ),
          SizedBox(
            width: 25,
          )

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items:  [
          const BottomNavigationBarItem(icon: Icon(
            Icons.home, size: 32,color: Colors.white,
          ), label: '',
          ),
          BottomNavigationBarItem(icon: Container(
            height: 52,
            width: 52,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Colors.indigoAccent,
                Colors.purple,
              ],
              ),
            ),
            child: const Icon(
              Icons.add,
              size: 32,
              color: Colors.white,
            ),
          ),label: 'Ajouter',
          ),

          const BottomNavigationBarItem(icon: Icon(
            Icons.notifications, size: 32,color: Colors.white,
          ),
            label: 'settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
          onTap: (index) async {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            } else if (index == 1) {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return NewItemView();
                }),
              );
              if (result != null) {
                Provider.of<TodoListProvider>(context, listen: false).addNewTask(
                  result['title'],
                  result['description'],
                );
              }
            }
          },






        /*onTap: (index){
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          } else if (index == 1) {
            final result = Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return NewItemView();
                }));
            Provider.of<TodoListProvider>(context, listen: false).addNewTask(
              result['title'],
              result['description']
            );
          }
        },*/
      ),



      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('list').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index];
              TextEditingController updateTitle = TextEditingController(
                  text: document['Title'],
              );
              TextEditingController updateDescription = TextEditingController(
                  text: document['Description']);
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Theme(data : ThemeData(
                      primarySwatch: Colors.blue,
                      unselectedWidgetColor: Color(0xff5e616a),
                    ),
                      child: Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          activeColor: Color(0xff6cf8a9),
                          checkColor: Color(0xff0e3e26),
                          value: document['Completed'],
                          onChanged: (value) {
                            FirebaseFirestore.instance.collection('list').doc(document.id).update({'Completed': value});
                            //provider.updateTask(document.id,value);

                          },
                        ),
                      ),
                    ),
                    Expanded(child: Container(
                      height: 75,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Color(0xff2a2e3d),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(child:
                            Text(
                              document['Title'],
                              style: const TextStyle(
                                fontSize: 18,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                            ),
                            Text(
                              document['Description'],
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
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

                                //provider.of<TodoListProvider>(context, listen: false).addNewTask()
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

                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              );

            },
          );
        },
      ),


      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () async {
      //     final result = await Navigator.of(context).push(
      //         MaterialPageRoute(builder: (context) {
      //           return NewItemView();
      //         }));
      //     Provider.of<TodoListProvider>(context, listen: false).addNewTask(
      //         result.title, result.description);
      //   },
      // ),
    );
  }

}


