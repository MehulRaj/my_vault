import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_vault/features/savings/core/constants.dart';
import 'package:my_vault/features/savings/domain/entities/savings.dart';
import 'package:my_vault/features/savings/domain/repositories/savings_repository.dart';
import 'package:my_vault/features/savings/domain/usecases/add_saving.dart';
import 'package:my_vault/features/savings/domain/usecases/get_savings.dart';

import '../../data/datasources/saving_local_datasource.dart';
import '../../data/models/saving_model.dart';
import '../../data/respositories/savings_repository_impl.dart';

final savingLocalDataSourceProvider = Provider<SavingsLocalDataSource>((ref) {
  final Box<SavingModel> bankBox = Hive.box(Constant.savings);
  return SavingsLocalDataSource(bankBox);
});

final savingRepositoryProvider = Provider<SavingsRepository>((ref) {
  final localDataSource = ref.read(savingLocalDataSourceProvider);
  return SavingsRepositoryImpl(localDataSource);
});

final getSavingsProvider = Provider<GetSavings>((ref) {
  final repository = ref.read(savingRepositoryProvider);
  return GetSavings(repository);
});

final addSavingProvider = Provider<AddSaving>((ref) {
  final repository = ref.read(savingRepositoryProvider);
  return AddSaving(repository);
});

// This provider will manage fetching savings from the repository.
final savingListNotifierProvider =
    StateNotifierProvider<SavingListNotifier, List<Saving>>((ref) {
  final getSavings = ref.read(getSavingsProvider);
  final addSaving = ref.read(addSavingProvider);

  return SavingListNotifier(getSavings, addSaving);
});

class SavingListNotifier extends StateNotifier<List<Saving>> {
  final GetSavings _getSavings;
  final AddSaving _addSaving;

  SavingListNotifier(this._getSavings, this._addSaving) : super([]);

  Future<dynamic> loadSavings() async {
    final savingsOrFailure = await _getSavings();
    savingsOrFailure.fold(
          (error) => state = [],
          (saving) => state = saving, // ✅ Update state here
    );
  }

  Future<void> addNewSaving(Saving saving) async {
    await _addSaving(saving);
  }
}
