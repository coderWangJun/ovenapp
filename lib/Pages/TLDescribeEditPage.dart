import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
// import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Models/DescribeModel.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';

class TLDescribeEditPage extends StatelessWidget {
  TLDescribeEditPage({Key key, this.templateModel, this.index})
      : super(key: key);
  final TemplateModel templateModel;
  final int index;

  final TextEditingController memoController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    print(
        "@@@ TLDescribeEditPage.build() templateModel : ${templateModel.toJsonStr()}");
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('详细说明项 [${templateModel.name}]'),
        backgroundColor: AppStyle.mainBackgroundColor,
        actions: _getActions(context),
        elevation: 0.0,
        shape: AppWidget.getAppBarBottomBorder(),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          margin: EdgeInsets.all(8.0),
          child: Card(
            // margin: EdgeInsets.only(bottom: 10.0),
            elevation: 0.5,
            child: CupertinoTextField(
              maxLines: 3000,
              padding: const EdgeInsets.all(
                10.0,
              ),
              // autofocus: true,
              controller: memoController,
              // keyboardType: TextInputType.number,
              maxLength: 5000,
              style: TextStyle(
                color: Colors.grey,
                fontSize: AppStyle.dEditText,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        //  Column(
        //   children: <Widget>[
        //     // Container(
        //     //   width: double.infinity,
        //     //   alignment: Alignment.centerLeft,
        //     //   margin: EdgeInsets.only(
        //     //     bottom: 8.0,
        //     //     top: 10.0,
        //     //     left: 5.0,
        //     //   ),
        //     //   child: Text(
        //     //     '模板说明：',
        //     //     style: TextStyle(fontSize: 18.0, color: Colors.black87),
        //     //     textAlign: TextAlign.left,
        //     //   ),
        //     // ),

        //   ],
        //   // controller: memoController,
        // ),
        // ),
        // bottom: false,
      ),
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.zero,
      //   height: 48.0,
      //   color: Colors.indigoAccent,
      //   child: Row(
      //     children: <Widget>[
      //       Expanded(
      //         // child: FlatButton(
      //         //   // padding: EdgeInsets.zero,
      //         //   onPressed: () {
      //         //     _save(context);
      //         //   },
      //         //   child: Text('保存'),
      //         // ),
      //         child: GestureDetector(
      //           onTap: () {
      //             _save(context);
      //           },
      //           child: Container(
      //             alignment: Alignment.center,
      //             height: double.infinity,
      //             color: AppStyle.clSaveButtonBC,
      //             child: Text(
      //               '保存',
      //               style: TextStyle(
      //                 fontSize: 18.0,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //       Expanded(
      //         // child: FlatButton(
      //         //   onPressed: () {
      //         //     Navigator.of(context).pop();
      //         //   },
      //         //   child: Text('取消'),
      //         // ),
      //         child: GestureDetector(
      //           onTap: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Container(
      //             alignment: Alignment.center,
      //             height: double.infinity,
      //             color: AppStyle.clCancelButtonBC,
      //             child: Text(
      //               '取消',
      //               style: TextStyle(
      //                 fontSize: 18.0,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  _getActions(context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.save),
          color: AppStyle.clButtonGray,
          iconSize: 28.0,
          onPressed: () {
            _save(context);
          }),
    ];
  }

// child: SingleChildScrollView(
//           // controller: controller,
//           padding: EdgeInsets.all(12.0),
  _save(context) async {
    DescribeModel dataModel = DescribeModel();
    dataModel.memo = memoController.text.trim();
    if (dataModel.memo == '') {
      AppToast.showToast('内容不能为空，请输入！');
      return;
    }

    dataModel.ttype = 1;
    dataModel.indexno = (index == null || index == 0)
        ? (templateModel.lstDescribe == null
            ? 1
            : templateModel.lstDescribe.length + 1)
        : index;
    // dataModel.memo = memoController.text.trim();
    dataModel.tid = templateModel.id;

    Map<String, dynamic> param = {
      "Template_ID": dataModel.tid,
      "IndexNo": dataModel.indexno,
      "Memo": dataModel.memo,
      "TType": dataModel.ttype,
    };

    await DataHelpr.dataHandler('Template/AddDescribe', param, (ret) {
// DataHelpr.resultHandler(rm, (){});
      if (ret.ret == 0) {
        AppToast.showToast("保存成功！");
        print("@@@ TLDescribeEditPage._save() ret.id : ${ret.id}");
        dataModel.id = int.parse(ret.id);

        templateModel.lstDescribe.add(dataModel);

        // AppPublicData.removeData(spfile);
        // SharePrefHelper.removeData(TemplateBO.getSpfile());
        TemplateBO.cleanCache();

        Navigator.of(context).pop('OK');
      } else {
        AppToast.showToast("保存失败：${ret.message}", 2);
      }
    });
  }
}
