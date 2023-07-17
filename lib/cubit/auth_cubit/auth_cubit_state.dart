part of 'auth_cubit.dart';

enum AuthStatus{initial,submit,success,error}

class AuthCubitState extends Equatable{
  final AuthStatus status;
  final TextEditingController emailController;

    const AuthCubitState({
      required this.status,
      required this.emailController,
  });

  factory AuthCubitState.initial() {
    return AuthCubitState(
      status: AuthStatus.initial,
      emailController: TextEditingController()
    );
  }

  AuthCubitState copyWith({
    AuthStatus? status,
    TextEditingController? emailController,
  }) {
    return AuthCubitState(
        status: status ?? this.status,
        emailController: emailController ?? this.emailController,
    );
  }

  @override
  List<Object?> get props => [
    status,
    emailController
  ];

}