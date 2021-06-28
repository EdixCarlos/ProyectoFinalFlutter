import 'package:cupoappfinal/todo/controller/todo_controller.dart';
import 'package:cupoappfinal/todo/models/todo.dart';
import 'package:cupoappfinal/todo/repository/todo_repository.dart';
import 'package:flutter/material.dart';

import '../../userprofileheader.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var todoController = TodoController(TodoRepository());

    return Scaffold(
      appBar: AppBar(
        actions: [
          UserProfileheader(showProfilePic: true),
        ],
        title: Text('Todo App'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          } //

          return buildBodyContent(snapshot, todoController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Todo todo = Todo(userId: 3, title: 'sample post', completed: false);
          todoController.postTodo(todo);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  SafeArea buildBodyContent(
      AsyncSnapshot<List<Todo>> snapshot, TodoController todoController) {
    return SafeArea(
      child: ListView.separated(
          itemBuilder: (context, index) {
            var todo = snapshot.data?[index];
            return Container(
              height: 90.0,
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Text('${todo?.id}')),
                  Expanded(flex: 1, child: Text('${todo?.title}')),
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              todoController
                                  .updatePatchCompleted(todo!)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        content: Text('$value')));
                              });
                            },
                            child: buildCallContainer(
                              'patch',
                              Color(0xFFFFE0B2),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              todoController.updatePutCompleted(todo!);
                            },
                            child: buildCallContainer(
                              'put',
                              Color(0xFFE1BEE7),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              todoController.deleteTodo(todo!).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration: Duration(microseconds: 500),
                                        content: Text('$value')));
                              });
                            },
                            child: buildCallContainer(
                              'del',
                              Color(0xFFFFCDD2),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 0.5,
              height: 0.5,
            );
          },
          itemCount: snapshot.data?.length ?? 0),
    );
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(10.0)),
      child: Center(child: Text('$title')),
    );
  }
}
