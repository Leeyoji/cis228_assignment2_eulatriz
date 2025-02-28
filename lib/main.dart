import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CIS 228 Assignment 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Map<String, bool> interests = {
    "Music": false,
    "Sports": false,
    "Reading": false,
     "Arts": false,
     "Studying": false,
     "Movies": false,
  };

  void _submit() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Name and Email are required!"))
      );
      return;
    }

    List<String> selectedInterests = interests.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    debugPrint("*********Profile*********");
    debugPrint("Name: $name");
    debugPrint("Email: $email");
    debugPrint("Interests: ${selectedInterests.join(", ")}");
    debugPrint("*************************");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/dp.jpg",
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              Text("Select Interests:"),
              Column(
                children: interests.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: interests[key],
                    onChanged: (bool? value) {
                      setState(() {
                        interests[key] = value ?? false;
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
