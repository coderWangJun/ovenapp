import 'package:flutter/material.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Controls/AppTextField.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';

class ChangePwdPage extends StatelessWidget { 

  final double dTextFieldLineHeight = 45.0;
  final TextEditingController p0Controller = TextEditingController(text: "");
  final TextEditingController p1Controller = TextEditingController(text: "");
  final TextEditingController p2Controller =
      TextEditingController(text: "");

// RecipeModel recipeModel;this.recipeModel
  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = EdgeInsets.only(bottom: 12.0);

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('修改密码'),
        backgroundColor: AppStyle.mainBackgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // controller: controller,

          child: Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 12.0),
            child: Column(
              children: <Widget>[
                AppTextField(
                  title: '原始密码',
                  textController: p0Controller,
                  af: true,
                  margin: margin,
                  ispwd: true,
                ),
                AppTextField(
                  title: '新密码',
                  textController: p1Controller,
                  tt: TextInputType.number,
                  margin: margin,
                  ispwd: true,
                ),
                AppTextField(
                  title: '确认密码',
                  textController: p2Controller,
                  margin: margin,
                  ispwd: true,
                ),
                // AppWidget.getBottomLineTF(nameController, '名称'),
                // AppWidget.getBottomLineTF(amountController, '数量'),
                // AppWidget.getBottomLineTF(unitController, '单位'),
                AppWidget.getFullWidthButton(
                  context,
                  '保存',
                  AppStyle.clSaveButtonBC,
                  () {
                    _save(context);
                  },
                  EdgeInsets.only(top: 20.0),
                ),
                AppWidget.getFullWidthButton(
                    context, '取消', AppStyle.clCancelButtonBC, () {
                  Navigator.of(context).pop();
                }, EdgeInsets.only(top: 10.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _save(context) async {
    if (p0Controller.text== '') {
      AppToast.showToast('原始密码不能为空，请输入！');
      return;
    }
    if (p1Controller.text== '') {
      AppToast.showToast('新密码不能为空，请输入！');
      return;
    }
    if (p2Controller.text== '') {
      AppToast.showToast('确认密码不能为空，请输入！');
      return;
    }
    if (p2Controller.text != p1Controller.text) {
      AppToast.showToast('新密码与确认密码不一致，请输入！');
      return;
    }
    
    Map<String, dynamic> param = {
      "oldpwd": p0Controller.text,
      "newpwd":p1Controller.text,
    };

    await DataHelpr.dataHandler('Client/ChangePwd', param, (ret) {
// DataHelpr.resultHandler(rm, (){});
      if (ret.ret == 0) {
        AppToast.showToast("保存成功！");      

        Navigator.of(context).pop('OK');
      } else {
        AppToast.showToast("保存失败：${ret.message}", 2);
      }
    });
  }
}