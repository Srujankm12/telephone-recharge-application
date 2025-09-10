class HttpRoutes {
  static const Map<String, String> jsonHeaders = {
    "Content-Type": "application/json",
  };
  static const String _url = "https://telephone.vithsutra.com";
  static const String login = "$_url/user/login";
  static const String deductAmount = "$_url/admin/recharge/student";
  static const String balance = "$_url/";
  static const String rechargeHistory = "$_url/user/recharge/student/history";
}
