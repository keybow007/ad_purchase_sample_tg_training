import 'package:ad_purchase_sample_training/view/home_screen.dart';
import 'package:ad_purchase_sample_training/vm/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  print("main関数起動");
  runApp(
      ChangeNotifierProvider(
        create: (context) => ViewModel(),
        child: MyApp(),
      ),
    );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    final vm = context.read<ViewModel>();
    vm.initAdmob();
  }

  @override
  Widget build(BuildContext context) {
    print("MyApp#build");
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
