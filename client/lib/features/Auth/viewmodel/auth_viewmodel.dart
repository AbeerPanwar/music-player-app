import 'package:fpdart/fpdart.dart' show Left, Right;
import 'package:music_player/features/Auth/model/user_model.dart';
import 'package:music_player/features/Auth/repository/auth_local_repository.dart';
import 'package:music_player/features/Auth/repository/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
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

    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
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

    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      Right(value: final r) => _signInSuccsess(r),
    };
    print(val);
  }

  AsyncValue<UserModel>? _signInSuccsess(UserModel user){
    _authLocalRepository.setToken(user.token);
    return state = AsyncValue.data(user);
  }
}
