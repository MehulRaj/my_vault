import '../../data/models/component_model.dart';

abstract class ComponentRepository {
  Stream<ComponentModel?> watchTransactionData();

  ComponentModel? getTransactionData();

  Future updateTransactionData(ComponentModel transaction);
}
