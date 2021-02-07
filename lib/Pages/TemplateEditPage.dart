import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';

class TemplateEditPage extends StatelessWidget {
  TemplateEditPage({Key key, this.id, this.name, this.memo}) : super(key: key);
  final String name;
  final String memo;
  final int id;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController memoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = this.name;
    memoController.text = this.memo;

    double dCardElevation = 2.2;
    return new Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('模板'),
        backgroundColor: AppStyle.mainBackgroundColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        // controller: controller,

        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                bottom: 8.0,
                left: 5.0,
              ),
              child: Text(
                '模板名称：',
                style: TextStyle(fontSize: 18.0, color: Colors.black87),
                textAlign: TextAlign.left,
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: 10.0),
              elevation: dCardElevation,
              child: CupertinoTextField(
                padding: const EdgeInsets.all(
                  10.0,
                ),
                autofocus: true,
                controller: nameController,
                // keyboardType: TextInputType.number,
                maxLength: 50,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize:  AppStyle.dTitleText,
                  // fontWeight: FontWeight.bold,
                ),
                // textAlign: TextAlign.right,
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                bottom: 8.0,
                top: 10.0,
                left: 5.0,
              ),
              child: Text(
                '模板说明：',
                style: TextStyle(fontSize: 18.0, color: Colors.black87),
                textAlign: TextAlign.left,
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: 10.0),
              elevation: dCardElevation,
              child: CupertinoTextField(
                maxLines: 10,
                padding: const EdgeInsets.all(
                  10.0,
                ),
                autofocus: true,
                controller: memoController,
                // keyboardType: TextInputType.number,
                maxLength: 500,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: AppStyle.dEditText,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            _getLoginButton(context, 'save'),
            _getLoginButton(context, 'exit'),
            // RaisedButton(
            //   child: Text('取消'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
          ]),
        ),
      )),
    );
  }

  final double dButtonHeight = 45.0;
  _getLoginButton(context, String name) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: dButtonHeight,
      child: RaisedButton(
        color: name == 'save' ? AppStyle.mainColor : Colors.redAccent,
        child: Text(
          name == 'save' ? '保 存' : '取 消',
          style: TextStyle(
            // height: 2.2,
            color: Colors.white,
            fontSize: 19,
            fontFamily: "微软雅黑",
            // backgroundColor: AppStyle.mainColor,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
          // side: BorderSide(color: Colors.red),
          //size:Size(width, height),
        ), //圆角大小
        onPressed: () {
          if (name == 'save')
            _saveData(context);
          else
            Navigator.of(context).pop('Cancel');
        },
      ),
    );
  }

  _saveData(context) {
    if (nameController.text.trim() == '') {
      AppToast.showToast('模板名称不能为空，请输入模板名称！');
    }

    if (nameController.text.trim() == this.name &&
        memoController.text.trim() == this.memo) {
      Navigator.of(context).pop('Cancel');
      return;
    }

    Map<String, dynamic> param = {
      "ID": this.id,
    };
    if (nameController.text.trim() != this.name)
      param["Name"] = nameController.text.trim();
    if (memoController.text.trim() != this.memo)
      param["memo"] = memoController.text.trim();

    // if (edittype == 0) {
    //   param['id']=sectionTimeModel.id;
    // }
    DataHelpr.dataHandler('Template/Modify', param, (rm) {
      DataHelpr.resultHandler(rm, () {
        GlobalVar.tempData['templatename'] = nameController.text.trim();
        GlobalVar.tempData['templatememo'] = memoController.text.trim();
        Navigator.of(context).pop('OK');
      });
    });
  }
}
