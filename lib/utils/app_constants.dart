class AppConstants {
  // static const String baseUrl = 'https://develop-glad.staqo.com';
  // static const String baseUrl = 'http://staging-glad.staqo.com';
  static const String baseUrl = 'https://staging-glad.staqo.com';
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
  static const String userRatingApi = '/api/user/user-rating';
  static const String farmerDashboardApi = '/api/landing/dashboard';
  static const String farmerList = '/api/farmerlist';
  static const String farmerDetailsApi = '/api/farmer';
  static const String updateFarmerApi = '/api/farmer/update';
  static const String updateFarmApi = '/api/farm/update';
  static const String addTestimonialApi = '/api/testimonials';
  static const String milkProductionChart = '/api/last_six_month_data';
  static const String getDistrict = '/api/district/227';
  static const String countyListApi = '/api/address/countylist';
  static const String subCountyListApi = '/api/address/subcounty-list';
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
  static const String getMCCDashboard = '/api/milk-centers/mcc-dashboard';
  static const String getSupplierDashboard = '/api/supplier/supplier-dashboard';
  static const String enquiryListApi = '/api/enquiry-list';
  static const String enquiryDetailsApi = '/api/enquiry-details';
  static const String improvementAreaList = '/api/improvement/list';
  static const String improvementAreaUpdate = '/api/improvement/area-update';
  static const String enquiryClosedApi = '/api/dde/enquiry-closed';
  static const String ddeDashboardApi = '/api/dairy-executives/dde-dashboard';
  static const String farmerProjectListApi = '/api/farmer-project/list';
  static const String ddeProjectListApi = '/api/dairy-executives/project-list';
  static const String farmerProjectDetailApi = '/api/farmer-project/details';
  static const String farmerProjectMilestoneDetailApi = '/api/farmer-project/milestone-details';
  static const String farmerProjectMilestoneUpdateTaskApi = '/api/farmer-project/update-task';
  static const String farmerProjectMilestoneApproveApi = '/api/farmer-project/approve-milestone';
  static const String addInviteExpertForSurveyApi = '/api/farmer-project/add-invite-expert';
  // static const String updateProjectStatusApi = '/api/farmer-project/update-status';
  static const String validateCountry = '/api/address/check-country';
  static const String projectUOMListApi = '/api/farmer-project/project-uom-list';
  static const String resourceCapacityListApi = '/api/farmer-project/resource-capacity-list';
  static const String resourceNameListApi = '/api/farmer-project/resource-name-list';
  static const String resourceTypeListApi = '/api/farmer-project/resource-type-list';
  static const String updateKycDocument = '/api/farmer-project/kyc-document';
  static const String editKycDocument = '/api/farmer-project/kyc-document-update';
  static const String updateAttributeApi = '/api/farmer-project/add-attribute';
  static const String addAttributeApi = '/api/farmer-project/add-attribute';
  static const String priceAttributeApi = '/api/farmer-project/price-attribute';
  static const String deleteAttributeApi = '/api/farmer-project/delete-attribute';
  static const String ddeFarmerVisitorApi = '/api/dde/farmer-visitor';
  static const String notRequiredDataApi = '/api/farmer-project/fetch-not-required-data';
  static const String trainingListApi = '/api/training/list';
  static const String guestTrainingListApi = '/api/training/guest-training';
  static const String communityListApi = '/api/community/community-list';
  static const String communityDetailApi = '/api/community/community-detail';
  static const String guestCommunityDetailApi = '/api/community/guest-community-detail';
  static const String guestCommunityListApi = '/api/community/guest-community-list';
  static const String likeListApi = '/api/community/like-list';
  static const String guestLikeListApi = '/api/community/guest-like-list';
  static const String commentListApi = '/api/community/comment-list';
  static const String addCommentApi = '/api/community/comment';
  static const String guestCommentListApi = '/api/community/guest-comment-list';
  static const String addPostApi = '/api/community/store';
  static const String addLikeApi = '/api/community/like';
  static const String trainingCategoryApi = '/api/training/category';
  static const String guestTrainingCategoryApi = '/api/training/guest-category';
  static const String newsListApi = '/api/news-event/list';
  static const String newsCategoryApi = '/api/news-event/category';
  static const String trainingDetailApi = '/api/training/details';
  static const String projectKycDocumentsApi = '/api/farmer-project/project-kyc-document';
  static const String projectKycDocumentsUpdateApi = '/api/farmer-project/project-kyc-update';
  //mileStoneApi
  static const String mileStoneDeleteAp = '/api/farmer-project/milestone-delete';
  static const String mileStoneNameApi = '/api/farmer-project/milestone-name-list';
  static const String fetchMileStoneDataApi = '/api/farmer-project/fetch-milestone-data';
  static const String addTaskApi = '/api/farmer-project/add-task';
  static const String deleteTaskApi = '/api/farmer-project/delete-task';
  static const String addMilestoneApi = '/api/farmer-project/add-milestone';
  static const String farmerParticipationApi = '/api/farmer-project/farmer-participation-update';
  static const String accountStatementApi = '/api/financial/account-statement';
  static const String farmerParticipationStatusApi = '/api/financial/update-farmer-participation-status';
  static const String improvementAreaFilterListApi = '/api/improvement/improvementarea-list';
  static const String projectRatingApi = '/api/farmer-project/project-rating';
  static const String supplierKycDocumentApi = '/api/suppliers/supplier-kyc-document';
  static const String supplierKycDocumentUpdateApi = '/api/suppliers/supplier-kyc-document-update';

  //Livestock
  static const String livestockBreedApi = '/api/live-stock/cow-breed-list';
  static const String livestockAddApi = '/api/live-stock/add-live-stock';
  static const String myLivestockListApi = '/api/live-stock/my-livestock';
  static const String livestockListApi = '/api/live-stock/list';
  static const String livestockDetailApi = '/api/live-stock/cow-detail';
  static const String livestockUpdateApi = '/api/live-stock/update';
  static const String livestockAddToCartApi = '/api/live-stock/add-to-cart';
  static const String livestockCartListApi = '/api/live-stock/cart-list';
  static const String livestockUpdateCartItemQuantityApi = '/api/live-stock/update-to-cart';
  static const String livestockCartItemRemoveApi = '/api/live-stock/cart-delete';
  static const String teamMembersApi = '/api/supplier-team/team-member-list';
  static const String addTeamMembersApi = '/api/supplier-team/add-team-member';
  static const String updateTeamMembersApi = '/api/supplier-team/team-member-update';
  static const String updateSoldCowApi = '/api/live-stock/update-sold-cow';
  static const String emptyCartApi = '/api/live-stock/empty-cart';
  static const String removeLivestockApi = '/api/live-stock/remove-live-stock';
  static const String applyLivestockLoanApi = '/api/live-stock/apply-loan';
  static const String loanListApi = '/api/live-stock/loan-list';
  static const String livestockLoanStatusUpdateApi = '/api/live-stock/loan-status-update';
  static const String livestockDeliveryStatusApi = '/api/live-stock/delivery-status';
  static const String updateNegotiatedPriceApi = '/api/live-stock/update-negotiated-price';
  static const String notificationListApi = '/api/notification/list';



  static const String deleteMediaApi = '/api/delete-media';

  //////////////////////// sharedKey ////////////////////////
  static const String fcmToken = 'fcmToken';
  static const String weatherKey = '52a17d91b3ed0697b05a7dd6fdc708c4';
  static const String weatherApi = 'https://api.openweathermap.org/data/2.5/onecall';
  static const String token = 'token';
  static const String userId = 'userId';
  static const String userType = 'userType';
  static const String userName = 'userName';
  static const String userRoleId = 'userRoleId';
  static const String deviceImeiId = 'deviceImeiId';
  static const String countryCode = 'countryCode';
  static const String userRating = 'userR';
  static const String totalUserRating = 'totalUserR';

  static const Map languages = {'Swahili': 'Hujambo\nMimi Sam', 'English': 'Hi\nI\'m Sam'};
}
