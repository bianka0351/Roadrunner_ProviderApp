class AppEndpoints {
  static const String baseUrl = 'http://roadrunnergo.azurewebsites.net/api';
  static const String signIn =
      '$baseUrl/ProviderAccountService/AccountValidation';
  static const String profile =
      '$baseUrl/ProviderAccountService/GetProfile?Id=82e12922-4dbd-47cd-ad32-a110a84dd82c';
  static const String timeBlockRequests = '$baseUrl/timeBlockRequests';
  static const String createClients = '$baseUrl/ClientService/CreateClient?Id=82e12922-4dbd-47cd-ad32-a110a84dd82c';
  static const String ordersList = '$baseUrl/ordersList';
  static const String headerName = 'FROM';
  static const String headerValue = 'ProviderRR';
}
