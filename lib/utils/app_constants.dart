class AppConstants {
  static const String baseUrl = 'https://develop-glad.staqo.com';


  // api End Point
  static const String loginWithPasswordApi = '/api/login';
  static const String loginWithMobileApi = '/api/generate-otp';
  static const String verifyMobileApi = '/api/login-otp';
  static const String createPasswordPasswordApi = '/api/create/password';
  static const String verifyOtpApi = '/api/validate/otp';
  static const String resendOtpApi = '/api/resend-otp';
  static const String forgotPasswordApi = '/api/password/reset';
  static const String updateProfileImageAPi = '/api/profile-pic';
  static const String profileApi = '/api/profile';
  static const String farmerDashboardApi = '/api/landing/dashboard';
  static const String farmerList = '/api/farmerlist';
  static const String farmerDetailsApi = '/api/farmer';
  static const String updateFarmerApi = '/api/farmer/update';
  static const String updateFarmApi = '/api/farm/update';
  static const String addTestimonialApi = '/api/testimonials';
  static const String getBreedList = '/api/breed';
  static const String getCowBreedDetailApi = '/api/cow_breed_details';
  static const String updateCowBreedDetail = '/api/cow_breed_details_update';

  //////////////////////// sharedKey ////////////////////////
  static const String fcmToken = 'fcmToken';
  static const String token = 'token';
  static const String userId = 'userId';
  static const String userType = 'userType';

  static const Map languages = {'Swahili': 'Hujambo\nMimi Sam', 'English': 'Hi\nI\'m Sam'};
}
