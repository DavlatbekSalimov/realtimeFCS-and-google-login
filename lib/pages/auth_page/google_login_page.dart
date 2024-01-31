import 'package:flutter/material.dart';
import 'package:realtime_fcs/firebase_service/auth_service.dart';

class GoogleLoginPage extends StatefulWidget {
  const GoogleLoginPage({super.key});

  @override
  State<GoogleLoginPage> createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: IconButton(
              onPressed: () async {
                await AuthService.googlLogin(context);
              },
              icon: const Icon(Icons.g_mobiledata),
            ),
          )
        ],
      ),
    );
  }
}
