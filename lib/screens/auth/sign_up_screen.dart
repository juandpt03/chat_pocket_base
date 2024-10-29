import 'package:chat_pocket_base/core/core.dart';
import 'package:chat_pocket_base/providers/providers.dart';
import 'package:chat_pocket_base/screens/screens.dart';
import 'package:chat_pocket_base/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/sign_up';

  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.08),
                Image.network(
                  "https://i.postimg.cc/nz0YBQcH/Logo-light.png",
                  height: 100,
                ),
                SizedBox(height: constraints.maxHeight * 0.08),
                Text(
                  "Sign Up",
                  style: textStyle.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                const _Form(),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form();

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final signUpState = ref.watch(signUpProvider);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
            hintText: 'Username',
            onChanged: ref.read(signUpProvider.notifier).onUsernameChanged,
          ),
          const SizedBox(height: 16.0),
          CustomTextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }

              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            hintText: 'Email',
            onChanged: ref.read(signUpProvider.notifier).onEmailChanged,
          ),
          const SizedBox(height: 16.0),
          CustomTextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                  .hasMatch(value)) {
                return 'Password must contain at least 8 characters, including UPPER/lowercase and numbers';
              }

              return null;
            },
            hintText: 'Password',
            onChanged: ref.read(signUpProvider.notifier).onPasswordChanged,
          ),
          const SizedBox(height: 16.0),
          CustomTextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password again';
              }
              if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                  .hasMatch(value)) {
                return 'Password must contain at least 8 characters, including UPPER/lowercase and numbers';
              }
              if (signUpState.user.password != value) {
                return 'Passwords do not match';
              }
              return null;
            },
            hintText: 'Confirm Password',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CustomFilledButton(
              onPressed: signUpState.isPosting
                  ? null
                  : () async {
                      if (!_formKey.currentState!.validate()) return;
                      await ref
                          .read(authProvider.notifier)
                          .signUp()
                          .then((response) {
                        if (!context.mounted) return;
                        context.pushRemove(
                            SignInScreen.routeName, (route) => false);
                        CustomSnackBar.showSnackBar(
                            context: context, message: response.message);
                      });
                    },
              text: "Sign Up",
            ),
          ),
          CustomTextButton(
            onPressed: () {
              context.pushRemove(SignInScreen.routeName, (route) => false);
            },
            child: Text.rich(
              const TextSpan(
                text: "Already have an account? ",
                children: [
                  TextSpan(
                    text: "Sign in",
                    style: TextStyle(color: Color(0xFF00BF6D)),
                  ),
                ],
              ),
              style: textStyle.bodyMedium?.copyWith(
                color: colors.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
