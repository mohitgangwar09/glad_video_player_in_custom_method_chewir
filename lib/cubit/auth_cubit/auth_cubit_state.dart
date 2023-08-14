part of 'auth_cubit.dart';

enum AuthStatus{initial,submit,success,error}

class AuthCubitState extends Equatable{
  final AuthStatus status;
  final String token;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool passwordVisible,confirmVisible;

    const AuthCubitState({
      required this.status,
      required this.emailController,
      required this.token,
      required this.passwordController,
      required this.passwordVisible,
      required this.confirmVisible,
  });

  factory AuthCubitState.initial() {
    return AuthCubitState(
      status: AuthStatus.initial,
      emailController: TextEditingController(),
      token: '',
      passwordController: TextEditingController(),
      passwordVisible: true,
      confirmVisible: true,
    );
  }

  AuthCubitState copyWith({
    AuthStatus? status,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    String? token,
    bool? passwordVisible,confirmVisible
  }) {
    return AuthCubitState(
        status: status ?? this.status,
        emailController: emailController ?? this.emailController,
        token: token ?? this.token,
        passwordController: passwordController ?? this.passwordController,
        passwordVisible: passwordVisible ?? this.passwordVisible,
        confirmVisible: confirmVisible ?? this.confirmVisible,
    );
  }

  @override
  List<Object?> get props => [
    status,
    emailController,
    passwordController,
    token,
    passwordVisible,
    confirmVisible
  ];

}