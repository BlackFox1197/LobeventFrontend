import 'dart:convert';

import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/company_employee_model.dart';
import 'package:auditergy_flutter/data/models/customer_model.dart';
import 'package:auditergy_flutter/data/models/user_model.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/exceptions.dart';
import 'package:auditergy_flutter/domain/entities/company_admin.dart';
import 'package:auditergy_flutter/domain/entities/company_employee.dart';
import 'package:auditergy_flutter/domain/entities/customer.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:dbcrypt/dbcrypt.dart';

abstract class UserRemoteDataSource {
  /// Calls the backend server to get the user object as JSON
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List> login(String email, String password);

  /// Throws a [ServerException] for all error codes.
  Future<bool> register(User user, String password);

  /// Throws a [ServerException] for all error codes.
  Future<bool> forgotPassword(String email);

  /// Throws a [ServerException] for all error codes.
  Future<User> updateUserData(List updateUserCredentials);

  /// Throws a [ServerException] for all error codes.
  Future<bool> deleteAccount(User user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({@required this.client});

  @override
  Future<bool> forgotPassword(String email) async {
    //TODO -> API currently not online
    final response = await client.post(
      FORGOT_PASSWORD_URI,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'email': '$email'}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      if (responseJson['status'] == "failure") {
        throw ServerException(responseJson['message']);
      } else if (responseJson['status'] == "success") {
        return true;
      }
    } else {
      throw ServerException(UNKNOWN_ERROR);
    }
  }

