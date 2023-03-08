import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/constants/videos.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:vitalminds/views/home/home_view.dart';
import 'package:vitalminds/widgets/dumb_widgets/YoutubeScreen/YT_Screen.dart';
import 'package:vitalminds/widgets/dumb_widgets/YoutubeScreen/multiQuestionScreen.dart';
import 'package:vitalminds/widgets/dumb_widgets/YoutubeScreen/questionsScreen1.dart';
import 'package:vitalminds/widgets/dumb_widgets/video_details_page/video_details_page_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosHomePageViewModel extends BaseViewModel {
  Logger log;
  String videoId;
  bool ready = false;
  TextEditingController question1 = TextEditingController();
  List<TextEditingController> questions = List.generate(4, (index) => new TextEditingController());
  List<FocusNode> nodes = List.generate(4, (index) => new FocusNode());
  FirestoreService firestoreService = locator<FirestoreService>();
  AuthenticationService authenticationService =
      locator<AuthenticationService>();
  YoutubePlayerController controller;
  PlayerState playerState = PlayerState.unknown;
  String qn1 = "";
  NavigationService navigationService = locator<NavigationService>();
  bool checkReady(){
      log.i("ready:"+controller.value.isReady.toString());
      return controller.value.isReady;
  }
  void goToYTScreen(VideosHomePageViewModel v, Map t, String m, List videos,
      [int startPos, String q1]) {
    int temp = startPos ?? 0;
    videoId = t["id"];
    qn1 = q1;
    controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        startAt: temp,
        enableCaption: true,
        autoPlay: true,
        mute: false,
      ),
    );
    log.i(controller.metadata.title);
    notifyListeners();
    navigationService.replaceWithTransition(YTScreen(v, m, t, videos),
        transition: "Fade");
  }

  void goToQuestionsPage(VideosHomePageViewModel v, Map t, String m,
      List videos, int resumeAt, String question) {
    if((t["videoName"] == "Fear Setting") || (t["videoName"] == "Behavioral Activation")){
      navigationService.replaceWithTransition(
          MultiQuestion(v, m, t, videos, resumeAt),
          transition: "Fade");
    }
    else {
      navigationService.replaceWithTransition(
          UniqueQuestion(v, m, t, videos, resumeAt, question),
          transition: "Fade");
    }
  }
  Future updateMultiCBT(List<String> q1, String title, String videotitle, List<TextEditingController> q) async {
    String uid = authenticationService.user.uid;
    for(int i=0;i<q1.length;i++) {
      await firestoreService.updateCBT(uid, q[i].text, title, videotitle, q1[i]);
      q[i].clear();
    }
  }

  Future updateCBT(String q1, String title, String videotitle, String q) async {
    String uid = authenticationService.user.uid;
    await firestoreService.updateCBT(uid, q1, title, videotitle, q);
  }

  void listener(VideosHomePageViewModel v, Map t, String m, List videos) {
    if (!controller.value.isFullScreen) {
      playerState = controller.value.playerState;
    }
    if (t["pauses"].contains(controller.value.position.inSeconds)) {
      int index = t["pauses"].indexOf(controller.value.position.inSeconds);
      controller.pause();
      goToQuestionsPage(
          v, t, m, videos, t["resumeAt"][index], t["questions"][index]);
    }
  }

  List videosList = VideoData().videos;
  Future<bool> goBackToPreviousPage() async {
    navigationService.clearTillFirstAndShowView(HomeView(0, 1));
    return true;
  }

  void goToVideosDetailsPage(
      VideosHomePageViewModel viewModel, String title, List videosList) {
    navigationService.clearTillFirstAndShowView(
        VideoDetailsPageWidget(viewModel, title, videosList));
  }

  VideosHomePageViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
