import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/DeviceModel.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';

// class DeviceDetailPage extends StatefulWidget {
//    DeviceDetailPage({Key key, this.deviceModel}) : super(key: key);

// final DeviceModel deviceModel;
//   // final String id;
//   @override
//   _DeviceDetailPageState createState() => _DeviceDetailPageState();
// }

// class _DeviceDetailPageState extends State<DeviceDetailPage> {
//   @override
//   void initState() {
//     super.initState();
//     print("@@@ => DeviceDetail.initState()");

//     // if (GlobalVar.mqttClass == null) {
//     //   // print("@@@ => GlobalVar.initMqttSrv()");
//     //   GlobalVar.initMqttSrv();
//     // }
//   }

//   @override
//   void dispose() {
//     super.dispose();

//     print("@@@ DeviceDetail.dispose() ...");
//   }

class DeviceDetailPage extends StatelessWidget {
  DeviceDetailPage({Key key, this.deviceModel}) : super(key: key);
  final DeviceModel deviceModel;
  // final String memo;
  // final int id;
  final TextEditingController indexnoController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController memoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("@@@ DeviceDetail.build() ...");
indexnoController.text = this.deviceModel.indexno.toString();
    nameController.text = this.deviceModel.name;
    memoController.text = this.deviceModel.memo;

    double dCardElevation = 0.5;
    return new Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('设备信息 [${deviceModel.name}]'),
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
                '序号：',
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
                controller: indexnoController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: AppStyle.dTitleText,
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
                left: 5.0,
              ),
              child: Text(
                '名称：',
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
                // autofocus: true,
                controller: nameController,
                // keyboardType: TextInputType.number,
                maxLength: 50,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: AppStyle.dTitleText,
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
                '备注：',
                style: TextStyle(fontSize: 18.0, color: Colors.black87),
                textAlign: TextAlign.left,
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: 10.0),
              elevation: dCardElevation,
              child: CupertinoTextField(
                maxLines: 6,
                padding: const EdgeInsets.all(
                  10.0,
                ),
                // autofocus: true,
                controller: memoController,
                // keyboardType: TextInputType.number,
                maxLength: 300,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: AppStyle.dEditText,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            AppWidget.getFullWidthButton(context, '保存', AppStyle.clSaveButtonBC, () {
              _saveData(context);
            },EdgeInsets.only(bottom: 12.0)),
            AppWidget.getFullWidthButton(context, '取消', AppStyle.clCancelButtonBC, () {
              Navigator.of(context).pop();
            }),
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

  _saveData(context) {
    if (indexnoController.text.trim() == '') {
      AppToast.showToast('序号不能为空，请输入设备序号！');
      return;
    }

    if (nameController.text.trim() == '') {
      AppToast.showToast('名称不能为空，请输入设备名称！');
      return;
    }

    if (indexnoController.text.trim() == deviceModel.indexno.toString() &&
        nameController.text.trim() == deviceModel.name &&
        memoController.text.trim() == deviceModel.memo) {
      Navigator.of(context).pop('Cancel');
      return;
    }

    DataHelpr.dataHandler('Device/Modify', {
      "ID": deviceModel.id,
      "IndexNo": indexnoController.text.trim(),
      "Name": nameController.text.trim(),
      "Memo": memoController.text.trim()
    }, (rm) {
      DataHelpr.resultHandler(rm, () {
        deviceModel.indexno = int.parse(indexnoController.text);
        deviceModel.name = nameController.text.trim();
        deviceModel.memo = memoController.text.trim();
        Navigator.of(context).pop('OK');
      });
    });

    // Navigator.of(context).pop();
  }
}
