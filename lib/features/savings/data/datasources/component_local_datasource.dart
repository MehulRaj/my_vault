import 'package:hive_flutter/adapters.dart';
import 'package:my_vault/features/savings/core/constants.dart';
import 'package:my_vault/features/savings/data/models/component_model.dart';
import 'package:my_vault/features/savings/domain/entities/component.dart';

class ComponentLocalDatasource {
  final Box<ComponentModel> tripBox;

  ComponentLocalDatasource(this.tripBox);

  ComponentModel? getComponent() {
    var model =
        ComponentModel(date: DateTime.now(), components: [], saving: 0.0);
    try {
      return tripBox.get(Constant.components, defaultValue: model) ?? model;
    } catch (e) {
      return model;
    }
  }

  Future<void> updateComponent(ComponentModel trip) async {
    tripBox.(trip.components);
  }
}
