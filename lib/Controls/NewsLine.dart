import 'package:flutter/material.dart';
import 'package:ovenapp/Models/NewsModel.dart';

class NewsLine {
  static Widget getNewsItem(BuildContext context, NewsModel nm, int ii) {
    //NewsModel nm String title,String dt
    return GestureDetector(
        // onTap: _itemClick(nm.id),
        onTap: () {
          //  print("@@@ _itemClick() id => " + nm.id);
          // Navigator.of(context).pushNamed("/webviewer");
          _newsListItemClick(context, nm);
        },
        child: Container(
            // padding: EdgeInsets.only(left: 25, right: 25),
            margin: EdgeInsets.only(left: 25, right: 25),
            height: 45.0,
            decoration: new BoxDecoration(
                border: new Border(
                    bottom: BorderSide(
              width: 1,
              color: new Color(0xffe3e3e3),
            ))),
            // child: GestureDetector(
            //     onTap: _itemClick(nm.id),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              // verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Expanded(
                  child: Text(
                    (ii+1).toString() + ". " + nm.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      color: new Color(0xff5b5b5c),
                      // fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
                Text(
                  nm.createdt,
                  style: TextStyle(
                    fontSize: 17,
                    color: new Color(0xffaaaaab),
                  ),
                ),
              ],
            )));
  }

  static _newsListItemClick(BuildContext context, NewsModel nm) {
     print("@@@ _newsListItemClick() id => " + nm.id.toString());
    // Navigator.push(
    //   context,
    //   new MaterialPageRoute(
    //       builder: (context) => new NewsDetailPage(id: nm.id)),
    // );
  }
}
