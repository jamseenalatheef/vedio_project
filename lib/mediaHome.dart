import 'dart:developer';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pod_player/pod_player.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vedio_project/coreFile/api.dart';
import 'package:vedio_project/pages/audio_container.dart';

import 'package:vedio_project/viewmodel/commonViewModel.dart';

class mediaHome extends StatefulWidget {
  late String name, subid, img;

  mediaHome({required this.name, required this.subid, required this.img});

  @override
  State<mediaHome> createState() => _mediaHomeState();
}

class _mediaHomeState extends State<mediaHome> {
  //late final PageManager _pageManager;
  String url2 = "https://www.youtube.com/watch?v=H1L1s1xZvnU";
  var urls = [
    "https://www.youtube.com/watch?v=tzwcUsZvGS0",
    "https://www.youtube.com/watch?v=H1L1s1xZvnU"
  ];
  String audio = "";
  String id = "";
  late viewmodel vmodel;

  String? vedio;
  late final PodPlayerController controller;

  @override
  void initState() {
    vmodel = Provider.of<viewmodel>(context, listen: false);
    vmodel.getdata3(widget.subid);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  ValueNotifier<String> audioLock = ValueNotifier('');

  final String cloudFunctionUrl = urll().mainurl + "api.jsp";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: FutureBuilder<List>(
            future: vmodel.getdata3(widget.subid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                log(snapshot.data!.length.toString());
                return ListView.builder(
                    itemCount: vmodel.mediaList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String vedio = vmodel.mediaList[index].vedio.toString();
                      if (vedio == "0") {
                        log("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
                      } else {
                        log("innn");
                        String vedio = vmodel.mediaList[index].vedio.toString();
                      }
                      audio = vmodel.mediaList[index].audio.toString();
                      id = vmodel.mediaList[index].id.toString();

                      log("audio111111111====" +
                          vmodel.mediaList[index].id.toString());
                      log("audio111111111====" +
                          vmodel.mediaList[index].audio.toString());

                      String text = vmodel.mediaList[index].text.toString();
                      // String dura = vmodel.mediaList[index].duration.toString();

                      var object;
                      // log("audios ==" + dura.toString());
                      log("vediovediovedio ==" + vedio.toString());

                      if (text != "0") {
                        log("text ---" + text.toString());

                        object = text;
                      } else if (audio != "0") {
                        log("audio====" + audio);
                        object = audio;
                      } else if (vedio != "0") {
                        object = vedio;
                      } else {
                        log("error message");
                      }

                      return (object == text)
                          ? ListTile(
                              title: Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 3, bottom: 3),
                                  child: Card(
                                    // margin: EdgeInsets.only(top: 3, bottom: 3),
                                    shape: BeveledRectangleBorder(
                                        // side: BorderSide(
                                        //  /   color: Colors.black, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.grey,
                                    child: Align(
                                        child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        text.toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                            )
                          : (object == audio)
                              ? Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: AudioContainer(
                                    audioTitle:
                                        vmodel.mediaList[index].audio as String,
                                    audioId:
                                        vmodel.mediaList[index].id as String,
                                    audioLock: audioLock,
                                  ),
                                )
                              : (object == vedio)
                                  ? Padding(
                                      padding:
                                          EdgeInsets.only(top: 3, bottom: 3),
                                      child: ListTile(
                                          title: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            // decoration: const BoxDecoration(
                                            //     color: Colors.grey,
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(20))
                                            //     //background color of box
                                            //     ),
                                            child: Column(
                                              children: [
                                                PodVideoPlayer(
                                                    controller:
                                                        new PodPlayerController(
                                                  playVideoFrom:
                                                      PlayVideoFrom.youtube(
                                                          vedio,
                                                          live: false),
                                                )..initialise())
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                    )
                                  : Text("vedio");
                    });
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}

enum PlayerState { stopped, playing, paused }
