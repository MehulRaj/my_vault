import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_vault/features/savings/core/constants.dart';
import 'package:my_vault/features/savings/data/respositories/withdraw_repository_impl.dart';

import '../../data/datasources/withdraw_local_datasource.dart';
import '../../data/models/withdraw_model.dart';
import '../../domain/entities/withdraw.dart';
import '../../domain/repositories/withdraw_repository.dart';
import '../../domain/usecases/add_withdraw.dart';
import '../../domain/usecases/get_withdraws.dart';

final withdrawLocalDataSourceProvider =
    Provider<WithdrawsLocalDataSource>((ref) {
  final Box<WithdrawModel> bankBox = Hive.box(Constant.withdraws);
  return WithdrawsLocalDataSource(bankBox);
});

final withdrawRepositoryProvider = Provider<WithdrawRepository>((ref) {
  final localDataSource = ref.read(withdrawLocalDataSourceProvider);
  return WithdrawRepositoryImpl(localDataSource);
});

final getWithdrawsProvider = Provider<GetWithdraws>((ref) {
  final repository = ref.read(withdrawRepositoryProvider);
  return GetWithdraws(repository);
});

final addWithdrawProvider = Provider<AddWithdraw>((ref) {
  final repository = ref.read(withdrawRepositoryProvider);
  return AddWithdraw(repository);
});

// This provider will manage fetching Withdraws from the repository.
final withdrawListNotifierProvider =
    StateNotifierProvider<WithdrawListNotifier, List<Withdraw>>((ref) {
  final getWithdraws = ref.read(getWithdrawsProvider);
  final addWithdraw = ref.read(addWithdrawProvider);

  return WithdrawListNotifier(getWithdraws, addWithdraw);
});

class WithdrawListNotifier extends StateNotifier<List<Withdraw>> {
  final GetWithdraws _getWithdraws;
  final AddWithdraw _addWithdraw;

  WithdrawListNotifier(this._getWithdraws, this._addWithdraw) : super([]);

  Future<void> loadWithdraws() async {
    final withdrawsOrFailure = await _getWithdraws();
    withdrawsOrFailure.fold(
        (error) => state = [], (withdraw) => state = withdraw);
  }

  Future<void> addNewWithdraw(Withdraw withdraw) async {
    await _addWithdraw(withdraw);
  }
}
