import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AppKu());

class AppKu extends StatelessWidget {
  const AppKu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const MaterialApp(home: Homeku());
}

class Homeku extends StatefulWidget {
  const Homeku({Key? key}) : super(key: key);
  @override
  State<Homeku> createState() => _HomekuState();
}

class _HomekuState extends State<Homeku> {
  final String text =
      '''Alkisah, pada sebuah desa tinggallah seorang ibu beserta seorang anak laki-laki di gubuk dengan ekonomi yang kurang.

Pada suatu hari, anaknya yang bernama Malin sudah beranjak dewasa dan ingin pergi merantau ke pulau sebrang untuk meningkatkan ekonomi keluarganya.

Pada awalnya, ibu Malin menolak/tidak setuju dengan niat Malin yang ingin pergi merantau, akan tetapi karena keinginan keras Malin akhirnya ibunya luluh mengizinkannya untuk merantau.

Singkat cerita, Malin pun berhasil di tanah rantauan dan menjadi orang kaya tetapi ia sombong, ia tidak lagi mengakui ibunya yang telah merawatnya semenjak ia kecil. 

Malin sangat sombong atas harta yang telah ia miliki sekarang, ibunya berkali-kali ingin menemui Malin, akan tetapi karena kesombongan Malin akhirnya ibunya pun diusir untuk pulang ke kampung halamannya.

Ibunya yang sudah sakit hati tak tahan lagi atas perbuatan anaknya, dan akhirnya ibu Malin mengutuk Malin menjadi sebuah batu, yang sekarang terkenal sebagai cerita rakyat Malin Kundang.
''';

  AudioPlayer player = AudioPlayer();
  final TextEditingController _controller = TextEditingController();
  int repeat = 0;

  Future _loadFile(int play) async {
    await player.play(
        "https://firebasestorage.googleapis.com/v0/b/breadify-a4a04.appspot.com/o/sound.mpeg?alt=media&token=b05bad69-e1b2-47ca-8f98-d32cc2e946ec");
    if (_controller.text.isNotEmpty) {
      player.onPlayerCompletion.listen((event) {
        if (repeat >= 0) {
          setState(() {
            player.play(
                "https://firebasestorage.googleapis.com/v0/b/breadify-a4a04.appspot.com/o/sound.mpeg?alt=media&token=b05bad69-e1b2-47ca-8f98-d32cc2e946ec");
            repeat += 1;

            if (repeat == int.parse(_controller.text)) {
              repeat = 0;
              player.stop();
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Malin Kundang"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 90, 63, 53),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            Image.asset(
              "assets/malin.png",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _controller,
                decoration:
                    const InputDecoration(label: Text("Jumlah putar audio")),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconBtn(Icons.stop_circle_rounded, "stop", Colors.red),
                iconBtn(Icons.play_circle_rounded, "play", Colors.green),
                iconBtn(Icons.pause_circle_rounded, "pause", Colors.blue),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(text, textAlign: TextAlign.justify)),
          ],
        ),
      ),
    );
  }

  IconButton iconBtn(IconData icon, String event, Color color) => IconButton(
        icon: Icon(icon),
        iconSize: 40,
        color: color,
        splashRadius: 20,
        onPressed: () {
          switch (event) {
            case "play":
              if (_controller.text.isEmpty) {
                _loadFile(1);
              } else {
                _loadFile(int.parse(_controller.text));
              }
              break;
            case "pause":
              player.pause();
              break;
            case "stop":
              player.stop();
              break;
          }
        },
      );
}