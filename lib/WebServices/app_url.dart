class AppUrl {
 //local
  //static const String baseUrl = 'http://35.154.123.59';
 //static const String baseUrl = 'http://192.168.1.43:7273';


 //live

 static const String baseUrl = 'https://ablagro.in';


  static const String sendOtp = '$baseUrl/api/driver/login';
  static const String verifyOtp = '$baseUrl/api/driver/verifyOtp';
  static const String driverRegister = '$baseUrl/api/driver/register';
  static const String getProfile = '$baseUrl/api/driver/profile';
  static const String homeHeder = '$baseUrl/api/driver/home';
  static const String newOrder = '$baseUrl/api/driver/orders';
  static const String activeStatus = '$baseUrl/api/driver/status';
  static const String acceptStatus = '$baseUrl/api/driver/order';
  static const String orderHistoryDetails = '$baseUrl/api/driver/order';
  static const String sos = '$baseUrl/api/driver/query';
  static const String getCms = '$baseUrl/api/driver/cms';
  static const String postWallet = '$baseUrl/api/driver/wallet/request';
  static const String Wallet = '$baseUrl/api/driver/wallet';
  static const String profileUpdate = '$baseUrl/api/driver/profile';
 static const String notification = '$baseUrl/api/driver/notifications';
 static const String notificationRead = '$baseUrl/api/driver/notifications/read';
 static const String appVersion = '$baseUrl/api/driver/check-update';


}
