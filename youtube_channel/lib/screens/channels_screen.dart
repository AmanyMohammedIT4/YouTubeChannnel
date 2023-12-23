import 'package:flutter/material.dart';
import 'package:youtube_channel/models/channel_model.dart';
import 'package:youtube_channel/models/video_model.dart';
import 'package:youtube_channel/screens/home_channel_screen.dart';
import 'package:youtube_channel/screens/video_screen.dart';
import 'package:youtube_channel/services/api_service.dart';

class ChannelScreen extends StatefulWidget {
  String? channelId;
   ChannelScreen({this.channelId});

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
Channel? _channel;

@override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel()async{
    Channel channel = await APIService.instance.fetchChannel(channelID:widget.channelId);
    setState(() {
      _channel = channel;

    });
  }
   
  @override
  Widget build(BuildContext context) {
    return _channel != null ?
      _buildProfileInfo()
      : Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor, //red
          ))
      );
  }
  
   _buildProfileInfo() {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:  (_)=> HomeChannelScreen(channelId: widget.channelId,)));
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
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