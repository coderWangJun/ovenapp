class UpDownFireModel{
   double power; 
  double temp;
  int isOpen;
  int index;

  UpDownFireModel({
    this.index,
    this.power,
    this.temp,
    this.isOpen,
  }) : super();

  String tojson() {
    return '{"index":' +
        index?.toString() +
        ',"power":' +
        power?.toString() +
        ',"temp":' +
        temp?.toString() +
        ',"isOpen":' +
        isOpen.toString() +
        '}';
  }
}