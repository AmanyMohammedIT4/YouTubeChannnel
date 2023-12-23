import 'package:flutter/material.dart';
import 'package:youtube_channel/models/channel_model.dart';
import 'package:youtube_channel/models/video_model.dart';
import 'package:youtube_channel/screens/home_channel_screen.dart';
import 'package:youtube_channel/screens/video_screen.dart';
import 'package:youtube_channel/services/api_service.dart';

class AboGoliaScreen extends StatefulWidget {
  const AboGoliaScreen({super.key});

  @override
  State<AboGoliaScreen> createState() => _AboGoliaScreenState();
}

class _AboGoliaScreenState extends State<AboGoliaScreen> {
Channel? _channel;
bool _isLoading = false;
// List<String> channelid = [
//   'UC6Dy0rQ6zDnQuHQ1EeErGUA',
//   'UCDT9Sc8YgtT7Qq8dqe4sgHg'
// ];

@override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel()async{
    // for(int i=0; i<channelid.length; i++){
    //    Channel channel = await APIService.instance.fetchChannel(channelID: channelid[i]);
    //     setState(() {
    //   _channel = channel;  

    // });
    // }
    Channel channel = await APIService.instance.fetchChannel(channelID: 'UC6Dy0rQ6zDnQuHQ1EeErGUA');
    setState(() {
      _channel = channel;

    });
  }
   _loadMoreVideos() async{
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance.fetchVideosFromPlaylist(playlistId: _channel!.uploadPlayListId!);
    List<Video> allVideos = _channel!.videos!..addAll(moreVideos);
    setState(() {
      _channel!.videos = allVideos;
    });
    _isLoading = false;
   }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Channels'),
      ),
      body:_channel != null ?
      NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollDetails){
          if(_isLoading && _channel!.videos!.length != int.parse(_channel!.videoCount!) &&
              scrollDetails.metrics.pixels == scrollDetails.metrics.maxScrollExtent)
              {
                _loadMoreVideos();
              }
            return false;
        },
        child:  _buildProfileInfo(),
      
      )
      : Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor, //red
          ))
      )
    );
  }
  
   _buildProfileInfo() {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:  (_)=> HomeChannelScreen()));
      },
      child: Container(
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(20.0),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0,1),
              blurRadius: 6.0
            ),
          ],
        ),
        child: Row(children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35,
            backgroundImage: NetworkImage(_channel!.profilePictureUrl!),
          ),
          SizedBox(width: 12.0,),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _channel!.title!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600
                ),
                overflow: TextOverflow.ellipsis,
              ),
               Text(
                '${_channel!.subscriberCount!} subscribes',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ))
        ]),
      ),
    );
   }

}