import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHot(),
  ));
}

class MyHot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('ANDANTE'),
        actions: <Widget>[
          Icon(Icons.library_music),
          Icon(Icons.assistant),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue[300]),
                child: Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
            ListTile(
                leading: IconButton(
                    icon: Icon(Icons.music_video),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoScreen()));
                    }),
                title: Text('Online Video')),
            ListTile(
                leading: IconButton(
                    icon: Icon(Icons.video_library),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoScreen1()));
                    }),
                title: Text('Offline Video')),
            ListTile(
              leading: IconButton(
                  icon: Icon(Icons.headset),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp1()));
                  }),
              title: Text('Offline Audio'),
            ),
            ListTile(
              leading: IconButton(
                  icon: Icon(Icons.library_music),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  }),
              title: Text('Online Audio'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: 250.0,
          color: Colors.amber,
          child: Image.network(
              'https://raw.githubusercontent.com/bansalsajal49/imagetest/master/download.jpg'),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Audio'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: 300.0,
          height: 250.0,
          color: Colors.amber,
          child: RaisedButton(
            onPressed: () async {
              AudioPlayer audioPlayer = AudioPlayer();
              int result = await audioPlayer.play(
                  'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
              if (result == 1) {
                // success
              }
            },
            child: Text('Hello'),
          ),
        ),
      ),
    );
  }
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Audio'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: 300.0,
          height: 250.0,
          color: Colors.amber,
          child: RaisedButton(
            onPressed: () {
              var t = AudioCache();
              t.play('tune.mp3');
            },
            child: Text('Hello'),
          ),
        ),
      ),
    );
  }
}

class VideoScreen extends StatefulWidget {
  VideoScreen({Key key}) : super(key: key);
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ));
  }
}

class VideoScreen1 extends StatefulWidget {
  VideoScreen1({Key key}) : super(key: key);
  @override
  _VideoScreen1State createState() => _VideoScreen1State();
}

class _VideoScreen1State extends State<VideoScreen1> {
  VideoPlayerController _controller1;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller1 = VideoPlayerController.asset('assets/vdo.mp4');
    _initializeVideoPlayerFuture = _controller1.initialize();
    _controller1.setLooping(true);
    _controller1.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: AspectRatio(
                  aspectRatio: _controller1.value.aspectRatio,
                  child: VideoPlayer(_controller1),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (_controller1.value.isPlaying) {
                _controller1.pause();
              } else {
                _controller1.play();
              }
            });
          },
          child: Icon(
            _controller1.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ));
  }
}
