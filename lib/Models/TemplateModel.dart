import 'dart:convert';

import 'package:ovenapp/Models/DescribeModel.dart';
import 'package:ovenapp/Models/RecipeModel.dart';
import 'package:ovenapp/Models/SectionTimeModel.dart';

import 'RootModel.dart';

class TemplateModel extends RootModel {
  int id;
  String name;
  String memo;
  String mainpic;
  String createdt;
  int ccpid;
  String cname;
  String cid;
  int tscount = 0;
  int ischare = 0;
  int timers = 0; //总运行时间 ，单位秒
  List<SectionTimeModel> lstSection;
  List<RecipeModel> lstRecipe;
  List<DescribeModel> lstDescribe;
  int runcount = 0; //总共运行了多少次，根据这个来排序，用的最多的排前

  TemplateModel({
    this.id,
    this.name,
    this.memo,
    this.mainpic,
    this.createdt,
    this.ccpid,
    this.cname,
    this.cid,
    this.tscount,
    this.ischare,    
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return _getObjFromMap(parsedJson);
    // return TemplateModel(
    //   id: parsedJson['id'] == null ? 0 : parsedJson['id'],
    //   name: parsedJson['name'] == null ? "" : parsedJson['name'],
    //   memo: parsedJson['memo'] == null ? "" : parsedJson['memo'],
    //   mainpic:
    //       parsedJson['mainpic'] == null ? "camera.png" : parsedJson['mainpic'],
    //   createdt: parsedJson['createdt'] == DateTime.now()
    //       ? "0"
    //       : parsedJson['createdt'],
    //   ccpid: parsedJson['ccpid'] == null ? 0 : parsedJson['ccpid'],
    //   cname: parsedJson['cname'] == null ? "0" : parsedJson['cname'],
    //   cid: parsedJson['cid'] == null ? "0" : parsedJson['cid'],
    //   tscount: parsedJson['tscount'] == null ? 0 : parsedJson['tscount'],
    //   ischare: parsedJson['ischare'] == null ? 0 : parsedJson['ischare'],
    // );
  }

  // static getNullObj() {
  //   return TemplateModel(
  //     id: 0,
  //     name: '模板名称 ...',
  //     memo: '模板说明 ...',
  //     mainpic: 'camera.png',
  //     cid: '0',
  //     tscount: 0,
  //     cname: 'unknow',
  //     ccpid: 0,
  //     createdt: DateTime.now().toString(),
  //   );
  // }

  static fromJsonStr(String jsonstr) {
    if (jsonstr == null || jsonstr.trim() == '') return null;
    String js = jsonstr.replaceAll('\r', '').replaceAll('\n', '');
    try {
      Map map = json.decode(js);
      return _getObjFromMap(map);
    } catch (e) {
      print('*** TemplateModel.fromJsonStr($jsonstr) err : $e');
      return null;
    }
  }

  static _getObjFromMap(Map<String, dynamic> map) {
    return TemplateModel(
      id: map['id'] == null ? 0 : map['id'],
      name: map['name'] == null ? "" : map['name'],
      memo: map['memo'] == null ? "" : map['memo'],
      mainpic: map['mainpic'] == null ? "camera.png" : map['mainpic'],
      createdt:
          map['createdt'] == null ? DateTime.now().toString() : map['createdt'],
      ccpid: map['ccpid'] == null ? 0 : map['ccpid'],
      cname: map['cname'] == null ? "0" : map['cname'],
      cid: map['cid'] == null ? "0" : map['cid'],
      tscount: map['tscount'] == null ? 0 : map['tscount'],
      ischare: map['ischare'] == null ? 0 : map['ischare'],
    );
  }

  toJsonStr() {
    return '{"id":${this.id},' +
        '"name":"${this.name}",' +
        '"memo":"${this.memo}",' +
        '"mainpic":"${this.mainpic}",' +
        '"createdt":"${this.createdt}",' +
        '"ccpid":${this.ccpid},' +
        '"cname":"${this.cname}",' +
        '"cid":"${this.cid}",' +
        '"ischare":${this.ischare},' +
        '"tscount":${this.tscount},' +
        '"lstSection.length":${this.lstSection?.length},' +
        '"lstRecipe.length":${this.lstRecipe?.length},' +
        '"lstDescribe.length":${this.lstDescribe?.length}' +
        '}';
  }

  getOrderStr() {
//  String orderstr = '{"plan":[' + orderstr + ']}';
SectionTimeModel stm;
    String orderStr = '';
    if (lstSection != null && lstSection.isNotEmpty) {
      int ii=1;
      lstSection.forEach((sm) {
        stm=sm;
        orderStr = orderStr +
            ',{"timer":${stm.timer},"up":[${stm.uptemp},${stm.uppower}],"down":[${stm.downtemp},${stm.downpower}],"steamt":${stm.steamt},"tn":${this.id},"sn":$ii}';
            stm.sn=ii;
            ii++;
      });
      if(ii<5){
        for(int i=ii;i<=5;i++){
          orderStr = orderStr +
            ',{"timer":0,"up":[${stm.uptemp},${stm.uppower}],"down":[${stm.downtemp},${stm.downpower}],"steamt":${stm.steamt},"tn":${this.id},"sn":$ii}';            
            ii++;
        }
      }
      orderStr = '{"plan":[' + orderStr.substring(1) + ']}';
      // print('@@@ TemplateModel.getOrderStr() orderstr : $orderStr');
    }
    return orderStr;
  }

  refreshTimers() {
    this.timers = 0;
    if (lstSection != null && lstSection.isNotEmpty) {
      lstSection.forEach((stm) {
        this.timers = this.timers = stm.timer;
      });
    }
  }
}
