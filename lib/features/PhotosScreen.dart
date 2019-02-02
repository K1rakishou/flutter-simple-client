import 'package:flutter/material.dart';
import 'package:flutter_simple_client/Constants.dart';
import 'package:flutter_simple_client/data/Photo.dart';
import 'package:flutter_simple_client/features/PhotosBlock.dart';
import 'package:flutter_simple_client/features/PhotosState.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotosScreen extends StatefulWidget {
  @override
  _PhotosScreenState createState() => new _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final _photosBloc = kiwi.Container().resolve<PhotosBloc>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _photosBloc.loadNextPageOfPhotos();
  }

  @override
  void dispose() {
    _photosBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
      ),
      body: BlocBuilder(
        bloc: _photosBloc,
        builder: (context, PhotosState state) {
          if (state.isSuccess()) {
            return _buildWidgetSuccess(state);
          } else {
            return _buildWidgetError(state.exception);
          }
        },
      ),
    );
  }

  Widget _buildWidgetSuccess(PhotosState state) {
    if (state.photos.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      final crossAxisCount =
          MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4;

      return NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: GridView.builder(
              // length+ 1 for either "end of the list reached" text or for progress indicator
              itemCount: state.photos.length + 1,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount),
              controller: _scrollController,
              itemBuilder: (context, index) {
                return index >= state.photos.length
                    ? _buildLoaderListItem(state.isEndReached)
                    : _buildDataListItem(state.photos[index]);
              },
            ),
          ));
    }
  }

  Future<void> _refresh() async {
    _photosBloc.resetState();
  }

  Widget _buildWidgetError(Exception exception) {
    return GestureDetector(
      onTap: () => _photosBloc.resetState(),
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
              'An error has occurred while trying to load a page of photos:\n\nError details: $exception\n\nTap here to reload the list.')),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      _photosBloc.loadNextPageOfPhotos();
    }

    return false;
  }

  Widget _buildLoaderListItem(bool isEndReached) {
    if (isEndReached) {
      return GestureDetector(
        onTap: () => _photosBloc.resetState(),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('End of the list reached. Tap here to reload it.')),
      );
    } else {
      return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Center(child: CircularProgressIndicator()));
    }
  }

  Widget _buildDataListItem(Photo photo) {
    return Card(
      elevation: 2,
      child: Image.network(Constants.getPhotoFileUrl + '/' + photo.photoName),
    );
  }
}
