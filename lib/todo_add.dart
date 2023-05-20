import 'package:correction/todo_list_provider.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';


class NewItemView extends StatelessWidget {
  final TextEditingController titleFieldController = TextEditingController();
  final TextEditingController descriptionFieldController = TextEditingController();
   NewItemView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    int _selectedIndex = 0;
    List<Widget> _pages = [MyHomePage(),NewItemView()];
    void _onItemTapped(int index) {
      _selectedIndex = index;
      // Perform actions based on the selected index
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
        //Provider.of<TodoListProvider>(context, listen: false).addNewTask(result.title, result.description);
      }
    }
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Add Task",
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
        onTap: (index){
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
            //Provider.of<TodoListProvider>(context, listen: false).addNewTask(result.title, result.description);
          }
        },

      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 100,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: titleFieldController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: descriptionFieldController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: Container(
                width: double.infinity,

                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 75),
                child: ElevatedButton(
                  onPressed: () => save(context),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),



    );
  }

  void save(BuildContext context)
  {
    var result = {
      'title': titleFieldController.text,
      'description': descriptionFieldController.text,
    };
    Navigator.pop(context, result);

    /*if (titleFieldController.text.isNotEmpty )
      {
        Todo task = Todo(
            titleFieldController.text, descriptionFieldController.text);
        Navigator.of(context).pop(task);
      }*/
  }
}
