import "package:flutter/material.dart";
import "package:telephone_recharge_application/core/route/generated_routes.dart";
import "package:telephone_recharge_application/core/theme/app_theme.dart";
import "package:telephone_recharge_application/init_dependencies.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const TelephoneRechargeApplication());
}

class TelephoneRechargeApplication extends StatelessWidget {
  const TelephoneRechargeApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Telephone Recharge Application",
      theme: AppTheme.theme,
      darkTheme: AppTheme.theme,
      onGenerateRoute: GeneratedRoutes.onGenerate,
      initialRoute: "/balance",
    );
  }
}
