import 'package:flutter/material.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Models/DescribeModel.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/RecipeModel.dart';
import 'package:ovenapp/Models/SectionTimeModel.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Pages/TemplateListPage.dart';
import 'package:ovenapp/Pages/TemplatePage.dart';
import 'package:ovenapp/Publics/AppPublicData.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';

class TemplateBO {
  static double dControlPanelUnitWidth = 90.0;
  static int tsCount = 0;
  static int index = 0; //0时段，1配方，2说明

  static getTemplate(int tid, [int fromcs = 0]) async {
    // String spfile = 'template' + tid.toString();

    // bool isQueryData = true;

    List<dynamic> lstObj = [
      TemplateModel(),
      SectionTimeModel(),
      RecipeModel(),
      DescribeModel()
    ];

    // if (fromcs == 0) {
    //   if (GlobalVar.lstTemplate != null &&
    //       GlobalVar.lstTemplate.containsKey(tid)) {
    //     // print('@@@ AppPublicData.getTemplate() Cache data : $spfile');
    //     return;
    //   }

    //   if (SharePrefHelper.appPrefs.containsKey(spfile)) {
    //     String jsonData = await SharePrefHelper.getData(spfile);
    //     // print('@@@ AppPublicData.getTemplate() SharePrefHelper data : $jsonData');
    //     if (jsonData != null && jsonData != "") {
    //       try {
    //         print(
    //             '@@@ TemplateBO.getTemplate() SharePrefHelper data : $spfile');
    //         // Map<String, dynamic> ret = json.decode(jsonData);
    //         // HttpRetModel rm = HttpRetModel.fromJson3(ret, TemplateModel(),SectionTimeModel(),RecipeModel(),DescribeModel());
    //         HttpRetModel rm = HttpRetModel.fromJsonStr(jsonData, lstObj);
    //         isQueryData = false;
    //         TemplateModel tm = getTemplateModel(rm);
    //         GlobalVar.lstTemplate[tid] = tm;
    //         // print('@@@ AppPublicData.getTemplate() ************* TemplateModel.name : ${tm.name}');
    //         // AppPublicData.mpDataModel[spfile] = tm;
    //         // print('@@@ AppPublicData.getTemplate() ############## TemplateModel spfile : $spfile');
    //       } catch (e) {
    //         // AppPublicData.removeData(spfile);
    //         print('*** TemplateBO.getData() local data e : $e');
    //         isQueryData = true;
    //       }
    //     }
    //   }
    // }
    // if (isQueryData) {
    var param = {
      "id": tid,
      // "orderby": "CreateDT DESC",
    };

    await DataHelpr.dataQuerier('Template/Info', param, lstObj, (ret) {
      HttpRetModel rm = ret as HttpRetModel;

      print(
          '@@@ TemplateBO.getTemplate() Cloud data rm.ret : ${rm.ret} , lstObj $lstObj');
      // print(
      //     '@@@ AppPublicData.getTemplate selectData => ret : ${rm.ret} , data.length : ${rm.data.length} , data1.length : ${rm.data1.length}');

      if (rm.ret == 0) {
        // print(
        //     '@@@ AppPublicData.getTemplate() **********%%%%% rm.data.length : ${rm.data.length}');
        TemplateModel tm = getTemplateModel(rm);
        // print(
        //     '@@@ AppPublicData.getTemplate() &&&&&&&&&&&&&& TemplateModel : ${tm.toJsonStr()}');
        // AppPublicData.mpDataModel[spfile] = tm;
        GlobalVar.lstTemplate[tid] = tm;
      }
    });
    // }
  }

