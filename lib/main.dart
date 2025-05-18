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

        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.yellow[200]!,
            primary: Colors.yellow[200]!,
            secondary: Colors.amber[100]!,
            brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.yellow[50], // Light yellow background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(225, 255, 235, 59),
          foregroundColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[100],
            foregroundColor: Colors.black,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
        fontFamily: 'Quantico',
      ),
      home: const MyHomePage(title: 'Go Bananas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    int bananaCount = 10; // Example initial value
    int slugPoints = 5;   // Example initial value
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.local_florist, color: Colors.yellow),
                const SizedBox(width: 5),
                Text('Bananas: $bananaCount'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.bug_report, color: Colors.green),
                const SizedBox(width: 5),
                Text('Slug Points: $slugPoints'),
              ],
            ),
          ],
        ),
      ),

      
      body: Stack(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Leaderboard()),
                    );
                  },
                  child: const Text('Leaderboard'),
                ),
                const SizedBox(height: 50),
                Image.asset(
                  'assets/emergedSlug.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Challenges()),
                    );
                  },
                  child: const Text('Challenges'),
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
          Positioned(
            top: 16.0, // Adjust to position below the AppBar
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClosetPage()),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.shopping_bag),
            ),
          ),
          Positioned(
            top: 16.0, // Adjust to position below the AppBar
            left: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.person),
            ),
          ),
        ],
        
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

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the your Profile!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class ClosetPage extends StatelessWidget {
  const ClosetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Closet'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Closet!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
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
            labelColor: Colors.black, // Selected tab text color
            unselectedLabelColor: Colors.black54,
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
      'Participate in the NSBE Hackathon 2025',
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
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black, // Text color
                      ),
                      onPressed: () {
                        // TODO: Implement QR code scanning
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QRCode()),
                        );
                      },
                      child: const Text('Scan Event QR Code'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black, // Text color
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        await _pickImage(context);
                      },
                      child: const Text('Upload Picture'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black, // Text color
                      ),
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