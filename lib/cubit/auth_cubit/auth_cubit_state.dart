part of 'auth_cubit.dart';

enum AuthStatus{initial,submit,success,error}

class AuthCubitState extends Equatable{
  final AuthStatus status;
  final String token, validator,validatorString,id;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController otpController;
  final TextEditingController confirmPasswordController;
  final bool passwordVisible,confirmVisible;

    const AuthCubitState({
      required this.status,
      required this.id,
      required this.emailController,
      required this.confirmPasswordController,
      required this.otpController,
      required this.token,
      required this.validator,
      required this.validatorString,
      required this.passwordController,
      required this.passwordVisible,
      required this.confirmVisible,
  });

  factory AuthCubitState.initial() {
    return AuthCubitState(
      status: AuthStatus.initial,
      emailController: TextEditingController(),
      confirmPasswordController: TextEditingController(),
      otpController: TextEditingController(),
      token: '',
      validator: '',
      id: '',
      validatorString: '',
      passwordController: TextEditingController(),
      passwordVisible: true,
      confirmVisible: true,
    );
  }

  AuthCubitState copyWith({
    AuthStatus? status,
    TextEditingController? emailController,
    TextEditingController? otpController,
    TextEditingController? confirmPasswordController,
    TextEditingController? passwordController,
    String? token,validator,validatorString,id,
    bool? passwordVisible,confirmVisible
  }) {
    return AuthCubitState(
        status: status ?? this.status,
        id: id ?? this.id,
        emailController: emailController ?? this.emailController,
        confirmPasswordController: confirmPasswordController ?? this.confirmPasswordController,
        otpController: otpController ?? this.otpController,
        token: token ?? this.token,
        passwordController: passwordController ?? this.passwordController,
        passwordVisible: passwordVisible ?? this.passwordVisible,
        confirmVisible: confirmVisible ?? this.confirmVisible,
        validator: validator ?? this.validator,
        validatorString: validatorString ?? this.validatorString,
    );
  }

  @override
  List<Object?> get props => [
    status,
    emailController,
    passwordController,
    token,
    passwordVisible,
    confirmVisible,
    validator,
    validatorString,
    otpController,
    id
  ];

}