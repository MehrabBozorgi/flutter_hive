import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('friend');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  Box friendBox = Hive.box('friend');
  String? name;

  Future<void> addFriend() async {
    await friendBox.put('name', 'Mehrab');
    setState(() {
      name = friendBox.get('name');
    });
  }

  Future<void> updateFriend() async {
    await friendBox.put('name', 'Code');
    setState(() {
      name = friendBox.get('name');
    });
  }

  Future<void> removeFriend() async {
    await friendBox.delete('name');
    setState(() {
      name = friendBox.get('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                child: const Text('Create'),
                onPressed: addFriend,
              ),
              ElevatedButton(
                child: const Text('Update'),
                onPressed: updateFriend,
              ),
              ElevatedButton(
                child: const Text('Delete'),
                onPressed: removeFriend,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
