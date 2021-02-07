class OvenDataModel {
  String uuid;
  int state;
  // List up;
  int upset;
  int upreal;
  int uppower;
  int ups;
  // List down;
  int downset;
  int downreal;
  int downpower;
  int downs;
  // List timer;
  int timerset;
  int timerreal;
  // List steam;
  int steamset;
  int steamreal;
  // List center;
  int centerset;
  int centerreal;
  int gate;
  int light;
  int fan;
  int steams;
  int water;
  int gas;
  int steamt;
  int tn;
  int sn;

  OvenDataModel({
    this.uuid,
    this.state,
    this.ups,
    // this.up,
    this.upset,
    this.upreal,
    this.uppower,
    this.downs,
    // this.down,
    this.downset,
    this.downreal,
    this.downpower,
    // this.timer,
    this.timerset,
    this.timerreal,
    // this.steam,
    this.steamset,
    this.steamreal,
    // this.center,
    this.centerset,
    this.centerreal,
    this.gate,
    this.light,
    this.fan,
    this.steams,
    this.water,
    this.gas,
    this.steamt,
    this.tn,
    this.sn,
  }) : super();

  // UserModel(Map<String, dynamic> parsedJson)
  // {
//topic is </05DAFF333136595043146815>, payload is <-- {"up":[307,16,5],"down":[303,16,5],"timer":[360,0],"state":1,"steam":[200,19],"center":[0,20],"ups":1,"downs":1,"gate":0,"light":0,"fan":0,"steams":0,"water":0,"gas":0,"steamt":3,"sn":0,"tn":0}
  // }

// factory UserModel.
  fromJson(Map<String, dynamic> parsedJson) {
    return OvenDataModel(
      uuid: parsedJson['uuid'],
      state: parsedJson['state'],

      ups: parsedJson['ups'],
      upset: parsedJson['upset'],
      upreal: parsedJson['upreal'],
      uppower: parsedJson['uppower'],

      downs: parsedJson['downs'],
      downset: parsedJson['downset'],
      downreal: parsedJson['downreal'],
      downpower: parsedJson['downpower'],

      timerset: parsedJson['timerset'],
      timerreal: parsedJson['timerreal'],

      steamset: parsedJson['steamset'],
      steamreal: parsedJson['steamreal'],
      steams: parsedJson['steams'],

      centerset: parsedJson['centerset'],
      centerreal: parsedJson['centerreal'],

      gate: parsedJson['gate'],
      light: parsedJson['light'],
      fan: parsedJson['fan'],
      water: parsedJson['water'],
      gas: parsedJson['gas'],
      steamt: parsedJson['steamt'],
      tn: parsedJson['tn'],
      sn: parsedJson['sn'],
    );
  }

  // String tojson() {
  //   return '{"id":' +
  //       id.toString() +
  //       ',"loginid":"' +
  //       loginid +
  //       ',"name":"' +
  //       name +
  //       '","avatar":"' +
  //       avatar +
  //       '","companyid":' +
  //       companyid.toString() +
  //       ',"userlevel":' +
  //       userlevel.toString() +
  //       ',"sn":"' +
  //       sn +
  //       '","tk":"' +
  //       tk +
  //       '"}';
  // }
}
