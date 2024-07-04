class AppNetworkUrls {
  static const _baseUrl = 'https://mmfinfotech.co/machine_test/api';//live
  static get baseUrl => _baseUrl;

  static const loginEndPint = '$_baseUrl/userLogin';
  static const profileUpdateEndPint = '$_baseUrl/profileUpdate';
  static const userRegisterEndPint = '$_baseUrl/userRegister';
}
