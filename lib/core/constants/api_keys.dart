class ApiKeys {
  static const baseUrl =
      "https://erp30mobile.manticapps.com/api/customerPortal";
  static const loginUrl = "$baseUrl/Auth/Login";
  static const verifyOtp = "$baseUrl/Auth/VerifyOTP";
  static const getlocations = "$baseUrl/Location/GetList";
  static const registerUser = "$baseUrl/Auth/InsertOrUpdate";
  static const getCompaniesList = "$baseUrl/Company/GetList";
  static const getCompanyProductsList = "$baseUrl/Product/GetList";
  static const getLastOrder = "$baseUrl/Order/GetLastOrder";
  static const getAllOrders = "$baseUrl/Order/GetList";
  static const createOrder = "$baseUrl/Order/InsertOrUpdate";
}
