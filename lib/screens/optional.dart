import 'package:flutter/material.dart';
import 'package:notes/screens/home.dart';

class OptionalScreen extends StatefulWidget {
  const OptionalScreen({super.key});

  @override
  State<OptionalScreen> createState() => _OptionalScreenState();
}

class _OptionalScreenState extends State<OptionalScreen> {
  bool? appStatus;
  @override
  void initState() {
    super.initState();
    // checkApplicationStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            const Center(
              child: Text(
                'Welcome To Notes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: ListView(
                padding: const EdgeInsets.only(left: 15),
                shrinkWrap: true,
                children: const [
                  ListTile(
                    leading: Icon(
                      Icons.insert_drive_file,
                      size: 30,
                    ),
                    title: Text(
                      'Add Almost Anything',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                        'Capture documents, photos, maps, and more for a richer Notes experience.'),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                    title: Text(
                      'Note to Self, or with Anyone',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                        'Invite others to view or make changes to a note.'),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.wysiwyg,
                      size: 30,
                    ),
                    title: Text(
                      'Create Quick Notes Anywhere',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                        'Create new Quick Notes in any app from the Share menu.'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            SizedBox(
              width: 200,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const CreatePage(),
                      ),
                      (route) => false);
                },
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: const MaterialStatePropertyAll(Colors.amber),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
