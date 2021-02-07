import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
import 'package:ovenapp/Classes/AppToast.dart';
// import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Controls/AppTextField.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
// import 'package:ovenapp/Controls/DeviceUnit.dart';
import 'package:ovenapp/Models/RecipeModel.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';

class TLRecipeEditPage extends StatelessWidget {
  TLRecipeEditPage({Key key, this.templateModel, this.index}) : super(key: key);
  final int index; //插入的位置，0添加到最后，>0插入到之前
  // final int tid;
  final double dTextFieldLineHeight = 45.0;
  final TemplateModel templateModel;

  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController unitController = TextEditingController(text: "");
  final TextEditingController amountController =
      TextEditingController(text: "");
  final TextEditingController memoController = TextEditingController(text: "");

// RecipeModel recipeModel;this.recipeModel
  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = EdgeInsets.only(bottom: 12.0);

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('配方设置 [${templateModel.name}]'),
        backgroundColor: AppStyle.mainBackgroundColor,
        elevation: 0.0,
        shape: AppWidget.getAppBarBottomBorder(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // controller: controller,

          child: Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 12.0),
            child: Column(
              children: <Widget>[
                AppTextField(
                  title: '名称',
                  textController: nameController,
                  af: true,
                  margin: margin,
                ),
                AppTextField(
                  title: '数量',
                  textController: amountController,
                  tt: TextInputType.number,
                  margin: margin,
                ),
                AppTextField(
                  title: '单位',
                  textController: unitController,
                  margin: margin,
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
                // AppWidget.getFullWidthButton(
                //     context, '取消', AppStyle.clCancelButtonBC, () {
                //   Navigator.of(context).pop();
                // }, EdgeInsets.only(top: 10.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _save(context) async {
    RecipeModel dataModel = RecipeModel();
    dataModel.name = nameController.text.trim();
    if (dataModel.name == '') {
      AppToast.showToast('名称不能为空，请输入！');
      return;
    }
    dataModel.unit = unitController.text.trim();
    if (dataModel.name == '') {
      AppToast.showToast('单位不能为空，请输入！');
      // FocusScope.of(context).requestFocus(unitController);
      return;
    }
    dataModel.amount = 0;
    try {
      dataModel.amount = double.parse(amountController.text.trim());
    } catch (e) {
      AppToast.showToast(e);
      return;
    }
    dataModel.mainpic = 'recipe.png';
    dataModel.indexno = (index == null || index == 0)
        ? (templateModel.lstRecipe == null
            ? 1
            : templateModel.lstRecipe.length + 1)
        : index;
    dataModel.memo = memoController.text.trim();
    dataModel.tid = templateModel.id;
    // AppObjHelper.getJsonStrFormObj(dataModel);

// json.encode(SectionTimeModel);
    // String jsonStr =
    //     SectionTimeModel.toJson(dataModel); // json.encode(SectionTimeModel);
    // print("@@@ _saveData() SectionTimeModel : $jsonStr");

    // Map<String, dynamic> param = {
    //   "phoneno": phoneController.text.trim(),
    //   "code": codeController.text.trim()
    // };
    // Map<String, dynamic> param = json.decode(jsonStr);
    Map<String, dynamic> param = {
      "Template_ID": dataModel.tid,
      "IndexNo": dataModel.indexno,
      "Name": dataModel.name,
      "Amount": dataModel.amount,
      "Unit": dataModel.unit,
      // "Memo": dataModel.memo,
      "MainPic": dataModel.mainpic,
    };

    await DataHelpr.dataHandler('Template/AddRecipe', param, (ret) {
// DataHelpr.resultHandler(rm, (){});
      if (ret.ret == 0) {
        AppToast.showToast("保存成功！");
        print("@@@ TLRecipeEditPage._save() ret.id : ${ret.id}");
        dataModel.id = int.parse(ret.id);

        templateModel.lstRecipe.add(dataModel);

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
