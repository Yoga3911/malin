import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final spinkit = SpinKitCircle(
      itemBuilder: (BuildContext context, int index) => DecoratedBox(
          decoration:
              BoxDecoration(color: index.isEven ? Colors.red : Colors.black)),
    );
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: size.height * 0.15,
                    height: size.height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        spinkit,
                        const Text(
                          "Loading ...",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
            await Future.delayed(
              const Duration(seconds: 3),
            );
            Navigator.pop(context);
          },
          child: const Text("Dialog"),
        ),
      ),
    );
  }
}