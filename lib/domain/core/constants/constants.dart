import 'dart:convert';

// API ENDPOINTS
const String LOGIN_URI = 'https://api.auditergy.com/users/login';

const String COMPANY_ADMIN_REGISTER_URI =
    'https://api.auditergy.com/company-admin';
const String COMPANY_EMPLOYEE_REGISTER_URI =
    'https://api.auditergy.com/company-employee';
const String CUSTOMER_REGISTER_URI = 'https://api.auditergy.com/customer';

const String COMPANY_ADMIN_DELETE_URI =
    'https://api.auditergy.com/company-admin';
const String COMPANY_EMPLOYEE_DELETE_URI =
    'https://api.auditergy.com/company-employee';
const String CUSTOMER_DELETE_API = 'https://api.auditergy.com/customer';

const String FORGOT_PASSWORD_URI =
    'https://api.auditergy.com/v1/forgot_password';

const String UPDATE_COMPANY_ADMIN_URI =
    'https://api.auditergy.com/company-admin';
const String UPDATE_COMPANY_EMPLOYEE_URI =
    'https://api.auditergy.com/company-employee';
const String UPDATE_CUSTOMER_URI = 'https://api.auditergy.com/customer';

const String CREATE_SOLAR_INSTALLATION_URI =
    'https://api.auditergy.com/solar-installation';
const String DELETE_SOLAR_INSTALLATION_URI =
    'https://api.auditergy.com/solar-installation';
const String GET_COMPANY_ADMIN_SOLAR_INSTALLATIONS_URI =
    'https://api.auditergy.com/solar-installation/admin';
const String GET_COMPANY_EMPLOYEE_SOLAR_INSTALLATIONS_URI =
    'https://api.auditergy.com/solar-installation/employee';
const String GET_CUSTOMER_SOLAR_INSTALLATIONS_URI =
    'https://api.auditergy.com/solar-installation/customer';

// DEFAULT ERROR MESSAGES
const String UNKNOWN_ERROR = "UNKNOWN ERROR";
const String NETWORK_ERROR = "NO NETWORK CONNECTION ESTABLISHED";
const String SERVER_ERROR = "SERVER ERROR 404";
const String CACHE_ERROR = "CACHE ERROR";

const String NULL_INSTANCE = "NULL INSTANCE OF THE OBJECT";
const String NULL_INSTANCE_USER = "NULL INSTANCE OF THE OBJECT USER";

// LOCAL DATA SOURCE USER BOX NAME
const String USER_BOX = "USER_BOX";
// LOCAL DATA SOURCE SOLAR INSTALLATION BOX NAME
const String SOLAR_INSTALLATION_BOX = "SOLAR_INSTALLATION_BOX";
//TOKEN BOX NAME
const TOKEN_BOX_NAME = 'TOKEN_BOX';

// KEY NAMES IN THE BOXES
const CACHED_USER = 'CACHED_USER';
const CACHED_SOLAR_INSTALLATIONS = 'CACHED_SOLAR_INSTALLATIONS';
const ACCESS_TOKEN = 'ACCESS_TOKEN';
const REFRESH_TOKEN = 'REFRESH_TOKEN';

//UI Messages
const String ACC_DEL_SUCC =
    "Your account was inactivated. We regret your decision and you will be contacted by our support team soon.";
const String ACC_DEL_FAILED_SERVER_FAILURE =
    "Account inactivation failed. Please check your Internet connection.";
const String ACC_DEL_FAILED_CACHE_FAILURE =
    "Account inactivation failed. Could not identify user from cache.";
const String GET_CURRENT_USER_CACHE_FAILURE =
    "User could not be loaded from cache.";
const String WRONG_CREDENTIALS_MESSAGE =
    'The email or password you have entered is invalid';
const String SERVER_FAILURE_MESSAGE = 'Please check your Internet connection.';
const String CACHE_FAILURE_MESSAGE = 'Could not identify user from cache.';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'The entered value is an invalid value.';

//Get current user
const String CURR_USER_LOADED_SUCC = "User could be loaded successfully";
const String CURR_USER_LOAD_FAILED_SERVER_FAILURE =
    "User loading failed. Please check your Internet connection.";
const String CURR_USER_LOAD_FAILED_CACHE_FAILURE =
    "User loading failed. Could not identify user from cache.";
const String CURR_USER_NOT_IDENTIFIED_FAILURE =
    "The User could not be identified";
//Update User
const String UPDATE_USER_SUCC = "User could be updated successfully";
const String USER_UPDATE_FAILED_SERVER_FAILURE =
    "User update failed. Please check your Internet connection.";
const String UPDATE_USER_FAILED_NOT_IDENTIFIED_FAILURE =
    "The User could not be updated due to unknown failure.";
//Hive
const String HIVE_BOX_NAME = "auditergy_hive_box";
const String APP_DIR_PATH = "C:\\";

//API BASIC AUTHENTICATION
const String API_USERNAME = "test";
const String API_PASSWORD = "test_password";
final String API_BASIC_AUTH =
    'Basic ' + base64Encode(utf8.encode('$API_USERNAME:$API_PASSWORD'));
