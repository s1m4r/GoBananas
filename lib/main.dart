import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Bananas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 171, 58)),
        fontFamily: 'Quantico',
      ),
      home: const MyHomePage(title: 'Go Bananas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/WEBsammybirthday.jpg',
              width: 150,
              height: 150,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Challenges()),
                );
              },
              child: const Text('Challenges'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Leaderboard()),
                );
              },
              child: const Text('Leaderboard'),
            ),
            const SizedBox(height: 20),
            // Circular "Feed" button trash game no then loops bad justice for 
            GestureDetector(
            onTap: () {
              // Trigger the banana spawn
              showBanana(context);
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Feed',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ),
            ],
            ),
        ),
      );
  }
}

void showBanana(BuildContext context) {
  OverlayEntry? overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height / 2 - 50,
      left: MediaQuery.of(context).size.width / 2 - 50,
      child: Image.asset(
        'assets/banana.png', // Replace with your banana asset path
        width: 100,
        height: 100,
      ),
    ),
  );

  // Insert the overlay
  Overlay.of(context).insert(overlayEntry);

  // Remove the banana after 3 seconds
  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry?.remove();
  });
}

class Challenges extends StatelessWidget {
  const Challenges({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // This is the number of tabs. In this case, we have two tabs: Daily and Weekly.
    length: 2, // Two tabs: Daily and Weekly
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Challenges'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Daily'),
              Tab(text: 'Weekly'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Daily Challenges Tab
            DailyChallenges(),
            //Center(child: Text('Your daily challenges will appear here!')),
            // Weekly Challenges Tab
            WeeklyChallenges(),
            //Center(child: Text('Your weekly challenges will appear here!')),
            
          ],
        ),
      ),
    );
  }
}

class DailyChallenges extends StatelessWidget {
  const DailyChallenges({super.key});

  @override
  Widget build(BuildContext context) {
    final challenges = [
      'Working on homework',
      'Taking a walk',
      'Reading a book',
      'Complete chores',
      'Trying a new hobby',
    ];

    return ListView.builder(
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.check_box_outline_blank),
          title: Text(challenges[index]),
        );
      },
    );
  }
}

class WeeklyChallenges extends StatelessWidget {
    Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // You can now use the pickedFile.path
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image selected: ${pickedFile.name}')),
      );
    }
  }
  const WeeklyChallenges({super.key});

  @override
  Widget build(BuildContext context) {
    final challenges = [
      'Try out food at Crown Dining Hall',
      'Go to the gym',
      'Go to the NSBE Hackathon 2025',
      'Go to the Grocery Pop-Up on Fridays',
    ];

    return ListView.builder(
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Submit Proof'),
                  content: const Text('Please scan a QR code or take a picture as proof for this challenge.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // TODO: Implement QR code scanning
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QRCode()),
                        );
                      },
                      child: const Text('Scan QR Code'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await _pickImage(context);
                      },
                      child: const Text('Upload Picture'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              );
            },
            child: Text(challenges[index]),
          ),
        );
      },
    );
  }
}

class QRCode extends StatelessWidget {
  const QRCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: Center(
        child: const Text('QR Code Scanner will be implemented here.'),
      ),
    );
  }
}

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: ListView(
        children: const [
          ListTile(
            leading: CircleAvatar(child: Text('1')),
            title: Text('User A'),
            subtitle: Text('Bananas: 150'),
          ),
          ListTile(
            leading: CircleAvatar(child: Text('2')),
            title: Text('User B'),
            subtitle: Text('Bananas: 140'),
          ),
          ListTile(
            leading: CircleAvatar(child: Text('3')),
            title: Text('User C'),
            subtitle: Text('Bananas: 130'),
          ),
          ListTile(
            leading: CircleAvatar(child: Text('4')),
            title: Text('User D'),
            subtitle: Text('Bananas: 120'),
          ),
          ListTile(
            leading: CircleAvatar(child: Text('5')),
            title: Text('User E'),
            subtitle: Text('Bananas: 110'),
          ),
        ],
      ),
    );
  }
}