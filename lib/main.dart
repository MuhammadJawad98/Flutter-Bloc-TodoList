import 'package:bloc_pattern_example/bloc/todo_bloc.dart';
import 'package:bloc_pattern_example/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';
import 'counter_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TodoBloc()
              ..add(LoadTodos(todos: [
                Todo(id: '0', task: 'Task 1'),
                Todo(id: '1', task: 'Task 2'),
                Todo(id: '2', task: 'Task 3'),
                Todo(id: '3', task: 'Task 4'),
              ]))),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final _bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoLoaded) {
            return Column(
              children: <Widget>[
                const Text(
                  'Todos',
                ),
                BlocConsumer<TodoBloc, TodoState>(
                  listener: (context, state) {
                    if (state is TodoLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Todo added')));
                    }
                  },
                  builder: (context, state) => ElevatedButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(
                            AddTodos(todos: Todo(id: '5', task: 'some task')));
                      },
                      child: const Text('Add')),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.todos.length,
                    itemBuilder: ((context, index) =>
                        todoCard(context, state.todos[index]))),
              ],
            );
          } else {
            return const Text('something went wtrong');
          }
        },
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () => _bloc.counterEventSink.add(Increment()),
      //       tooltip: 'Increment',
      //       child: const Icon(Icons.add),
      //     ),
      //     const SizedBox(
      //       width: 10,
      //     ),
      //     FloatingActionButton(
      //       onPressed: () => _bloc.counterEventSink.add(Decrement()),
      //       tooltip: 'Decrement',
      //       child: const Icon(Icons.remove),
      //     ),
      //   ],
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    super.dispose();
    // _bloc.dispose();
  }

  Widget todoCard(BuildContext context, Todo todo) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(child: Text(todo.task)),
          IconButton(
              onPressed: () {
                context.read<TodoBloc>().add(DeleteTodos(todos: todo));
              },
              icon: const Icon(Icons.delete))
        ]),
      ),
    );
  }
}