  static getTemplates([int fromcs = 0]) async {
    //fomrcs是否从服务器取数据，0先从本地，1直接取云
    // String spfile = getSpfile(); //  GlobalVar.userInfo.id + 'templates';
    // if (fromcs == 0 && GlobalVar.lstTemplate != null) {
    //   print('@@@ TemplateBO._getTemplates() Cache Data : $spfile');
    //   return;
    // }

    // bool isQueryData = true;
    List<dynamic> lstObj = [
      TemplateModel(),
      SectionTimeModel(),
      RecipeModel(),
      DescribeModel()
    ];

    // if (fromcs == 0) {
    //   if (SharePrefHelper.appPrefs.containsKey(spfile)) {
    //     String jsonData = await SharePrefHelper.getData(spfile);
    //     // print('@@@ AppPublicData._getTemplates() SharePref Data : $jsonData');
    //     if (jsonData != null && jsonData != "") {
    //       try {
    //         // Map<String, dynamic> ret = json.decode(jsonData);
    //         // HttpRetModel rm = HttpRetModel.fromJson(ret, TemplateModel());
    //         HttpRetModel rm = HttpRetModel.fromJsonStr(jsonData, lstObj);
    //         getTemplateModel(rm);
    //         // isQueryData = false;
    //         print('@@@ TemplateBO._getTemplates() SharePref data : $spfile');
    //         return;
    //       } catch (e) {
    //         // AppPublicData.mpTables.remove(spfile);
    //         SharePrefHelper.removeData(spfile);
    //         print('*** TemplateBO._getTemplates() SharePref data e : $e');
    //         // isQueryData = true;
    //       }
    //     }
    //   }
    //   // }
    // }

    // if (isQueryData) {

    await DataHelpr.dataQuerier('Template/List', null, lstObj, (ret) {
      HttpRetModel rm = ret as HttpRetModel;
      // print(
      //     '@@@ AppPublicData.getTemplates Cloud Data => rm.ret : ${rm.ret}');
      // print(
      //     '@@@ AppPublicData.getTemplates Cloud Data => data : $spfile , rm.data.length : ${rm.data?.length} ，rm.data1.length : ${rm.data1?.length} ，rm.data2.length : ${rm.data2?.length} ，rm.data3.length : ${rm.data3?.length}');

      if (rm.ret == 0) {
        getTemplateModel(rm);
      }
    });
    // }
  }

  static getTemplateModel(HttpRetModel rm) {
    if (rm.data == null || rm.data.isEmpty) return;

    if (GlobalVar.lstTemplate == null)
      GlobalVar.lstTemplate = {};
    else
      GlobalVar.lstTemplate.clear();

    rm.data.forEach((mo) {
      // print(
      //     '@@@ TemplateBO.getTemplateModel() HttpRetModel.data.length : ${rm.data.length} , HttpRetModel.data1.length : ${rm.data1.length} , HttpRetModel.data2.length : ${rm.data2.length} , HttpRetModel.data3.length : ${rm.data3.length}');
      TemplateModel tm = mo as TemplateModel;
      int totaltime = 0;
// print(
//         '@@@ TemplateBO.getTemplateModel() >>>>>>>>>>>>>> tm.name : ${tm.name}');
      if (rm.data1 != null && rm.data1.isNotEmpty) {
        if (tm.lstSection == null) tm.lstSection = [];
        // tm.lstSection = rm.data1 as List<SectionTimeModel>;
        rm.data1.forEach((mm) {
          // SectionTimeModel mm = m as SectionTimeModel;
          if (mm.tid == tm.id) {
            tm.lstSection.add(mm);
            totaltime = totaltime + mm.timer;
          }
        });
      }

      if (rm.data2 != null && rm.data2.isNotEmpty) {
        if (tm.lstRecipe == null) tm.lstRecipe = [];
        // tm.lstRecipe = rm.data2 as List<RecipeModel>;
        rm.data2.forEach((mm) {
          // RecipeModel mm = m as RecipeModel;
          if (mm.tid == tm.id) tm.lstRecipe.add(mm);
        });
      }

      if (rm.data3 != null && rm.data3.isNotEmpty) {
        if (tm.lstDescribe == null) tm.lstDescribe = [];
        // tm.lstDescribe = rm.data3 as List<DescribeModel>;
        rm.data3.forEach((mm) {
          // DescribeModel mm = m as DescribeModel;
          if (mm.tid == tm.id) tm.lstDescribe.add(mm);
        });
      }
      tm.timers = totaltime;
      GlobalVar.lstTemplate[tm.id] = tm;
    });
    print(
        '@@@ TemplateBO.getTemplateModel() GlobalVar.lstTemplate.length : ${GlobalVar.lstTemplate.length}');
    // return tm;
  }

  static showTemplateListPage(context) async {
    await getTemplates();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TemplateListPage(
          iid: 0,
          // cpname: "ACE",
          // dest: 0,
        ),
      ),
    );
    // }
  }

  static showTemplatePage(context, tm) async {
    // await getTemplate(tm.id);
    print('@@@ AppObjHelper.showTemplatePage() tm.name : ${tm.name}');
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TemplatePage(id: tm.id)));
  }

  // static getSpfile(int id) {
  //   return 'template' + id.toString();
  // }

  static getSpfile() {
    return (GlobalVar.userInfo == null ? '' : GlobalVar.userInfo.id) +
        'templates';
  }

  static cleanCache() async {
    await SharePrefHelper.removeData(getSpfile());
  }
  // static getSectionListSpfile() {
  //   return ((GlobalVar.userInfo == null ? '' : GlobalVar.userInfo.id) +
  //           'templates') +
  //       'section';
  // }
}
