
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Important(),
    );
  }
}

class Important extends StatefulWidget {
  @override
  ImportantUi createState() => ImportantUi();
}

class ImportantUi extends State<Important> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video.mp4');
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _load() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Important App",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
          body: Column(children: [
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  _controller.play();
                  return Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                  debugPrint("isPlaying : ${_controller.value.isPlaying}");
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ]));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Important App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "This is the first app I built on my own (using the internet) and it is doing something very important. Click below to find out.",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Divider(),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
              onPressed: _load,
              child: const Text(
                "Click here!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
