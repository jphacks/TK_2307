import 'package:flutter/material.dart';
import '../../util/http_client.dart';

class SharePage extends StatelessWidget {
  const SharePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                final res = await execGetRequest("/getPing");
                print(res.body);
              },
              child: const Text("GET")
            ),
            TextButton(
              onPressed: () async {
                final res = await execPostRequestWithParam("/createPing", {'ping': 'pong'});
                print(res.body);
              },
              child: const Text("POST")
            ),            
          ],
        )
      ),
    );
  }
}
