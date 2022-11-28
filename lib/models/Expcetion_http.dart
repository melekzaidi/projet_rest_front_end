class Httexception implements Exception {
  late final String message;
  Httexception(this.message);
  @override
  String toString(){
    return message;
  }
  }