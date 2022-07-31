part of 'auth_cubit.dart';

enum AuthStatus { AUTHENTICATED, UNAUTHENTICATED, INITIAL, REFRESHING }

class AuthState extends Equatable {
  final AuthStatus status;
  final KronoxUserModel? userSession;

  const AuthState({
    required this.status,
    this.userSession,
  });

  AuthState copyWith({AuthStatus? status, KronoxUserModel? userSession}) {
    return AuthState(status: status ?? this.status, userSession: userSession ?? this.userSession);
  }

  @override
  List<Object?> get props => [status, userSession];
}
