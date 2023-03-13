import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/widgets/smart_widgets/videos_home_page/videos_home_page_view_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Themes.dart';

final globalAssetsAudioPlayer = AssetsAudioPlayer();

class YTScreen extends StatelessWidget {
  YTScreen(this.viewModel, this.title, this.videoData, this.videos);
  final String title;
  final Map videoData;
  final List videos;
  final VideosHomePageViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    dynamic height = MediaQuery.of(context).size.height;
    dynamic width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<VideosHomePageViewModel>.reactive(
      builder:
          (BuildContext context, VideosHomePageViewModel model, Widget child) {
        return SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              model.goToVideosDetailsPage(viewModel, title, videos);
              if (Platform.isAndroid) {
                globalAssetsAudioPlayer.open(
                  Audio.network(
                      "https://vital-minds.s3.ap-south-1.amazonaws.com/vital_minds_bg_music.mp3"),
                  autoStart: true,
                  loopMode: LoopMode.single,
                  showNotification: false,
                );
              }
              return true;
            },
            child: Scaffold(
              body: viewModel.anyObjectsBusy
                  ? Container(
                      color: Colors.white,
                    )
                  : Container(
                      height: height,
                      width: width,
                      color: Colors.black,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: height * 0.02),
                            height: height * 0.05,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    viewModel.goToVideosDetailsPage(
                                        viewModel, title, videos);

                                    if (Platform.isAndroid) {
                                      globalAssetsAudioPlayer.open(
                                        Audio.network(
                                            "https://vital-minds.s3.ap-south-1.amazonaws.com/vital_minds_bg_music.mp3"),
                                        autoStart: true,
                                        loopMode: LoopMode.single,
                                        showNotification: false,
                                      );
                                    }
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: 0.05 * width),
                                    width: width * 0.08,
                                    height: width * 0.08,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(Icons.chevron_left),
                                  ),
                                ),
                                Container(
                                    width: 0.7 * width,
                                    child: Text(
                                      viewModel.controller.metadata.title,
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            height: height * 0.7,
                            width: width,
                            child: YoutubePlayer(
                                controller: viewModel.controller,
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.amber,
                                thumbnail: Image.asset(
                                  "assets/images/thumbnail.jpg",
                                  fit: BoxFit.cover,
                                ),
                                progressColors: ProgressBarColors(
                                  playedColor: Themes.color,
                                  handleColor: Themes.color.withOpacity(0.9),
                                ),
                                bufferIndicator: Container(
                                    color: Colors.white, width: width),
                                onEnded: (v) {
                                  viewModel.goToVideosDetailsPage(
                                      viewModel, title, videos);
                                },
                                onReady: () {
                                  viewModel.checkReady();
                                  //viewModel.controller.load(videoData["id"]);
                                  viewModel.controller.addListener(() {
                                    //print(viewModel.ready);
                                    viewModel.listener(
                                        viewModel, videoData, title, videos);
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
      viewModelBuilder: () => VideosHomePageViewModel(),
    );
  }
}
