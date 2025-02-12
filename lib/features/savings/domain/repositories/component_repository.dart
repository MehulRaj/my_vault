import 'package:my_vault/features/savings/domain/entities/component.dart';

abstract class ComponentRepository {
  Stream<Component?> watchTransactionData();

  Component? getTransactionData();

  Future<void> updateTransactionData(Component transaction);
}
