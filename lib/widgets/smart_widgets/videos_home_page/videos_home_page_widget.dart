import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'videos_home_page_view_model.dart';

class VideosHomePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideosHomePageViewModel>.reactive(
      builder:
          (BuildContext context, VideosHomePageViewModel viewModel, Widget _) {
        dynamic height = MediaQuery.of(context).size.height;
        dynamic width = MediaQuery.of(context).size.width;
        return ListView.builder(
            padding: EdgeInsets.all(0),
            physics: BouncingScrollPhysics(),
            itemCount: viewModel.videosList.length,
            itemBuilder: (context, index) {
              if (index.isEven) {
                return Row(
                  children: [
                    buildVideosThumbnail(
                      context,
                      viewModel,
                      viewModel.videosList[index]["category"],
                      viewModel.videosList[index]["videos"],
                    ),
                    index + 1 == viewModel.videosList.length
                        ? Container(
                            height: height * 0.27,
                            width: width * 0.42,
                          )
                        : buildVideosThumbnail(
                            context,
                            viewModel,
                            viewModel.videosList[index + 1]["category"],
                            viewModel.videosList[index + 1]["videos"])
                  ],
                );
              } else
                return Container(
                  height: 0,
                  width: 0,
                );
            });
      },
      viewModelBuilder: () => VideosHomePageViewModel(),
    );
  }
}

Widget buildVideosThumbnail(BuildContext context,
    VideosHomePageViewModel viewModel, String title, List videosList) {
  dynamic height = MediaQuery.of(context).size.height;
  dynamic width = MediaQuery.of(context).size.width;
  return GestureDetector(
    onTap: () {
      viewModel.goToVideosDetailsPage(viewModel, title, videosList);
    },
    child: Container(
      height: height * 0.12,
      width: width * 0.43,
      padding: EdgeInsets.only(
          bottom: height * 0.015, left: width * 0.03, right: width * 0.08),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(7))),
      margin: EdgeInsets.symmetric(
          vertical: height * 0.01, horizontal: width * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: height * 0.02,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          Text(
            "${videosList.length} videos",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: height * 0.015,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.6)),
          ),
        ],
      ),
    ),
  );
}
