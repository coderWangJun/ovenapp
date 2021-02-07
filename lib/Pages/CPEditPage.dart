import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/ControlPanelModel.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';

class CPEditPage extends StatelessWidget {
  CPEditPage({Key key, this.cpModel}) : super(key: key);
  // final String name;
  // final int id;, this.indexno, this.name, this.power
  // final int indexno;
  // final int power;
  final ControlPanelModel cpModel;

  final TextEditingController indexnoController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController powerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    indexnoController.text=cpModel.indexno.toString();
    nameController.text=cpModel.name.toString();
    powerController.text=cpModel.power.toString();

    double dCardElevation = 1.0;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('设备信息 [${cpModel.devicename} - ${cpModel.name}]'),
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
                top: 8.0,
              ),
              child: Text(
                '排序号：',
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
                left: 5.0,
                top: 8.0,
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
                autofocus: true,
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
                left: 5.0,
                top: 8.0,
              ),
              child: Text(
                '功率(瓦)：',
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
                controller: powerController,
                keyboardType: TextInputType.number,
                maxLength: 50,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: AppStyle.dTitleText,
                  // fontWeight: FontWeight.bold,
                ),
                // textAlign: TextAlign.right,
              ),
            ),
            AppWidget.getFullWidthButton(context, '保存', AppStyle.clSaveButtonBC,
                () {
              _saveData(context);
            },EdgeInsets.only(bottom: 15.0)),
            AppWidget.getFullWidthButton(
                context, '取消', AppStyle.clCancelButtonBC, () {
              Navigator.of(context).pop('Cancel');
            }),
          ]),
        ),
      )),
    );
  }

  _saveData(context) {
    int indexno = int.parse(indexnoController.text);
    if (indexno == null) {
      AppToast.showToast('排序号必须为整数格式，请输入整数！');
    }
    int power = int.parse(powerController.text);
    if (power == null) {
      AppToast.showToast('功率参数必须为整数格式，请输入整数！');
    }

    // if (!int.parse(indexnoController.text).) {
    //   AppToast.showToast('排序号不能为空，请输入排序号！');
    // }
    if (nameController.text.trim() == '') {
      AppToast.showToast('设备名称不能为空，请输入设备名称！');
    }
    // if (powerController.text.trim() == '') {
    //   AppToast.showToast('功率参数不能为空，请输入功率参数！');
    // }

    if (indexno == cpModel.indexno &&
        power == cpModel.power &&
        nameController.text.trim() == cpModel.name) {
      Navigator.of(context).pop('Cancel');
      return;
    }

    Map<String, dynamic> param = {
      "id": cpModel.id,
      "uuid": cpModel.uuid,
      "indexno": indexno,
      "name": nameController.text.trim(),
      "power": power,
    };

    DataHelpr.dataHandler('ControlPanel/Modify', param, (rm) {
      DataHelpr.resultHandler(rm, () {
        AppToast.showToast('保存成功！');
        cpModel.indexno = indexno;
        cpModel.name = nameController.text.trim();
        cpModel.power = power;
        Navigator.of(context).pop('OK');
      });
    });
  }
}
