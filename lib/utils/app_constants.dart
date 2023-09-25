class AppConstants {
  static const String baseUrl = 'https://develop-glad.staqo.com';
  static const String gMapsApiKey = 'AIzaSyAJg4PGbl1XfwJFKo-vQWlUVtH1Zzg3FEQ';


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
  static const String milkProductionChart = '/api/last_six_month_data';
  static const String getDistrict = '/api/district/227';
  static const String getBreedListApi = '/api/breed';
  static const String getCowBreedDetailApi = '/api/cow_breed_details';
  static const String updateCowBreedDetailApi = '/api/cow_breed_details_update';
  static const String addMonthApi = '/api/farmer/add-month';
  static const String deleteMonthApi = '/api/farmer/delete-month';
  static const String updateCowBreedDetail = '/api/cow_breed_details_update';
  static const String inviteExpertDetails= '/api/add-enquiry';
  static const String followupRemarkList = '/api/followup-remark-list';
  static const String addFollowupRemark = '/api/add-followup-remark';
  static const String getGuestDashboard = '/api/guest-user-dashboard';
  static const String enquiryListApi = '/api/enquiry-list';
  static const String enquiryDetailsApi = '/api/enquiry-details';
  static const String improvementAreaList = '/api/improvement/list';
  static const String improvementAreaUpdate = '/api/improvement/area-update';
  static const String enquiryClosedApi = '/api/dde/enquiry-closed';
  static const String ddeDashboardApi = '/api/dairy-executives/dde-dashboard';

  //////////////////////// sharedKey ////////////////////////
  static const String fcmToken = 'fcmToken';
  static const String token = 'token';
  static const String userId = 'userId';
  static const String userType = 'userType';
  static const String deviceImeiId = 'deviceImeiId';

  static const Map languages = {'Swahili': 'Hujambo\nMimi Sam', 'English': 'Hi\nI\'m Sam'};
}
