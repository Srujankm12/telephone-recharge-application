class HttpRoutes {
  static const Map<String,String> jsonHeaders = {"Content-Type":"application/json"};
  static const String _url = "https://telephone.vithsutra.com";
  static const String login = "$_url/admin/user/login"; // Need to Remove the Admin in Route
  static const String deductAmount = "https://telephone.vithsutra.com/college/recharge";
}