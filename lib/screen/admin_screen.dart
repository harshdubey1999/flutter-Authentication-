import 'package:dashboard/screen/siginup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _urlController = TextEditingController();
  LaunchMode _selectedMode = LaunchMode.inAppWebView; // Default mode
  final List<String> urls = []; // List to store the URLs

  final List<DropdownMenuItem<LaunchMode>> _modeItems = [
    const DropdownMenuItem(
      value: LaunchMode.externalApplication,
      child: Text('External Application'),
    ),
    const DropdownMenuItem(
      value: LaunchMode.inAppWebView,
      child: Text('In-App WebView'),
    ),
    const DropdownMenuItem(
      value: LaunchMode.inAppBrowserView,
      child: Text('External Non-Browser Application'),
    ),
  ];

  void _addUrl() {
    final String url = _urlController.text;
    if (url.isNotEmpty) {
      setState(() {
        urls.add(url); // Add the URL to the list
        _urlController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("Logout"),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Enter URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addUrl,
              child: const Text('Add URL'),
            ),
            const SizedBox(height: 16),
            DropdownButton<LaunchMode>(
              value: _selectedMode,
              items: _modeItems,
              onChanged: (LaunchMode? newValue) {
                setState(() {
                  _selectedMode = newValue ?? LaunchMode.inAppWebView;
                });
              },
              isExpanded: true,
              hint: const Text('Select Launch Mode'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: urls.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(urls[index]),
                    onTap: () async {
                      final Uri uri = Uri.parse(urls[index]);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: _selectedMode);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Could not launch $uri')),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
