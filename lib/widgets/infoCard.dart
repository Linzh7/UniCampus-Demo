import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_campus/widgets/webViewPage.dart';

import 'imageViewProvider.dart';

class InfoCard extends StatelessWidget {
  final String _title;
  final Image _thumbnail;
  final String _webTitle;
  final String _subTitle;
  final String _webAddress;
  final String _describe;

  InfoCard(this._title, this._subTitle, this._thumbnail, this._webTitle,
      this._webAddress, this._describe);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            clipBehavior: Clip.antiAlias,
            // elevation: 2.0,
            child: Column(
              // mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 15,),
                Text(
                  _title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // fontFamily: "YouSheBiaoTiHei",
                    letterSpacing: 4,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 24.0,
                    height: 1,
                    //fontFamily: "Microsoft_YaHei",
                  ),
                ),
                SizedBox(height: 10,),
                _subTitle == ''
                    ? SizedBox()
                    : Row(
                        children: [
                          Expanded(
                            child: Text(
                              _subTitle,
                              softWrap: false,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                height: 1,
                                //fontFamily: "Microsoft_YaHei",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 17,
                          )
                        ],
                      ),
                SizedBox(height: 7,),
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.87,
                      child: _thumbnail,
                    )),
                // SizedBox(height: 3,),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WebViewPage(_webTitle, _webAddress)),
                    );
                  },
                  child: Row(
                    children: [
                      // SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                          _describe,
                          softWrap: false,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            height: 1.5,
                            //fontFamily: "Microsoft_YaHei",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,)
              ],
            )),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewPage(_webTitle, _webAddress))));
  }
}

class ImageInfoCard extends InfoCard {
  final AssetImage _fullAssetImage;

  ImageInfoCard(String title, String subTitle, Image thumbnail, String webTitle,
      String webAddress, String describe, this._fullAssetImage)
      : super(title, subTitle, thumbnail, webTitle, webAddress, describe);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        clipBehavior: Clip.antiAlias,
        // elevation: 10.0,
        child: Column(
          children: [
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WebViewPage(_webTitle, _webAddress))),
              child: Text(
                _title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  // fontFamily: "YouSheBiaoTiHei",
                  letterSpacing: 4,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 24.0,
                  height: 1,
                  //fontFamily: "Microsoft_YaHei",
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            _subTitle == ''
                ? SizedBox()
                : Row(
                    children: [
                      Expanded(
                        child: Text(
                          _subTitle,
                          softWrap: false,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            height: 1,
                            //fontFamily: "Microsoft_YaHei",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 17,
                      )
                    ],
                  ),
            // SizedBox(height: 5,),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ImageViewProvider(imageProvider: _fullAssetImage))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  child: _thumbnail,
                ),
              ),
            ),
            // SizedBox(height: 5,),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WebViewPage(_webTitle, _webAddress)),
                );
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _describe,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
          ],
        ));
  }
}
