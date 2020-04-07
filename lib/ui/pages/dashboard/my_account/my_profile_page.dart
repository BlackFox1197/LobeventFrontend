import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/entities/company_admin.dart';
import 'package:auditergy_flutter/domain/entities/company_employee.dart';
import 'package:auditergy_flutter/domain/entities/customer.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/injection_container.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/my_account/user_info_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'not_immutable_users.dart';

class MyProfilePage extends StatefulWidget {
  @override
  MyProfilePage_State createState() => MyProfilePage_State();
}

class MyProfilePage_State extends State<MyProfilePage> {
  final _formKey = GlobalKey<FormState>();

  GlobalKey<UserInfoWidgetState> _userInfoWidgetEditKey = GlobalKey();
  final GlobalKey<FormState> _formUserInfoKey = GlobalKey<FormState>();

  MyAccountBloc _MyAccountBloc;
  User _loadedUser;
  EditedUser _editedUser;

  _updateUserInfo(User user) {
    _loadedUser = user;
  }

  @override
  initState() {
    _MyAccountBloc = sl<MyAccountBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyAccountBloc>(
      builder: (context) => _MyAccountBloc,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(64, 32, 64, 64),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: BlocBuilder<MyAccountBloc, MyAccountState>(
              builder: (context, state) {
                if (state is EmptyState) {
                  dispatchGetCurrentUser(context);
                  return Container();
                } else if (state is LoadingState) {
                  return Card(
                      child: SizedBox(height: 120, child: Text("Loading...")));
                } else if (state is AccountDeletedState) {
                  return Container(child: Text(ACC_DEL_SUCC));
                } else if (state is UserEditState) {
                  return Container(
                      child: Column(children: [
                    UserInfoWidget(
                        key: _userInfoWidgetEditKey,
                        formUserInfoKey: _formUserInfoKey,
                        user: _loadedUser,
                        euser: _editedUser,
                        allowedit: true,
                        con: context),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          deleteAccBtnWidget(context, false),
                          SizedBox(
                            width: 20,
                          ),
                          //TODO !!! create a user from filled form
                          submitUpdateProfileBtnWidget(
                              context, true, _editedUser),
                          SizedBox(
                            width: 20,
                          ),
                          cancelUpdateProfileBtnWidget(context, true),
                        ])
                  ]));
                } else if (state is ErrorState) {
                  return Container(child: Text("Error: " + state.message));
                } else if (state is CompanyAdminUserLoadedState) {
                  _loadedUser = state.user;
                  _editedUser = new EditedCompanyAdmin();
                  return Container(
                      child: Column(children: [
                    UserInfoWidget(
                        key: _userInfoWidgetEditKey,
                        formUserInfoKey: _formUserInfoKey,
                        user: _loadedUser,
                        euser: _editedUser,
                        allowedit: false,
                        con: context),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          deleteAccBtnWidget(context, true),
                          SizedBox(
                            width: 20,
                          ),
                          editProfileBtnWidget(context, true)
                        ])
                  ]));
                } else if (state is CompanyEmployeeUserLoadedState) {
                  _loadedUser = state.user;
                  _editedUser = EditedCompanyEmployee();
                  return Container(
                    child: UserInfoWidget(
                        key: _userInfoWidgetEditKey,
                        formUserInfoKey: _formUserInfoKey,
                        user: _loadedUser,
                        euser: _editedUser,
                        allowedit: false,
                        con: context),
                  );
                } else if (state is CustomerUserLoadedState) {
                  _loadedUser = state.user;
                  _editedUser = EditedCustomer();
                  return Container(
                      child: Column(children: [
                    UserInfoWidget(
                        key: _userInfoWidgetEditKey,
                        formUserInfoKey: _formUserInfoKey,
                        user: _loadedUser,
                        euser: _editedUser,
                        allowedit: false,
                        con: context),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          deleteAccBtnWidget(context, true),
                          SizedBox(
                            width: 20,
                          ),
                          editProfileBtnWidget(context, true)
                        ])
                  ]));
                } else if (state is CustomerUserUpdatedState) {
                  return Container(
                      child: Column(children: [
                    Text("User updated successfully"),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          backToProfileBtnWidget(context, true),
                          SizedBox(
                            width: 20,
                          ),
                        ])
                  ]));
                } else if (state is CompanyEmployeeUserUpdatedState) {
                  return Container(
                      child: Column(children: [
                    Text("User updated successfully"),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          backToProfileBtnWidget(context, true),
                          SizedBox(
                            width: 20,
                          ),
                        ])
                  ]));
                } else if (state is CompanyAdminUserUpdatedState) {
                  return Container(
                      child: Column(children: [
                    Text("User updated successfully"),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          backToProfileBtnWidget(context, true),
                          SizedBox(
                            width: 20,
                          ),
                        ])
                  ]));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget deleteAccBtnWidget(BuildContext context, bool allowpress) {
    return RaisedButton(
        color: Colors.blue,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        disabledColor: Colors.blueGrey,
        disabledElevation: 0,
        disabledTextColor: Colors.grey,
        onPressed: !allowpress ? null : () => dispatchDeleteUser(context),
        child: Text(
          'Delete My Account',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'HelveticaNeue',
          ),
        ));
  }

  Widget editProfileBtnWidget(BuildContext context, bool allowpress) {
    return RaisedButton(
        color: Colors.blue,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        onPressed: () {
          dispatchEditUser(context);
        },
        child: Text(
          'Edit My Account',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'HelveticaNeue',
          ),
        ));
  }

  Widget submitUpdateProfileBtnWidget(
      BuildContext context, bool allowpress, EditedUser u) {
    return RaisedButton(
        color: Colors.blue,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        onPressed: () {
          _userInfoWidgetEditKey
              .currentState.widget.formUserInfoKey.currentState
              .validate();
          _userInfoWidgetEditKey
              .currentState.widget.formUserInfoKey.currentState
              .save();
          dispatchUpdateUser(context, createUpdateUserParameter(_editedUser));
        },
        child: Text(
          'Submit Changes',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'HelveticaNeue',
          ),
        ));
  }

  Widget backToProfileBtnWidget(BuildContext context, bool allowpress) {
    return RaisedButton(
        color: Colors.blue,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        onPressed: () {
          dispatchGetCurrentUser(context);
        },
        child: Text(
          'Back to My Profile',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'HelveticaNeue',
          ),
        ));
  }

  Widget cancelUpdateProfileBtnWidget(BuildContext context, bool allowpress) {
    return RaisedButton(
        color: Colors.blue,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        onPressed: () {
          _userInfoWidgetEditKey
              .currentState.widget.formUserInfoKey.currentState
              .reset();
          dispatchGetCurrentUser(context);
        },
        child: Text(
          'Cancel Changes',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'HelveticaNeue',
          ),
        ));
  }

  User createUpdateUserParameter(EditedUser u) {
    if (u is EditedCompanyAdmin) {
      return new CompanyAdmin(
          companyName: u.companyName,
          companyEmployeesIds: u.companyEmployeesIds,
          companyWebsite: u.companyWebsite,
          country: u.country,
          email: u.email,
          firstname: u.firstname,
          houseNumber: u.houseNumber,
          id: u.id,
          lastname: u.lastname,
          phoneNumber: u.phoneNumber,
          postalcode: u.postalcode,
          state: u.state,
          street: u.street);
    }
    if (u is EditedCustomer) {
      return new Customer(
        country: u.country,
        email: u.email,
        firstname: u.firstname,
        houseNumber: u.houseNumber,
        id: u.id,
        lastname: u.lastname,
        phoneNumber: u.phoneNumber,
        postalcode: u.postalcode,
        state: u.state,
        street: u.street,
        solarServiceProviderId: u.solarServiceProviderId,
      );
    }
    if (u is EditedCompanyEmployee) {
      return new CompanyEmployee(
        country: u.country,
        email: u.email,
        firstname: u.firstname,
        houseNumber: u.houseNumber,
        id: u.id,
        lastname: u.lastname,
        phoneNumber: u.phoneNumber,
        postalcode: u.postalcode,
        state: u.state,
        street: u.street,
        companyId: u.companyId,
      );
    }
  }

  void dispatchDeleteUser(context) {
    BlocProvider.of<MyAccountBloc>(context).dispatch(DeleteAccountEvent());
  }

  void dispatchUpdateUser(context, User u) {
    BlocProvider.of<MyAccountBloc>(context).dispatch(UpdateUserEvent(user: u));
  }

  void dispatchEditUser(context) {
    BlocProvider.of<MyAccountBloc>(context).dispatch(EditUserEvent());
  }

  void dispatchGetCurrentUser(context) {
    BlocProvider.of<MyAccountBloc>(context).dispatch(GetCurrentUserEvent());
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}
