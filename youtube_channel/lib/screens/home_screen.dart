import 'package:flutter/material.dart';
import 'package:youtube_channel/models/channel_model.dart';
import 'package:youtube_channel/models/video_model.dart';
import 'package:youtube_channel/screens/AboGolia_screen.dart';
import 'package:youtube_channel/screens/home_channel_screen.dart';
import 'package:youtube_channel/screens/channels_screen.dart';
import 'package:youtube_channel/screens/video_screen.dart';
import 'package:youtube_channel/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(child: Text('YouTube Channel',style: TextStyle(color: Colors.white),)),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: ChannelScreen(channelId: 'UCzhq9tUhGJj5iVWtEEWxPeg',),
            ),
             Container(
              child: ChannelScreen(channelId: 'UCDT9Sc8YgtT7Qq8dqe4sgHg',),
            ),
            Container(
              child: ChannelScreen(channelId: 'UCgoKH0e1n5II305aJamUnWA',),
            ),
            Container(
              child: ChannelScreen(channelId: 'UCEnEnnT3RtiDloynOk7iPeg',),
            ),
             Container(
              child: ChannelScreen(channelId: 'UCnEMpOhNU3LWYKkL3HlICtA',),
            ),
             Container(
              child: ChannelScreen(channelId: 'UCHPXbE0iegkrrIcUx4LSHCg',),
            ),
            Container(
              child: ChannelScreen(channelId: 'UCy5CMIj7sqy8ynu0EaxrAuA',),
            ),
            Container(
              child: ChannelScreen(channelId: 'UC2WuPTt0k8yDJpfenggOAVQ',),
            ),
          ],
        ),
      )
      );}
}