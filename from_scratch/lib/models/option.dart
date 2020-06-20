class Option {
  String name;
  String key;
  bool state;

  Option(String name, String key) {
    this.name = name;
    this.key = key;
  }
}

List<Option> options = [
  Option('DLF', 'f0'),
  Option('J.C.', 'f1'),
  Option('Washing Machine', 'f2'),
  Option('Bakul Warehouse', 'f3'),
  Option('NBH Table Tennis', 'f4'),
];
