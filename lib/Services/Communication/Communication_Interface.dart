import 'package:lobevent/Data/Types/MyType.dart';

abstract class Communication_Interface<TYPE>{
  Future<List<TYPE>> get();
  Future<TYPE> getByID(int id);
  void post(TYPE typeObject);
}