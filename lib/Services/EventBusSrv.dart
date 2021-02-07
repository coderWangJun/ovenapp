import 'package:event_bus/event_bus.dart';
import 'package:ovenapp/Models/ControlPanelModel.dart';
import 'package:ovenapp/Models/DeviceModel.dart';
import 'package:ovenapp/Models/JPushModel.dart';
import 'package:ovenapp/Models/MqttDataModel.dart';
import 'package:ovenapp/Models/PowerModel.dart';
import 'package:ovenapp/Models/WifiModel.dart';

/// 创建EventBus
EventBus eventBus = EventBus();

class MqttPayloadEvent {
  MqttDataModel data;
  MqttPayloadEvent(this.data);
}

class ControlPanelDataEvent {
  String uuid;
  ControlPanelDataEvent(this.uuid);
}

class DeviceEvent {
  String ot; //操作类型 add delete modify
  DeviceModel data;
  int cpindex;
  DeviceEvent(this.ot, this.data, this.cpindex);
}

class DeviceDataEvent {
  String did; //操作类型 add delete modify
  DeviceDataEvent(this.did);
}

class ControlPanelEvent {
  String ot; //操作类型 add delete modify
  ControlPanelModel data;
  ControlPanelEvent(this.ot, this.data);
}

class CallPageEvent {
  String pn; //操作类型 add delete modify
  String data;
  String data1;
  CallPageEvent(this.pn, this.data, this.data1);
}

class TimeSectionEvent {
  String tid; //模板 id
  TimeSectionEvent(this.tid);
}

class DialogCloseEvent {
  DialogCloseEvent();
}

class AudioPlayStopEvent {
  AudioPlayStopEvent();
}

class WarnCloseEvent {
  WarnCloseEvent();
}

class WarnStartEvent {
  String uuid;
  WarnStartEvent(this.uuid);
}

class WifiInfoEvent {
  WifiModel data;
  WifiInfoEvent(this.data);
}

class LoginEvent {
  LoginEvent();
}

class LogoutEvent {
  LogoutEvent();
}

class PageDataEvent {
  String page;
  PageDataEvent(this.page);
}

class DownloadedEvent {
  String dtype;
  String file;
  DownloadedEvent(this.dtype, this.file);
}

class DownloadEvent {
  String dtype;
  // String localpath;this.localpath,
  String urlpath;
  String urlfile;
  DownloadEvent(this.dtype, this.urlpath, this.urlfile);
}

class RunningEvent {
  String text;
  RunningEvent(this.text);
}

class TemplateChangedEvent {
  int id;
  TemplateChangedEvent(this.id);
}

class TemplateCallEvent {
  String child;
  int index;
  TemplateCallEvent(this.child, this.index);
}

class SaveTemplateEvent {
  int index;
  SaveTemplateEvent(this.index);
}

class PushEvent {
  PushEventModel pm;
  PushEvent(this.pm);
}

class PowerEvent {
  PowerModel pm;
  PowerEvent(this.pm);
}
//eventBus.fire(TimeSectionEvent(templateModel.id.toString()));
