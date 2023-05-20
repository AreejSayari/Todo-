import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoCard extends StatelessWidget {
  const ToDoCard({Key? key,
    required this.title, required this.time,required this.check,required this.document
  }) : super(key: key);

  final String title;
  final String time;
  final bool check;
  final String document;
  //final  DocumentReference document;

  @override
  Widget build(BuildContext context) {
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
              value: check,
              onChanged: (value) {
                FirebaseFirestore.instance.collection('list').doc(document).update({'Completed': value});
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
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child:
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      //provider.removeTask(provider.getElement(index));
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
                          .doc(document)
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
  }
}
