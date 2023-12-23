

import 'package:youtube_channel/models/video_model.dart';

class Channel {

  final String? id;
  final String? title;
  final String? profilePictureUrl;
  final String? subscriberCount;
  final String? videoCount;
  final String? uploadPlayListId;
  List<Video>? videos;

  Channel({this.id,this.title,this.profilePictureUrl,this.subscriberCount,this.videoCount,this.uploadPlayListId,this.videos});

  factory Channel.fromJson(Map<String,dynamic> map ){
    return Channel(
      id:map['id'],
      title: map['snippet']['title'],
      profilePictureUrl: map['snippet']['thumbnails']['default']['url'],
      subscriberCount: map['statistics']['subscriberCount'],
      videoCount: map['statistics']['videoCount'],
      uploadPlayListId: map['contentDetails']['relatedPlaylists']['uploads'],
    );
  } 

  
}