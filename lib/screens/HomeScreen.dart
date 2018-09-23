import 'package:flutter/material.dart';
import 'package:flutter_simple_client/app/Constants.dart';
import 'package:flutter_simple_client/data/Photo.dart';
import 'package:flutter_simple_client/network/NetworkClient.dart';

class PhotosScreen extends StatefulWidget {
  PhotosScreen({Key key, this.title, this.client}) : super(key: key);

  final NetworkClient client;
  final String title;

  @override
  _PhotosScreenState createState() => new _PhotosScreenState(client);
}

class _PhotosScreenState extends State<PhotosScreen> {
  _PhotosScreenState(this.client);

  final NetworkClient client;

  List<Photo> photos = new List();
  int lastPhotoId = 0;
  int photosPerPage = 50;
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  @override
  void initState() {
    super.initState();

    _getMoreData();

//    _scrollController.addListener(() {
//      if (_scrollController.position.pixels ==
//          _scrollController.position.maxScrollExtent) {
//
//      }
//    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);

      client.getPageOfPhotosAsync(lastPhotoId, photosPerPage, (newPhotos) {
        setState(() {
          photos.addAll(newPhotos);
          isPerformingRequest = false;
        });
      }, (exception) {
        throw exception;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Photos"),
      ),
      body: ListView.builder(
        itemCount: photos.length + 1,
        itemBuilder: (context, index) {
          if (index == photos.length) {
            return _buildProgressIndicator();
          } else {
            return _buildPhotoWidget(photos[index]);
          }
        },
        controller: _scrollController,
      ),
    );
  }

  Widget _buildPhotoWidget(Photo photo) {
    return Image.network('${Constants.getPhotoFileUrl}/${photo.photoName}');
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
