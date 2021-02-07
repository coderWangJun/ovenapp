class DateTimeHelper {
  static changeMinSec2HMS(int min, int sec) {
    String hs = '';
    String ms = '';
    String ss = '';
    if (min > 59) {
      hs = '01:';
      ms = (min - 60).toString().padLeft(2, '0') + ':';
    } else {
      hs = '';
      ms = min.toString().padLeft(2, '0') + ':';
    }
// double m=mm-60;
    ss = sec.toString().padLeft(2, '0');
    return hs + ms + ss;
  }

  static changeSecToHMS(int sec) {
    String hs = '';
    String ms = '';
    String ss = '';
    int hc = sec ~/ 3600;
    if (hc > 0) hs = hc.toString().padLeft(2, '0') + ':';

    int mc = (sec - 3600 * hc) ~/ 60;

    if (mc > 0) ms = mc.toString().padLeft(2, '0') + ':';

    int sc = sec - 3600 * hc - mc * 60;

    ss = sc.toString().padLeft(2, '0');
    return hs + ms + ss;
  }

  static changeSecToMS(int sec) {
    // String hs = '';
    String ms = '';
    String ss = '';
    int mc = sec ~/ 60;

    if (mc > 0) {
      ms = mc.toString().padLeft(2, '0') + ':';
    } else {
      ms = '00:';
    }

    int sc = sec - mc * 60;
    if (sc > 0) {
      // ss = ms + ':' + sc.toString().padLeft(2, '0');
      ss = sc.toString().padLeft(2, '0');
    } else {
      // ss=ms;
      ss = '00';
    }
    // print('@@@ sec : $sec , mc : $mc , sc : $sc , ms : $ms , ss : $ss');
    //  print('@@@ ret : $ss');
    return ms + ss;
  }

  static getHMFromSec(int sec) {
    if (sec == 0) return '00:00';

    String hs = '';
    String ms = '';
    // String ss = '';
    int hc = sec ~/ 3600;
    if (hc > 0)
      hs = hc.toString().padLeft(2, '0') + ':';
    else
      hs = "00:";

    int mc = (sec - 3600 * hc) ~/ 60;

    if (mc > 0)
      ms = mc.toString().padLeft(2, '0');
    else
      ms = "00";

    return hs + ms;
  }

  static getNowStr(){
    return  DateTime.now().toString().replaceAll('-', '').replaceAll(' ', '').replaceAll(':', '').replaceAll('.', '');
  }
}
