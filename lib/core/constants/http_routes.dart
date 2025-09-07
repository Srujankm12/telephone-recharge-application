class HttpRoutes {
  static const Map<String,String> jsonHeaders = {"Content-Type":"application/json"};
  static const String _url = "https://telephone.vithsutra.com";
  static const String login = "$_url/admin/user/login"; // Need to Remove the Admin in Route
  static const String deductAmount = "$_url/admin/recharge/student";
  static const String balance = "$_url/";
  static const String rechargeHistory = "$_url/admin/recharge/student/history";
}