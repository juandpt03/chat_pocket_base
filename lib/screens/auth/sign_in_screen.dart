import 'package:chat_pocket_base/core/extensions/navigator_extension.dart';
import 'package:chat_pocket_base/models/models.dart';
import 'package:chat_pocket_base/providers/providers.dart';
import 'package:chat_pocket_base/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = '/sign-in';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Image.network(
                    "https://i.postimg.cc/nz0YBQcH/Logo-light.png",
                    height: 100,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Text(
                    "Sign In",
                    style: textStyle.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  const _Form(),
                ],
              ),
            );
          },
        ),
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

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onChanged: ref.read(signInProvider.notifier).onEmailChanged,
          ),
          const SizedBox(height: 16.0),
          CustomTextFormField(
            hintText: 'Password',
            obscureText: true,
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
            onChanged: ref.read(signInProvider.notifier).onPasswordChanged,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CustomFilledButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;

                await ref.read(authProvider.notifier).signIn().then((response) {
                  if (!context.mounted) return;
                  CustomSnackBar.showSnackBar(
                    context: context,
                    message: response.message,
                    success: response.success,
                  );
                });
              },
              text: "Sign In",
            ),
          ),
          CustomTextButton(
            onPressed: () {
              context.push(SignUpScreen.routeName);
            },
            child: Text.rich(
              const TextSpan(
                text: "Don’t have an account? ",
                children: [
                  TextSpan(
                    text: "Sign Up",
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
