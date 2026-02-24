import 'package:fpdart/fpdart.dart' show Left, Right;
import 'package:music_player/core/providers/current_user_notifier.dart';
import 'package:music_player/core/models/user_model.dart';
import 'package:music_player/features/Auth/repository/auth_local_repository.dart';
import 'package:music_player/features/Auth/repository/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> initSharedPrefrences() async {
    await _authLocalRepository.init();
  }

  Future<void> userSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.signUp(
      name: name,
      email: email,
      password: password,
    );

    // ignore: unused_local_variable
    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      Right(value: final r) => state = AsyncValue.data(r),
    };
  }

  Future<void> userSignIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.signIn(
      email: email,
      password: password,
    );

    // ignore: unused_local_variable
    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      Right(value: final r) => _signInSuccsess(r),
    };
  }

  AsyncValue<UserModel>? _signInSuccsess(UserModel user) {
    _authLocalRepository.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  Future<UserModel?> getData() async {
    state = const AsyncValue.loading();
    final token = _authLocalRepository.getToken();
    if (token != null) {
      final res = await _authRemoteRepository.getCurrentUserData(token);

      final val = switch (res) {
        Left(value: final l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
        Right(value: final r) => _getDataSuccess(r),
      };

      return val.value;
    }

    return null;
  }

  AsyncValue<UserModel> _getDataSuccess(UserModel user) {
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }
}
