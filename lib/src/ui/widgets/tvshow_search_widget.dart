import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:tv_randshow/src/models/search_model.dart';
import 'package:tv_randshow/src/utils/constants.dart';
import 'package:tv_randshow/src/utils/styles.dart';

class TvshowSearchWidget extends StatelessWidget {
  final int tvshowId;
  final String tvshowName;
  final String urlImage;
  TvshowSearchWidget({Key key, this.tvshowId, this.tvshowName, this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0, left: 8.0),
      child: Container(
        height: 154.0,
        width: 144.0,
        decoration: BoxDecoration(borderRadius: BORDER_RADIUS),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 6.0,
              left: 0.0,
              top: 6.0,
              bottom: 18.0,
              child: _image(context),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _actionButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image(BuildContext context) {
    return GestureDetector(
      onTap: () => ScopedModel.of<SearchModel>(context).toggleDetails(),
      child: Container(
        height: 128.0,
        width: 144.0,
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: SMALL_INSESTS,
            decoration: BoxDecoration(borderRadius: BORDER_RADIUS, color: Colors.black38),
            child: Text(
              tvshowName,
              style: TextStyle(color: StyleColor.WHITE, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BORDER_RADIUS,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: checkImage(),
          ),
        ),
      ),
    );
  }

  ImageProvider checkImage() {
    if (urlImage == null) {
      return AssetImage(ImagePath.emptyTvShow);
    } else {
      return NetworkImage(Url.BASE_IMAGE + urlImage);
    }
  }

  Widget _actionButton(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(Icons.star_border, color: StyleColor.PRIMARY),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), side: BorderSide(color: StyleColor.PRIMARY)),
      color: StyleColor.WHITE,
      label: Text('Add to fav', style: TextStyle(color: StyleColor.PRIMARY)),
      onPressed: () => ScopedModel.of<SearchModel>(context).addToFav(tvshowId),
    );
  }
}