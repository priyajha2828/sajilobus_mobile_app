
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider/auth_provider.dart';
import '../../resources/color/custom_color.dart';
import '../../resources/text_field/custom_textfield.dart';
import '../../routes/app_route.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Consumer<AuthProvider>(
      builder: (context, provider, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: topPadding + 24,
                      bottom: 12,
                      left: 24,
                      right: 24,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: CustomColor.logincontainer(context),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 256,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/loginlogo.png",
                                        ),
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: Text(
                                  'Signup  to Continue',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColor.tileTextPrimary(context),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomColor.tileTextPrimary(context),
                                    ),
                                  ),
                                  const Text(
                                    "*",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextFromFieldWithPrefixSuffix(
                                controller: provider.emailController,
                                hintText: "Enter your Name",
                                borderRadius: 4.0,
                                applyPrefix: false,
                                keyboardType: TextInputType.emailAddress,
                                enabledBorderColor: provider.emailError == null
                                    ? const Color(0xFF0091EA)
                                    : Colors.red.shade800,
                                focusedBorderColor: provider.emailError == null
                                    ? const Color(0xFF0091EA)
                                    : Colors.red.shade800,
                                errorBorderColor: Colors.red,
                                validator: (value) => null,
                                obscureText: true,
                              ),
                              if (provider.emailError != null) ...[
                                const SizedBox(height: 6),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        provider.emailError!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomColor.tileTextPrimary(context),
                                    ),
                                  ),
                                  const Text(
                                    "*",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextFromFieldWithPrefixSuffix(
                                controller: provider.emailController,
                                hintText: "Enter your email",
                                borderRadius: 4.0,
                                applyPrefix: false,
                                keyboardType: TextInputType.emailAddress,
                                enabledBorderColor: provider.emailError == null
                                    ? const Color(0xFF0091EA)
                                    : Colors.red.shade800,
                                focusedBorderColor: provider.emailError == null
                                    ? const Color(0xFF0091EA)
                                    : Colors.red.shade800,
                                errorBorderColor: Colors.red,
                                validator: (value) => null,
                                obscureText: true,
                              ),
                              if (provider.emailError != null) ...[
                                const SizedBox(height: 6),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        provider.emailError!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  Text(
                                    "Contact No",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomColor.tileTextPrimary(context),
                                    ),
                                  ),
                                  const Text(
                                    "*",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextFromFieldWithPrefixSuffix(
                                controller: provider.emailController,
                                hintText: "Enter your phone Number",
                                borderRadius: 4.0,
                                applyPrefix: false,
                                keyboardType: TextInputType.emailAddress,
                                enabledBorderColor: provider.emailError == null
                                    ? const Color(0xFF0091EA)
                                    : Colors.red.shade800,
                                focusedBorderColor: provider.emailError == null
                                    ? const Color(0xFF0091EA)
                                    : Colors.red.shade800,
                                errorBorderColor: Colors.red,
                                validator: (value) => null,
                                obscureText: true,
                              ),
                              if (provider.emailError != null) ...[
                                const SizedBox(height: 6),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        provider.emailError!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomColor.tileTextPrimary(context),
                                    ),
                                  ),
                                  const Text(
                                    "*",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextFromFieldWithPrefixSuffix(
                                controller: provider.emailController,
                                hintText: "Enter your password",
                                borderRadius: 4.0,
                                applyPrefix: false,
                                keyboardType: TextInputType.emailAddress,
                                enabledBorderColor: provider.emailError == null
                                    ? const Color(0xFF0091EA)
                                    : Colors.red.shade800,
                                focusedBorderColor: provider.emailError == null
                                    ? const Color(0xFF0091EA)
                                    : Colors.red.shade800,
                                errorBorderColor: Colors.red,
                                validator: (value) => null,
                                obscureText: true,
                              ),
                              if (provider.emailError != null) ...[
                                const SizedBox(height: 6),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        provider.emailError!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () => provider.toggleRememberMe(null),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        value: provider.rememberMe,
                                        onChanged: (val) => provider.toggleRememberMe(val),
                                        activeColor: const Color(0xFF0091EA),
                                        side: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Remember me",
                                      style: TextStyle(
                                        color: CustomColor.tileTextPrimary(context),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      Icons.info,
                                      color: CustomColor.textPrimary(context),
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                              ElevatedButton(
                                onPressed: provider.isLoading
                                    ? null
                                    : () => provider.login(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0091EA),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 48),
                                  disabledBackgroundColor: const Color(0xFF0091EA).withOpacity(0.6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  elevation: 0,
                                ),
                                child: provider.isLoading
                                    ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                    : const Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, AppRoute.loginpage);
                                  },
                                  child:Center(
                                    child: Text(
                                        "Back to Login",
                                        style:TextStyle(
                                            color: CustomColor.textPrimary(context),
                                            fontWeight: FontWeight.w500
                                        )

                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}