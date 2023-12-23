
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'package:youtube_channel/models/channel_model.dart';
import 'package:youtube_channel/models/video_model.dart';
import 'package:youtube_channel/utilities/keys.dart';

class APIService{
  APIService._instantiate();
  static final APIService instance = APIService._instantiate();
  final String? _baseUrl = 'www.googleapis.com';
  String _nextPageToken='';

Future<Channel> fetchChannel({String? channelID}) async{
  Map<String,String> parameters = {
    'part':'snippet, contentDetails, statistics',
    'id':channelID!,
    'key':Api_key,
    };
  Uri uri = Uri.https(_baseUrl!,'/youtube/v3/channels',parameters);
   Map<String,String> headers={
    HttpHeaders.contentTypeHeader:'application/json',
   };

   //Get Channel
   var response = await http.get(uri,headers: headers);
   if(response.statusCode ==200){
    Map<String,dynamic> data = json.decode(response.body)['items'][0];
    Channel channel = Channel.fromJson(data);

    //Fetch first batch of video from uploads playlist
    channel.videos = await fetchVideosFromPlaylist(
      playlistId: channel.uploadPlayListId,
    );
    return channel;
   }
   else{
    throw json.decode(response.body)['error']['message'];
   }
}
Future<List<Video>> fetchVideosFromPlaylist({String? playlistId})async{
  Map<String,String> parameters = {
    'part':'snippet',
    'playlistId':playlistId!,
    'key':Api_key,
    };
  Uri uri = Uri.https(_baseUrl!,'/youtube/v3/playlistItems',parameters);
   Map<String,String> headers={
    HttpHeaders.contentTypeHeader:'application/json',
   };
  
   //Get playlist Videos
   var response = await http.get(uri,headers: headers);
   if(response.statusCode ==200){
    var data = json.decode(response.body);

    _nextPageToken = data['nextPageToken'] ?? '';
    List<dynamic> videoJson = data['items'];
    
      //Fetch first eight of video from uploads playlist
      List<Video> videos = [];
      videoJson.forEach((json)=> videos.add(Video.fromMap(json['snippet'] )));

      return videos;
   }
   else{
    throw json.decode(response.body)['error']['message'];
   }
}
}