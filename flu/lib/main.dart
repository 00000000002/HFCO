// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         // appBar: AppBar(
//         //   title: Text('Flutter WebView Example'),
//         // ),
//       body: Stack(
//           children: [
//             // WebView as the background
//             MyWebView(),
//             // Splash screen or startup image
//             Container(
//               color: Colors.white, // Set the background color as needed
//               alignment: Alignment.center,
//               child: Image.asset(
//                 'assets/startup_image.png', // Replace with your image asset path
//                 width: 200, // Adjust the width as needed
//                 height: 200, // Adjust the height as needed
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MyWebView extends StatefulWidget {
//   @override
//   _MyWebViewState createState() => _MyWebViewState();
// }
//
// class _MyWebViewState extends State<MyWebView> {
//   late WebViewController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     String url = 'https://example.com';
//
//     return WebView(
//       // initialUrl: url,
//       javascriptMode: JavascriptMode.unrestricted,
//       onWebResourceError: (WebResourceError error) {
//         // Handle web resource error.
//       },
//       onWebViewCreated: (WebViewController webViewController) {
//         // Store the web controller once created.
//         controller = webViewController;
//
//         // Now you can use the controller to load a new URL.
//         controller.loadUrl(Uri.parse('https://civitai.com').toString());
//       },
//     );
//   }
// }




import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Start with SplashScreen
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String _randomImagePath; // Store the randomly selected image path
  late AudioPlayer _audioPlayer; // Store the audio player instance

  @override
  void initState() {
    super.initState();

    // Initialize the audio player
    _audioPlayer = AudioPlayer();

    // Load and play the background music
    _playBackgroundMusic();

    // Randomly select an image from the 'assets/startup_images' folder
    _randomImagePath = _getRandomImagePath();

    // Delay for 3 seconds and then navigate to the WebView screen
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WebViewScreen(),
        ),
      );

      // Stop playing the background music when navigating to the next screen
      _audioPlayer.stop();
    });
  }

  String _getRandomImagePath() {
    // Replace 'assets/startup_images' with your actual folder path
    List<String> imagePaths = [
      'assets/wdlmimage/image1.png',
      'assets/wdlmimage/image2.jpg',
      'assets/wdlmimage/116.png',
      // Add more image paths as needed
    ];

    // Generate a random index to select a random image
    int randomIndex = Random().nextInt(imagePaths.length);

    return imagePaths[randomIndex];
  }

  void _playBackgroundMusic() async {
    // Replace 'assets/music/background_music.mp3' with your audio file path
    await _audioPlayer.play(AssetSource(r'assets/bcmusic/wdlm.wav'));
  }

  @override
  void dispose() {
    // Dispose of the audio player when the screen is disposed
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          _randomImagePath,
          width: MediaQuery.of(context).size.width, // Adjust the width as needed
          height: MediaQuery.of(context).size.height, // Adjust the height as needed
        ),
      ),
    );
  }
}

class WebViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyWebView(),
    );
  }
}

class MyWebView extends StatefulWidget {
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    String url = 'https://example.com';

    return WebView(
      // initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebResourceError: (WebResourceError error) {
        // Handle web resource error.
      },
      onWebViewCreated: (WebViewController webViewController) {
        // Store the web controller once created.
        controller = webViewController;

        // Delay for an additional 5 seconds and then load the URL
        Timer(Duration(seconds: 5), () {
          // Now you can use the controller to load a new URL.
          controller.loadUrl(Uri.parse('https://civitai.com').toString());
        });
      },
    );
  }
}
