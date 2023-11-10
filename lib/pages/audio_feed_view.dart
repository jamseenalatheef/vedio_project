import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:vedio_project/pages/audio_container.dart';

class AudioFeedView extends StatelessWidget {
  AudioFeedView({Key? key}) : super(key: key);

  ValueNotifier<String> audioLock = ValueNotifier('');

  final String cloudFunctionUrl =
      "http://192.168.29.109:8080/vedioproject/api.jsp";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Audio Feed'),
        ),
      ),
      body: Center(
        child: FutureBuilder<http.Response>(
          future: http.get(Uri.parse(cloudFunctionUrl)),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final response = snapshot.data!;
            final List<dynamic> loops = jsonDecode(response.body)["files"];
            return ListView.builder(
              itemCount: loops.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> loop = loops[index];
                return AudioContainer(
                  audioTitle: loop["name"]! as String,
                  audioId: loop["id"]! as String,
                  audioLock: audioLock,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
