class Video{
  final String? id;
  final String? title;
  final String? thumbnailsUrl;
  final String? channelTitle;

  Video({this.id,this.title,this.thumbnailsUrl,this.channelTitle});

  factory Video.fromMap(Map<String,dynamic> snippet){
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailsUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle']
    );
  }
}