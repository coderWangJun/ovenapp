// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_swiper/flutter_swiper.dart';

// import 'package:ovenapp/Controls/MaterialButton.dart';
// import 'package:ovenapp/Models/HttpRetModel.dart';
// import 'package:ovenapp/Models/MaterialModel.dart';
// import 'package:ovenapp/Publics/DataHelper.dart';
// import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Services/HttpCallerSrv.dart';

class MaterialBO {
//   static FutureBuilder getMaterialFB(BuildContext context) {
//     return FutureBuilder(
//       future: _getMaterialData(context),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.none:
//           case ConnectionState.active:
//           case ConnectionState.waiting:
//             // print(snapshot.connectionState);
//             // return _getNullMaterialUI();
//             return Center(child: CupertinoActivityIndicator());
//           case ConnectionState.done:
//             // print('done');

//             if (snapshot.hasError) {
//               return _getNullMaterialUI();
//             }

//             _materialData = snapshot.data;
//             return _getMaterialUI(snapshot.data);
//           default:
//             return _getNullMaterialUI();
//         }
//         // return null;
//       },
//     );
//   }

//   static Future<HttpRetModel> _getMaterialData(BuildContext context) async {
//     return await DataHelpr.getData(context, "Home/Material", GlobalVar.spmaterial, "MaterialModel");
//     // HttpRetModel rm;
//     // String sret = await HttpCallerSrv.get(
//     //     "Home/Material", null); //, GlobalVar.userInfo.tk);

//     // // print("@@@ HomePage._getAdvertData() data => " + sret);

//     // if (sret == "http401") {
//     //   // Navigator.pop(context);
//     //   // Navigator.of(context).pushNamed("/login");
//     //   return null;
//     // }

//     // try {
//     //   Map<String, dynamic> ret = json.decode(sret);
//     //   rm = HttpRetModel.fromJson(ret, new MaterialModel());

//     //   print(
//     //       "@@@ MaterialBO._getMaterialData() rm.data.length => ${rm.data.length}");
//     // } catch (e) {
//     //   print("*** MaterialBO._getMaterialData() data => $e");
//     // }

//     // return rm;
//   }

//   static HttpRetModel _materialData;

//   static Widget _getMaterialUI(HttpRetModel data) {
//     return Column(children: <Widget>[
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           new HomeMaterialButton(
//               materialModel: _materialData.data[0] as MaterialModel),
//           new HomeMaterialButton(
//               materialModel: _materialData.data[1] as MaterialModel),
//           new HomeMaterialButton(
//               materialModel: _materialData.data[2] as MaterialModel),
//         ],
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           new HomeMaterialButton(
//               materialModel: _materialData.data[3] as MaterialModel),
//           new HomeMaterialButton(
//               materialModel: _materialData.data[4] as MaterialModel),
//           new HomeMaterialButton(
//               materialModel: _materialData.data[5] as MaterialModel),
//         ],
//       ),
//     ]);
//   }

// //{"material":"烘培原料","utensil": "烘培器具","school": "烘培学院","machine": "烘培机器","ai": "烘培智能","package": "烘培包装"};
//   static Widget _getNullMaterialUI() {
//     return Column(children: <Widget>[
//       Container(height: 5,),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           new HomeNullMaterialButton(id: "material"),
//           new HomeNullMaterialButton(id: "appliance"),
//           new HomeNullMaterialButton(id: "school"),
//         ],
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           new HomeNullMaterialButton(id: "machine"),
//           new HomeNullMaterialButton(id: "ai"),
//           new HomeNullMaterialButton(id: "package"),
//         ],
//       ),
//     ]);
//   }

//   static Widget getUI(){
//     return _getNullMaterialUI();
//   }
  // static Widget _getSwiperImage(BuildContext context, int index) {
  //   // print("@@@ _getSwiperImage() => index : " + index.toString());
  //   // print("@@@ _getSwiperImage() => _advertData.data : " + _advertData.data.length.toString());
  //   return (Image.network(
  //     GlobalVar.webimageurl + (_advertData.data[index] as AdvertModel).mainpic,
  //     fit: BoxFit.fill,
  //   ));
  // }
}
