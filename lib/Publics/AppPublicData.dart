// import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
import 'package:ovenapp/Models/RootModel.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';

//数据的三级处理 1.内存 2.SharePrefHelper 3.Cloud Server
//只针对有限数量的表格数据进行存储
class AppPublicData {
  //单条模板数据
  static Map<String, RootModel> mpDataModel = {};

  //所有模板列表数据，里面不包含子列表，仅为列表显示用，键值一律用用户id+templates来取
  static Map<String, List<dynamic>> mpDataList = {}; //TemplateModel
  

  static removeData(String spfile, [int datatype = 2]) async {
    if (datatype == 0 || datatype == 2) mpDataList.remove(spfile);
    if (datatype == 1 || datatype == 2) mpDataModel.remove(spfile);
    // if (spfile.endsWith('templates'))
    //   mpDataList.remove(TemplateBO.getSectionListSpfile());
    await SharePrefHelper.removeData(spfile);
  }
}