  @override
  Future<List> login(String email, String password) async {
    //TODO: hash password for security
    String accessToken = "";
    // send request to backend
    final response = await client.post(
      LOGIN_URI,
      headers: {
        'Content-Type': 'application/json',
        'authorization': API_BASIC_AUTH
      },
      body: json.encode({
        'username': '$email',
        'password': '$password',
        'emailAddress': '$email'
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      if (responseJson['status'] == "failure") {
        throw ServerException(responseJson['message']);
      } else if (responseJson['status'] == "ok") {
        // get the access tokens
        accessToken = responseJson['token'];
        print(accessToken);
        String responseString = responseJson['user'].toString();
        Map userMap = json.decode(responseString);
        String userType = userMap['userType'].toString();
        //get the user object
        switch (userType) {
          case 'CUSTOMER':
            {
              User user = CustomerModel.fromJson(userMap);
              return [user, accessToken];
            }
            break;
          case 'ADMIN':
            {
              User user = CompanyAdminModel.fromJson(userMap);
              return [user, accessToken];
            }
            break;
          case 'EMPLOYEE':
            {
              User user = CompanyEmployeeModel.fromJson(userMap);
              return [user, accessToken];
            }
            break;

          default:
            {
              print("null");
              return null;
            }
            break;
        }
      } else {
        throw ServerException(UNKNOWN_ERROR);
      }
    } else {
      throw ServerException(UNKNOWN_ERROR);
    }
  }

  @override
  Future<bool> register(User user, String password) async {
    Map<String, dynamic> request = {};
    // make the right request appropriate to what specific user we are handling
    if (user is CompanyAdmin) {
      CompanyAdminModel userModel = CompanyAdminModel.FromCompanyAdmin(user);
      request = userModel.toJson();
      //put the type of the user to make clear which one has to be registered
      request.putIfAbsent('userType', () => "ADMIN");
      //delete the id from the string to let the backend generate a unique identifier for the db
      request.remove("id");
      //TODO: add the hashed password to the request
      request.putIfAbsent('password', () => password);
      //call the api endpoint
      final response = await client.post(COMPANY_ADMIN_REGISTER_URI,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': API_BASIC_AUTH
          },
          body: json.encode(request));

      if (response.statusCode == 200) {
        return true;
/*         Map<String, dynamic> responseJson = json.decode(response.body);
        if (responseJson['status'] == "failure") {
          throw ServerException(responseJson['message']);
        } else if (responseJson['status'] == "success") {
          return true;
        } else {
          throw ServerException(UNKNOWN_ERROR);
        } */
      } else {
        throw ServerException(SERVER_ERROR);
      }
    } else if (user is CompanyEmployee) {
      CompanyEmployeeModel userModel =
          CompanyEmployeeModel.FromCompanyEmployee(user);
      request = userModel.toJson();
      //put the type of the user to make clear which one has to be registered
      request.putIfAbsent('userType', () => "EMPLOYEE");
      //delete the id from the string to let the backend generate a unique identifier for the db
      request.remove("id");
      //TODO: add the hashed password to the request
      request.putIfAbsent('password', () => password);
      final response = await client.post(COMPANY_EMPLOYEE_REGISTER_URI,
          headers: {
            'Content-Type': 'application/json',
            'authorization': API_BASIC_AUTH
          },
          body: json.encode(request));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerException(SERVER_ERROR);
      }
    } else if (user is Customer) {
      CustomerModel userModel = CustomerModel.FromCustomer(user);
      request = userModel.toJson();
      //put the type of the user to make clear which one has to be registered
      request.putIfAbsent('userType', () => "CUSTOMER");
      //delete the id from the string to let the backend generate a unique identifier for the db
      request.remove("id");
      //TODO: add the hashed password to the request
      request.putIfAbsent('password', () => password);
      final response = await client.post(CUSTOMER_REGISTER_URI,
          headers: {
            'Content-Type': 'application/json',
            'authorization': API_BASIC_AUTH
          },
          body: json.encode(request));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerException(SERVER_ERROR);
      }
    } else {
      return false;
    }
  }

  @override
  Future<User> updateUserData(List updateUserCredentials) async {
    Map<String, dynamic> request = {};
    // make the right request appropriate to what specific user we are handling
    if (updateUserCredentials[0] is CompanyAdmin) {
      CompanyAdminModel userModel =
          CompanyAdminModel.FromCompanyAdmin(updateUserCredentials[0]);
      //serialize model
      request = userModel.toJson();
      //put the type of the user to make clear which one has to be registered
      request.putIfAbsent('userType', () => "ADMIN");
      //create route and get token
      final String uniqueUserUpdateRoute =
          UPDATE_COMPANY_ADMIN_URI + "/" + userModel.id;
      String accessToken = updateUserCredentials[1];
      final response = await client.put(uniqueUserUpdateRoute,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': API_BASIC_AUTH
          },
          body: json.encode(request));

      // TODO: Figure out method for refresh token -> handling should happen here
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        if (responseJson['status'] == "failure") {
          throw ServerException(responseJson['message']);
        } else if (responseJson['id'] == userModel.id) {
          return updateUserCredentials[0];
        } else {
          throw ServerException(UNKNOWN_ERROR);
        }
      } else {
        throw ServerException(SERVER_ERROR);
      }
    } else if (updateUserCredentials[0] is CompanyEmployee) {
      CompanyEmployeeModel userModel =
          CompanyEmployeeModel.FromCompanyEmployee(updateUserCredentials[0]);
      //serialize model
      request = userModel.toJson();
      //put the type of the user to make clear which one has to be registered
      request.putIfAbsent('userType', () => "EMPLOYEE");
      //create route and get token
      final String uniqueUserUpdateRoute =
          UPDATE_COMPANY_EMPLOYEE_URI + "/" + userModel.id;
      //TODO: figure out where to put the accessToken
      String accessToken = updateUserCredentials[1];

      final response = await client.put(uniqueUserUpdateRoute,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': API_BASIC_AUTH
          },
          body: json.encode(request));

      // TODO: Figure out method for refresh token -> handling should happen here
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        if (responseJson['status'] == "failure") {
          throw ServerException(responseJson['message']);
        } else if (responseJson['id'] == userModel.id) {
          return updateUserCredentials[0];
        } else {
          throw ServerException(UNKNOWN_ERROR);
        }
      } else {
        throw ServerException(SERVER_ERROR);
      }
    } else if (updateUserCredentials[0] is Customer) {
      CustomerModel userModel =
          CustomerModel.FromCustomer(updateUserCredentials[0]);
      //serialize model
      request = userModel.toJson();
      //put the type of the user to make clear which one has to be registered
      request.putIfAbsent('userType', () => "CUSTOMER");
      //create route and get token
      final String uniqueUserUpdateRoute =
          UPDATE_CUSTOMER_URI + "/" + userModel.id;
      String accessToken = updateUserCredentials[1];
      final response = await client.put(uniqueUserUpdateRoute,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': API_BASIC_AUTH
          },
          body: json.encode(request));
      print(response.statusCode);
      print(response.body);
      print(userModel.id);
      // TODO: Figure out method for refresh token -> handling should happen here
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        if (responseJson['status'] == "failure") {
          throw ServerException(responseJson['message']);
        } else if (responseJson['id'] == userModel.id) {
          print("hi you");
          return updateUserCredentials[0];
        } else {
          throw ServerException(UNKNOWN_ERROR);
        }
      } else {
        throw ServerException(SERVER_ERROR);
      }
    } else {
      throw ServerException(UNKNOWN_ERROR);
    }
  }

  @override
  Future<bool> deleteAccount(User user) async {
    // make the right request appropriate to what specific user we are handling
    if (user is CompanyAdmin) {
      CompanyAdminModel userModel = CompanyAdminModel.FromCompanyAdmin(user);
      //TODO: get token and put to right place
      //create route
      final String uniqueUserDeleteRoute =
          COMPANY_ADMIN_DELETE_URI + "/" + userModel.id;
      final response = await client.delete(
        uniqueUserDeleteRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        if (responseJson['status'] == "failure") {
          throw ServerException(responseJson['message']);
        } else if (responseJson['success'] == true) {
          return true;
        } else {
          throw ServerException(UNKNOWN_ERROR);
        }
      } else {
        throw ServerException(SERVER_ERROR);
      }
    } else if (user is CompanyEmployee) {
      CompanyEmployeeModel userModel =
          CompanyEmployeeModel.FromCompanyEmployee(user);
      //TODO: get token and put to right place
      //create route
      final String uniqueUserDeleteRoute =
          COMPANY_EMPLOYEE_DELETE_URI + "/" + userModel.id;
      final response = await client.delete(
        uniqueUserDeleteRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        if (responseJson['status'] == "failure") {
          throw ServerException(responseJson['message']);
        } else if (responseJson['success'] == true) {
          return true;
        } else {
          throw ServerException(UNKNOWN_ERROR);
        }
      } else {
        throw ServerException(SERVER_ERROR);
      }
    } else if (user is Customer) {
      CustomerModel userModel = CustomerModel.FromCustomer(user);
      //TODO: get token and put to right place
      print('hi before put for customer delete');
      //create route
      final String uniqueUserDeleteRoute =
          CUSTOMER_DELETE_API + "/" + userModel.id;
      final response = await client.delete(
        uniqueUserDeleteRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        if (responseJson['status'] == "failure") {
          throw ServerException(responseJson['message']);
        } else if (responseJson['success'] == true) {
          return true;
        } else {
          throw ServerException(UNKNOWN_ERROR);
        }
      } else {
        throw ServerException(SERVER_ERROR);
      }
    } else {
      return false;
    }
  }
}
