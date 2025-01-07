// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:partylux/Constants/app_constants.dart';

class ApiManager {
// App Base URL
  static String BASE_URL = AppConstants.baseURL;

//Auth Module Endpoints
  static const SIGNUP = "mobile/auth/signup";

  static const REGISTER_BUSINESS = "mobile/auth/registerBusiness";

  static const LOGIN = "mobile/auth/signin";

  static const SOCIALLOGIN = "mobile/auth/socialLogin";

  static const CURRENT_USER = "mobile/users/me";

  static const VARIFY = "mobile/auth/verify-otp";

  static const RESEND = "mobile/auth/resend-otp";

  static const FORGOT = "mobile/auth/forget-password";

  static const RESET_PASSWORD = "mobile/auth/reset-password";

  static const CREATE_PROFILE = "mobile/users/create-profile";

  static const UPLOAD_PHOTO = "mobile/users/upload-photo";

  static const UPLOAD_VIDEO = "mobile/users/upload-video";

  static const UPLOAD_MULTI_PHOTO = "mobile/users/upload-multiple-photo";

  static const CREATE_EVENT = "mobile/event/create-event";

  static const CREATE_FLYER ="mobile/business/create-flyer";

  static const UPDATE_EVENT = "mobile/event/update-event";

  static const ADD_EVENT_VIP_CARD = "mobile/card/create-cards";

  static const ADD_CARD = "mobile/user-card";

  static const PROCESS_PAYMENT = "mobile/payment/process";

  static const ADD_CONNECT_ACCOUNT = "mobile/payment/create-account";

  static const UPDATE_CONNECT_ACCOUNT = "mobile/payment/update-account-id";

  //Events
  static const GET_EVENTS = "mobile/event/event-list?";

  static const GET_USER_PROFILE = "mobile/users/profile";

  static const GET_RECENT_SEARCHES = "mobile/users/get-recent-search";
  static const DELETE_RECENT_SEARCHES ="mobile/users/delete-search-record";
  static const CLEAR_RECENT_SEARCHES ="mobile/users/clear-search-record";

  // static const FORGOT = "mobile/auth/forget-password";

  // Update Profile
  static const UPDATE_PROFILE_HIDE_SHOW = "mobile/users/update-profile";

  //event subscribe
  static const EVENT_SUBSCRIBE = "mobile/event/";

  static const GET_EVENT_DETAIL = "mobile/event/event-details";

  // Event Section My Events, My Reservation and My History

  static const GET_MY_EVENT = "mobile/event/my-events-history?limit=20&";

  // static const GET_MY_EVENT = "mobile/event/event-list?limit=20&page=1";

  static const GET_MY_RESERVATION = "mobile/event/my-reserve-events?limit=20&";

  static const GET_BUSINESS = "mobile/business/business-list?limit=20&";

  static const GET_BUSINESS_LIMITED = "mobile/business/business-list?";

  static const GET_MY_HISTORY = "mobile/event/my-events-history?limit=20&";

  static const BECOME_PARTNER = "mobile/business/create-business";

  static const UPDATE_BUSINESS_DETAIL = "mobile/business/update-business/"; //"mobile/business/update-business/";
  static const UPDATE_BUSINESS = "mobile/business/updateBusinessState/"; //"mobile/business/update-business/";

  static const GET_MY_ALL_BUSINESS = "mobile/business/my-business";

  static const TERMS_CONDITION = "mobile/cms/terms-and-conditions";

  static const ABOUT_PARTYLUX = "mobile/cms/party-lux";

  static const PRIVACY_POLICY = "mobile/cms/privacy-policay";

  static const PAYMENT_CHECKOUT = "mobile/event/stripe-payment-checkout";

  static const SUBSCRIBE_EVENT = "mobile/event/";

  static const SUBSCRIBE_MEMBERSHIP = "mobile/event/subscribe-membership";

  static const MEMBERSHIP_CHECKOUT = "mobile/event/membership-payment-checkout";

  static const SUBSCRIP_MEMBERSHIP = "mobile/event/subscribe-membership";

  static const FAQS = "mobile/faq/list";

  static const SUPPORT = "mobile/support/create";

  static const NOTIFICATION = "mobile/event/get-notifications";

  static const NOTIFICATION_DELETE = "mobile/event/delete-notification";

  static const EVENT_DELETE = "mobile/event/delete-event";

  static const BUSINESS_DELETE = "mobile/business/delete-business";

  static const FCM_SET_UPDATE = "mobile/event/create-fcmToken";

  static const GET_MY_BUSINESSES = "mobile/business/my-business";

  static const CHECK_OUT = "mobile/event/remove-participant";

  static const GET_ALL_PARTICIPANTS = "mobile/event/get-participants";

  static const UPDATE_BUSINESS_STATE = "mobile/business/updateBusinessState";

  static const MY_WALLET = "mobile/event/my-wallet-balance";

  static const GET_MY_TICKET = "mobile/event/my-reserve-events";

  static const GEOFENCING = "mobile/event/geofencing";

  static const EVENT_URL="mobile/event/create-event";

  static const GET_EVENt_PARTICIPANTS="mobile/event/event-participants?";
  static const GET_BUSINESS_PARTICIPANTS="mobile/business/business-participants?";
  static const GET_ORDERS="mobile/order?";
  static const GET_SINGLE_ORDERS="mobile/order/";
  static const ORDER_PLACE="mobile/order/place";
  static const GET_SPECIFIC_BUSINESS="mobile/business/business-detail";
  static const HIDE_FLYER="mobile/business/hide-flyer";
  static const UPDATE_ORDER="mobile/order/update-status";
  static const SEND_ANNOUNCEMENT="mobile/event/send-announcements";
  static const SEND_LOCATION="mobile/users/update-coordinates";
  static const CANCEL_EVENT="mobile/users/my-event-cancel";
  static const LOGOUT="mobile/auth/logout";
  static const FAVORITE_EVENT="mobile/event/favourite-toggle";
  static const FAVORITE_BUSINESS="mobile/business/favourite-toggle";
  static const CHECK_IN="mobile/order/checkin";
  static const DELETE_ACCOUNT="mobile/users/delete-user";

}
