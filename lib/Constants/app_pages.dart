import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Modules/AboutModule/View%20Model/faqs_viewmodel.dart';
import 'package:partylux/Modules/AboutModule/View%20Model/support_viewmodel.dart';
import 'package:partylux/Modules/AboutModule/View/support_view.dart';
import 'package:partylux/Modules/AccountModule/View%20Model/accountviewmodel.dart';
import 'package:partylux/Modules/AccountModule/View/account_view.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/forgot_vm.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/login_vm.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/newpassword_vm.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/otp_vm.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/register_vm.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/splash_vm.dart';
import 'package:partylux/Modules/Auth%20Module/Views/forgot_view.dart';
import 'package:partylux/Modules/Auth%20Module/Views/login_sigup_view.dart';
import 'package:partylux/Modules/Auth%20Module/Views/newpassword_view.dart';
import 'package:partylux/Modules/Auth%20Module/Views/otp_view.dart';
import 'package:partylux/Modules/Auth%20Module/Views/splash_view.dart';
import 'package:partylux/Modules/Auth%20Module/Views/successfully_register_view.dart';
import 'package:partylux/Modules/BecomePartner/VIew/add_business_admission_fee.dart';
import 'package:partylux/Modules/BecomePartner/VIew/add_business_attendence.dart';
import 'package:partylux/Modules/BecomePartner/VIew/add_business_essentail.dart';
import 'package:partylux/Modules/BecomePartner/VIew/add_business_timing.dart';
import 'package:partylux/Modules/BecomePartner/VIew/add_bussines_createcard_view.dart';
import 'package:partylux/Modules/BecomePartner/VIew/add_bussines_multicards_view.dart';
import 'package:partylux/Modules/BecomePartner/VIew/become_mapview.dart';
import 'package:partylux/Modules/BecomePartner/VIew/successfully_created_business.dart';
import 'package:partylux/Modules/BecomePartner/View%20Model/becompartner_vm.dart';
import 'package:partylux/Modules/Club%20Module/View%20Model/club_viewmodel.dart';
import 'package:partylux/Modules/Club%20Module/View/club_view.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/google_map_vm.dart';
import 'package:partylux/Modules/Create%20Module/View/create10_multicards_view.dart';
import 'package:partylux/Modules/Create%20Module/View/create11_createcard_view.dart';
import 'package:partylux/Modules/Create%20Module/View/create2_sp_view.dart';
import 'package:partylux/Modules/Create%20Module/View/create3_images_view.dart';
import 'package:partylux/Modules/Create%20Module/View/create4_start_calander_view.dart';
import 'package:partylux/Modules/Create%20Module/View/create5_map_view.dart';
import 'package:partylux/Modules/Create%20Module/View/create5_select_location_view.dart';
import 'package:partylux/Modules/Create%20Module/View/create6_cancelpolicy_view.dart';
import 'package:partylux/Modules/Create%20Module/View/create7_admissionfee_view.dart';
import 'package:partylux/Modules/Create%20Module/View/create8_essential_view.dart';
import 'package:partylux/Modules/Create%20Module/View/create9_attendence_view%20copy.dart';
import 'package:partylux/Modules/Create%20Module/View/successfully_created_event%20copy.dart';
import 'package:partylux/Modules/Event%20Module/View%20Model/event_viewmodel.dart';
import 'package:partylux/Modules/Home%20Module/View%20Model/home_vm.dart';
import 'package:partylux/Modules/Image%20View/View/image_view.dart';
import 'package:partylux/Modules/Map%20Module/map_listing/view/map_listing_view.dart';
import 'package:partylux/Modules/Map%20Module/map_listing/view_model/map_listing_view_model.dart';
import 'package:partylux/Modules/Notification%20Setting/View%20Model/notification_setting_vm.dart';
import 'package:partylux/Modules/Search%20Module/View%20Model/home_search_vm.dart';
import 'package:partylux/Modules/Search%20Module/View%20Model/search_vm.dart';
import 'package:partylux/Modules/Search%20Module/View/all_recent_search_view.dart';
import 'package:partylux/Modules/Home%20Module/View/home_all_view.dart';
import 'package:partylux/Modules/Home%20Module/View/filter_home_viewall.dart';
import 'package:partylux/Modules/My%20Business/View%20Model/mybusiness_vm.dart';
import 'package:partylux/Modules/My%20Business/View/show_mybusiness_detail.dart';
import 'package:partylux/Modules/My%20Event%20Section/View%20Model/myevent_vm.dart';
import 'package:partylux/Modules/My%20Event%20Section/View/myevent_view.dart';
import 'package:partylux/Modules/NavRoot%20Module/View%20Model/nevroot_vm.dart';
import 'package:partylux/Modules/NavRoot%20Module/View/nevroot_view.dart';
import 'package:partylux/Modules/Notification%20Setting/View/notification_setting_view.dart';
import 'package:partylux/Modules/Notification/View%20Model/notification_vm.dart';
import 'package:partylux/Modules/Onboarding%20Module/View%20Model/onboarding_vm.dart';
import 'package:partylux/Modules/Onboarding%20Module/View/onboarding_view.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View%20Model/profile_vm.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View%20Model/update_profile_vm.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View/add_hob_intrest_view.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View/update_profile_view.dart';
import 'package:partylux/Modules/Search%20Module/View/all_result/home_search_result_tab_view.dart';
import 'package:partylux/Modules/Search%20Module/View/home_search_view.dart';
import 'package:partylux/Modules/TicketModule/View%20Model/ticker_viewmodel.dart';
import 'package:partylux/Modules/TicketModule/View/ticket_detail_view.dart';
import 'package:partylux/Modules/TicketModule/View/ticket_location.dart';
import 'package:partylux/Modules/WalletModule/View%20Model/wallets_viewmodel.dart';
import 'package:partylux/Modules/WalletModule/View/wallet_view.dart';
import 'package:partylux/Modules/add_location_picker/view/add_location_picker_view.dart';
import 'package:partylux/Modules/add_location_picker/view_model/add_location_picker_view_model.dart';
import 'package:partylux/Modules/bank_account_info/view/bank_account_info_view.dart';
import 'package:partylux/Modules/create_flyer/view/video_view.dart';
import 'package:partylux/Modules/create_party/create_my_party/view/create_party.dart';
import 'package:partylux/Modules/create_party/event_category_selection/view/event_category_selection.dart';
import 'package:partylux/Modules/create_party/event_category_selection/view_model/category_selection_view_model.dart';
import 'package:partylux/Modules/create_party/create_my_party/view_model/create_party_view_model.dart';
import 'package:partylux/Modules/create_party/create_party_prompt/view_model/party_prompt_view_model.dart';
import 'package:partylux/Modules/create_party/create_party_success/view/create_party_success_view.dart';
import 'package:partylux/Modules/create_party/create_party_success/view_model/create_party_success_view_model.dart';
import 'package:partylux/Modules/create_party/essentials/view/essentials_view.dart';
import 'package:partylux/Modules/create_party/essentials/view_model/essentials_view_model.dart';
import 'package:partylux/Modules/create_party/payment/view/payment_view.dart';
import 'package:partylux/Modules/create_party/payment/view_model/payment_view_model.dart';
import 'package:partylux/Modules/create_party/privacy/view/privacy_view.dart';
import 'package:partylux/Modules/create_party/privacy/view_model/privacy_view_model.dart';
import 'package:partylux/Modules/create_party/reminder/view/reminder_view.dart';
import 'package:partylux/Modules/create_party/reminder/view_model/reminder_view_model.dart';
import 'package:partylux/Modules/create_party/rsvps/view/rsvps_view.dart';
import 'package:partylux/Modules/create_party/rsvps/view_model/rsvps_view_model.dart';
import 'package:partylux/Modules/enable_location_services/view/enable_location_services_view.dart';
import 'package:partylux/Modules/enable_location_services/view_model/enable_location_services_view_model.dart';
import 'package:partylux/Modules/payment_module/add_card/view/add_card_view.dart';
import 'package:partylux/Modules/payment_module/add_card/view_model/add_card_view_model.dart';
import 'package:partylux/Modules/payment_module/payment_method/view/payment_method_view.dart';
import 'package:partylux/Modules/payment_module/payment_method/view_model/payment_method_viewmodel.dart';
import 'package:partylux/Modules/payment_module/stripe_connect/view/connect_view.dart';
import 'package:partylux/Modules/people_joined/people_joined_view.dart';
import 'package:partylux/Modules/people_joined/view_model/people_joined_view_model.dart';
import 'package:partylux/Modules/perticipant_module/participants_tab_view.dart';
import '../Modules/AboutModule/View/about_us_view.dart';
import '../Modules/AboutModule/View/custom_privacy_view.dart';
import '../Modules/AboutModule/View/faqs_view.dart';
import '../Modules/Auth Module/Views/successfully_profile_setup_view.dart';
import '../Modules/Auth Module/Views/user_business_sigup_view.dart';
import '../Modules/Barcode Scanner/View Model/barcode_viewmodel.dart';
import '../Modules/Barcode Scanner/View/barcode_scanner_view.dart';
import '../Modules/BecomePartner/VIew/add_bussines_detail_view.dart';
import '../Modules/BecomePartner/VIew/add_bussines_view.dart';
import '../Modules/BecomePartner/VIew/become_partner_view.dart';
import '../Modules/Create Module/View/successfully_update_event.dart';
import '../Modules/Home Module/View Model/home_all_vm.dart';
import '../Modules/Image View/View Model/image_view_viewmodel.dart';
import '../Modules/Location Radius Module/View Model/location_radius_vm.dart';
import '../Modules/Location Radius Module/View/location_radius_view.dart';
import '../Modules/My Business/View/my_business_view.dart';
import '../Modules/Notification/View/notification_view.dart';
import '../Modules/Profile Module/Profile Section/View/my_profile_view.dart';
import '../Modules/Success Screen/View/success_view.dart';
import '../Modules/TicketModule/View Model/ticker_detail_viewmodel.dart';
import '../Modules/TicketModule/View/ticket_view.dart';
import '../Modules/WalletModule/View/wallet_verification_view.dart';
import '../Modules/WalletModule/View/widthdraw_view.dart';
import '../Modules/bank_account_info/view_model/bank_account_info_vm.dart';
import '../Modules/create_business/view/create_business_view.dart';
import '../Modules/create_business/view_model/create_buisness_vm.dart';
import '../Modules/create_flyer/view/create_flyer_view.dart';
import '../Modules/create_flyer/view_model/create_flyer_vm.dart';
import '../Modules/create_flyer/view_model/video_vm.dart';
import '../Modules/create_party/create_party_prompt/view/create_party_prompt.dart';
import '../Modules/gender_ratios/gender_ratios_tab_view.dart';
import '../Modules/gender_ratios/view_model/gender_ratios_view_model.dart';
import '../Modules/perticipant_module/participants_detail_view.dart';
import '../Modules/perticipant_module/show_event_participants_view.dart';
import '../Modules/perticipant_module/view_model/participants_detail_view_model.dart';
import '../Modules/perticipant_module/view_model/participants_view_model.dart';
import '../Modules/reservation_success/view/reservation_success_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH_SCREEN,
      page: () => SplashView(),
      transition: Transition.leftToRight,
      binding: BindingsBuilder(
        () {
          Get.lazyPut<SplashViewModel>(
            () => SplashViewModel(),
          );

        },
      ),
    ),
    GetPage(
      name: AppRoutes.ON_BOARDING,
      page: () => OnboardingView(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(
        () {
          Get.lazyPut<OnboardingViewModel>(
            () => OnboardingViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.LoginSignUpView,
      page: () => LoginSignUpView(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(
        () {
          Get.lazyPut<LoginViewModel>(
            () => LoginViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.UserBusinessSignUpView,
      page: () => UserBusinessSignUpView(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(
        () {
          Get.lazyPut<RegisterViewModel>(
            () => RegisterViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.FORGOT,
      page: () => ForgotView(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(
        () {
          Get.lazyPut<ForgotViewModel>(
            () => ForgotViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.OTP,
      page: () => OTPView(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(
        () {
          Get.lazyPut<OTPViewModel>(
            () => OTPViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.NEW_PASSWORD,
      page: () => NewPasswordView(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(
        () {
          Get.lazyPut<NewPasswordViewModel>(
            () => NewPasswordViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.SUCCESSFULLY_REGISTER,
      page: () => SuccessfullyRegisterView(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.SUCCESSFULLY_SETUP_PROFILE,
      page: () => SuccessfullyProfileSetupView(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.NAV_ROOT,
      page: () => NavRootView(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(
        () {
          Get.lazyPut<NavRootViewModel>(
            () => NavRootViewModel(),
          );
          Get.lazyPut<ProfileViewModel>(
            () => ProfileViewModel(),
          );
          Get.lazyPut<HomeViewModel>(
            () => HomeViewModel(),
          );
          Get.lazyPut<CreateViewModel>(
            () => CreateViewModel(),
          );
          Get.lazyPut<PlacesSearchViewModel>(
            () => PlacesSearchViewModel(),
          );
          Get.lazyPut<EventViewModel>(
            () => EventViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(
        () {
          Get.lazyPut<UpdateProfileViewModel>(
            () => UpdateProfileViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.My_PROFILE,
      page: () => MyProfileView(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(
            () {
          Get.lazyPut<UpdateProfileViewModel>(
                () => UpdateProfileViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.HOBBIES_INTREST,
      page: () => HobbiesIntrestsView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.HOME_VIEWALL,
      page: () => HomeViewAllView(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(
            () {
          Get.lazyPut<HomeAllViewModel>(
                () => HomeAllViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.viewAllFilter,
      page: () => HomeViewAllFilterView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SELECTPOSTMODE,
      page: () => SelectPartyMode(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(
        () {
          Get.lazyPut<CreateViewModel>(
            () => CreateViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.SELECT_EVENT_GALLERY,
      page: () => SelectEventGallery(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SELECT_START_DATE_TIME,
      page: () => SelectStartDateAndTime(),
      transition: Transition.rightToLeft,
    ),
    // GetPage(
    //   name: AppRoutes.SELECT_END_DATE_TIME,
    //   page: () => SelectEndDateAndTime(),
    //   transition: Transition.rightToLeft,
    // ),

    GetPage(
      name: AppRoutes.SELECT_LOCATION,
      page: () => SelectLocation(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SELECT_LOCATION_ON_MAP,
      page: () => SelectLocationOnMap(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SELECT_CANCEL_POLICY,
      page: () => SelectCancelationPolicies(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SELECT_ADMISSION_FEE,
      page: () => SelectAdmissionFee(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SELECT_PARTY_ESSENTIAL,
      page: () => SelectPartyEssential(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SELECT_PARTY_ATTENDANCE,
      page: () => SelectPartyAttendance(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.successfullyCreatedEvent,
      page: () => SuccessfullyCreatedEvent(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.successfullyUpdatedEvent,
      page: () => SuccessfullyUpdatedEvent(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.partyMulitCard,
      page: () => SelectPartyMultiCard(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.partyCreatedCard,
      page: () => SelectPartyCreateCard(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.myEvent,
      page: () => MyEventView(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(
        () {
          Get.lazyPut<MyEventViewModel>(
            () => MyEventViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.customPrivacyView,
      transition: Transition.rightToLeft,
      page: () => CustomPrivacyView(),
    ),
    GetPage(
      name: AppRoutes.faqsView,
      transition: Transition.rightToLeft,
      page: () => FaqsView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<FAQsViewModel>(
            () => FAQsViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.supportView,
      transition: Transition.rightToLeft,
      page: () => SupportView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<SupportViewModel>(
            () => SupportViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.accountView,
      transition: Transition.rightToLeft,
      page: () => AccountView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<AccountViewModel>(
            () => AccountViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.notificationView,
      transition: Transition.rightToLeft,
      page: () => NotificationView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<NotificationViewModel>(
            () => NotificationViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.walletView,
      transition: Transition.rightToLeft,
      page: () => WalletView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<WalletViewModel>(
            () => WalletViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.paymentMethodView,
      transition: Transition.rightToLeft,
      page: () => PaymentMethodView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<PaymentMethodViewModel>(
                () => PaymentMethodViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.addCardView,
      transition: Transition.rightToLeft,
      page: () => AddCardView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<AddCardViewModel>(
                () => AddCardViewModel(),
          );
        },
      ),
    ),
/*    GetPage(
      name: AppRoutes.connectView,
      transition: Transition.rightToLeft,
      page: () => ConnectView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<ConnectViewModel>(
                () => ConnectViewModel(),
          );
        },
      ),
    ),*/
    GetPage(
      name: AppRoutes.aboutView,
      transition: Transition.rightToLeft,
      page: () => AboutView(),
    ),
    GetPage(
      name: AppRoutes.ticketView,
      transition: Transition.rightToLeft,
      page: () => TicketView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<TicketViewModel>(
            () => TicketViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.ticketDetailView,
      transition: Transition.rightToLeft,
      page: () => TicketDetailView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<TicketDetailViewModel>(
                () => TicketDetailViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.ticketLocationView,
      transition: Transition.rightToLeft,
      page: () => TicketLocationView(),
    ),

    GetPage(
      name: AppRoutes.becomeAPartnerView,
      transition: Transition.rightToLeft,
      page: () => BecomeAPartnerView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<BecomePartnerViewModel>(
            () => BecomePartnerViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.successfullyCreatedBusiness,
      transition: Transition.rightToLeft,
      page: () => SuccessfullyCreatedBusiness(),
    ),
    GetPage(
      name: AppRoutes.locationRadius,
      transition: Transition.rightToLeft,
      page: () => LocationRadiusView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<LocationRadiusViewModel>(
            () => LocationRadiusViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.successView,
      transition: Transition.rightToLeft,
      page: () => SuccessView(),
    ),

    GetPage(
      name: AppRoutes.createFlyer,
      transition: Transition.rightToLeft,
      page: () => CreateFlyerView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<CreateFlyerViewModel>(
            () => CreateFlyerViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.videoVideo,
      transition: Transition.rightToLeft,
      page: () => VideoView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<VideoModel>(
                () => VideoModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.barcodeScanner,
      transition: Transition.rightToLeft,
      page: () => BarcodeScannerView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<BarcodeViewModel>(
                () => BarcodeViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.notificationSetting,
      transition: Transition.rightToLeft,
      page: () => NotificationSettingView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<NotificationSettingViewModel>(
                () => NotificationSettingViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.addBussinesView,
      transition: Transition.rightToLeft,
      page: () => AddBussinesView(),
    ),

    GetPage(
      name: AppRoutes.addBusinessTiming,
      transition: Transition.rightToLeft,
      page: () => AddBusinessTiming(),
    ),

    GetPage(
      name: AppRoutes.addBusinessAdmissionFee,
      transition: Transition.rightToLeft,
      page: () => AddBusinessAdmissionFee(),
    ),

    GetPage(
      name: AppRoutes.addBusinessEssentails,
      transition: Transition.rightToLeft,
      page: () => AddBusinessEssentails(),
    ),
    GetPage(
      name: AppRoutes.addBusinessAttendence,
      transition: Transition.rightToLeft,
      page: () => AddBusinessAttendence(),
    ),

    GetPage(
      name: AppRoutes.addBusinessMultiCard,
      transition: Transition.rightToLeft,
      page: () => AddBusinessMultiCard(),
    ),

    GetPage(
      name: AppRoutes.myBusinessView,
      transition: Transition.rightToLeft,
      page: () => MyBusinessView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<MyBusinessVM>(
            () => MyBusinessVM(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.imageView,
      transition: Transition.rightToLeft,
      page: () => ImageView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<ImageViewModel>(
                () => ImageViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.clubView,
      transition: Transition.rightToLeft,
      page: () => ClubView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<ClubViewModel>(
            () => ClubViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.showMyBusiness,
      transition: Transition.rightToLeft,
      page: () => ShowMyBusinessDetail(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<MyBusinessVM>(
            () => MyBusinessVM(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.addBusinessCreateCard,
      transition: Transition.rightToLeft,
      page: () => AddBusinessCreateCard(),
    ),

    GetPage(
      name: AppRoutes.becomePartnerMapView,
      transition: Transition.rightToLeft,
      page: () => BecomePartnerMapView(),
    ),


    GetPage(
      name: AppRoutes.createBusiness,
      transition: Transition.rightToLeft,
      page: () => CreateBusinessView(""),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<CreateBusinessViewModel>(
                () => CreateBusinessViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.addBussinesDetailView,
      transition: Transition.rightToLeft,
      page: () => AddBussinesDetailView(),
    ),
    GetPage(
      name: AppRoutes.withdrawView,
      transition: Transition.rightToLeft,
      page: () => WithdrawView(),
    ),
    GetPage(
      name: AppRoutes.walletVerficationView,
      transition: Transition.rightToLeft,
      page: () => WalletVerficationView(),
    ),

    GetPage(
      name: AppRoutes.showEventParticipantsView,
      transition: Transition.rightToLeft,
      page: () => ShowEventParticipantsView(),
    ),
    GetPage(
      name: AppRoutes.participantsTab,
      transition: Transition.rightToLeft,
      page: () => ParticipantsTabView(),
        binding: BindingsBuilder(
              () {
            Get.lazyPut<ParticipantsViewModel>(
                  () => ParticipantsViewModel(),
            );
          },
        ),
    ),

    GetPage(
      name: AppRoutes.reservationSuccess,
      transition: Transition.rightToLeft,
      page: () => ReservationSuccessView(),
    ),

    GetPage(
      name: AppRoutes.participantsDetailView,
      transition: Transition.rightToLeft,
      page: () => ParticipantsDetailView(),
        binding: BindingsBuilder(
              () {
            Get.put<ParticipantsDetailViewModel>(ParticipantsDetailViewModel(),);
          },
        ),


    ),

    GetPage(
      name: AppRoutes.createPartyPrompt,
      transition: Transition.rightToLeft,
      page: () => CreatePartyPrompt(),
      binding: BindingsBuilder(
            () {
          Get.put<PartyPromptViewModel>(PartyPromptViewModel(),);
        },
      ),
    ),

    GetPage(
      name: AppRoutes.createParty,
      transition: Transition.rightToLeft,
      page: () => CreatePartyView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<CreatePartyViewModel>(
                () => CreatePartyViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.createCategoryParty,
      transition: Transition.rightToLeft,
      page: () => EventCategorySelection(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<CategorySelectionViewModel>(
                () => CategorySelectionViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.HOME_SEARCH,
      binding: BindingsBuilder(
            () {
          Get.lazyPut<SearchViewModel>(
                () => SearchViewModel(),
          );
        },
      ),
      page: () => HomeSearchView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ALL_RECENT_SEARCHES,
      page: () => AllRecentSearchView(),
      transition: Transition.rightToLeft,
    ),
/*    GetPage(
      name: AppRoutes.HOME_SEARCH_RESULT,
      page: () => HomeSearchResultView(),
      transition: Transition.rightToLeft,
    ),*/
    GetPage(
      name: AppRoutes.HOME_SEARCH_RESULT_TAB_VIEW,
      page: () => HomeSearchResultTabView(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(
            () {
          Get.lazyPut<HomeSearchViewModel>(
                () => HomeSearchViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.createPartyRsvps,
      transition: Transition.rightToLeft,
      page: () => RsvpsView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<RsvpsViewModel>(
            () => RsvpsViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.createPartyReminder,
      transition: Transition.rightToLeft,
      page: () => ReminderView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<ReminderViewModel>(
            () => ReminderViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.createPartyPrivacy,
      transition: Transition.rightToLeft,
      page: () => PrivacyView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<PrivacyViewModel>(
            () => PrivacyViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.createPartyPayment,
      transition: Transition.rightToLeft,
      page: () => PaymentView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<PaymentViewModel>(
            () => PaymentViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.createPartyEssentials,
      transition: Transition.rightToLeft,
      page: () => EssentialsView(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<EssentialsViewModel>(
            () => EssentialsViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.createPartySuccess,
      transition: Transition.rightToLeft,
      page: () => CreatePartySuccessView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<CreatePartySuccessViewModel>(
                () => CreatePartySuccessViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.enableLocationServices,
      transition: Transition.rightToLeft,
      page: () => EnableLocatonServicesView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<EnableLocationServicesViewModel>(
                () => EnableLocationServicesViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.addLocationPicker,
      transition: Transition.rightToLeft,
      page: () => AddLocationPickerView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<AddLocationPickerViewModel>(
                () => AddLocationPickerViewModel(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.mapListingView,
      transition: Transition.rightToLeft,
      page: () => MapListingView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<MapListingViewModel>(
                () => MapListingViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.genderRatiosTab,
      transition: Transition.rightToLeft,
      page: () => GenderRatiosTabView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<GenderRatiosViewModel>(
                () => GenderRatiosViewModel(),
          );
        },
      ),
    ),

    GetPage(
      name: AppRoutes.peopleJoinedView,
      transition: Transition.rightToLeft,
      page: () => PeopleJoinedView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<PeopleJoinedViewModel>(
                () => PeopleJoinedViewModel(),
          );
        },
      ),
    ),
    //


    GetPage(
      name: AppRoutes.bankInfoView,
      transition: Transition.rightToLeft,
      page: () => BankAccountInfoView(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<BankAccountInfoViewModel>(
                () => BankAccountInfoViewModel(),
          );
        },
      ),
    ),
  ];
}
