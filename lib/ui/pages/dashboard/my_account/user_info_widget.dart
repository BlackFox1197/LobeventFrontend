import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/customer_model.dart';
import 'package:auditergy_flutter/domain/entities/company_employee.dart';
import 'package:auditergy_flutter/domain/entities/customer.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/ui/utils/raw_data.dart';
import 'package:flutter/material.dart';

import 'not_immutable_users.dart';

class UserInfoWidget extends StatefulWidget {
const  UserInfoWidget({Key key,this.formUserInfoKey, this.user, this.euser, this.allowedit, this.con}) : super(key: key);
  final User user;
  final EditedUser euser;
  final GlobalKey<FormState> formUserInfoKey;
  final bool allowedit;
  final BuildContext con;
  @override
  UserInfoWidgetState createState() => UserInfoWidgetState();
}


class UserInfoWidgetState extends State<UserInfoWidget>{

@override
Widget build(BuildContext context) {
  final GlobalKey<FormState> formUserInfoKey = widget.formUserInfoKey;
  User user = widget.user;
  EditedUser euser = widget.euser;  
  bool allowedit = widget.allowedit;
  context = widget.con;  

  String getProfileTypeString(User u){
    if(u is CompanyAdminModel){
      return "Company Admin";
    }else
    if(u is CompanyEmployee){
      return "Company Employee";
    }else 
    if(u is CustomerModel){
      return "Customer";
    }else{
      return "Unknown";
    }
  }

   initialiseEdit(){
    if(user is CompanyAdminModel){
      (euser as EditedCompanyAdmin).FromCA(user);      
    }else
    if(user is CompanyEmployee){
      (euser as EditedCompanyEmployee).FromCE(user); 
    }else 
    if(user is CustomerModel){
      (euser as EditedCustomer).FromC(user); 
  }
   }

  initialiseEdit();
  //print('initialise info widget, sol prov Id from user');
  //print((user as Customer).solarServiceProviderId);
    //print('initialise info widget, sol prov Id from euser');
  //print((euser as EditedCustomer).solarServiceProviderId);
  return Card(
    elevation: 2.0,
    child:  Form(
          key: formUserInfoKey,
          autovalidate: true,
          child: Container(
            margin: EdgeInsets.fromLTRB(64, 32, 64, 64),
            child: Column(
                              
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(64, 32, 64, 64),
                                  child: Text(
                                    'My Profile',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                  enabled:false,
                                  decoration: InputDecoration(
                                    labelText: 'Profile Type',
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                  initialValue: getProfileTypeString(user),
                                  validator: (value) {                                
                                  },
                                  onSaved: (value) {                                
                                  },
                                ),
                                ///Profile Type
                                TextFormField(
                                  enabled:allowedit,
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                  initialValue: user.firstname,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter First Name';
                                    }
                                  },
                                  onSaved: (val){
                                    euser.firstname = val;
                                  } ,
                                ),
                                ///First Name
                                 TextFormField(
                                  enabled:allowedit,
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                  initialValue: user.lastname,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Last Name';
                                    }
                                  },
                                  onSaved: (val){
                                    euser.lastname = val;
                                  } ,
                                ),
                                ///Last Name
                                TextFormField(
                                  enabled: allowedit,
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                  initialValue: user.phoneNumber,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Phone Number';
                                    }
                                  },
                                  onSaved: (val){
                                    euser.phoneNumber = val;
                                  } ,
                                ),
                                ///Phone Number
                                Text("Address",                                
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaNeue',
                                    ),),
                                TextFormField(
                                  enabled: allowedit,
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Street',
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                  initialValue: user.street,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Street';
                                    }
                                  },
                                  onSaved: (val){
                                    euser.street = val;
                                  } ,
                                ),
                                ///Street
                                 TextFormField(
                                  enabled: allowedit,
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'House Number',
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                  initialValue: user.houseNumber,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter House Number';
                                    }
                                  },
                                  onSaved: (val){
                                    euser.houseNumber = val;
                                  } ,
                                ),
                                ///House Number
                                TextFormField(
                                  enabled: allowedit,
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'State',
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                  initialValue: user.state,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter State';
                                    }
                                  },
                                  onSaved: (val){
                                    euser.state = val;
                                  } ,
                                ),
                                ///State
                                TextFormField(
                                  enabled: allowedit,
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Postal Code',
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                  initialValue: user.postalcode,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Postal Code';
                                    }
                                  },
                                  onSaved: (val){
                                    euser.postalcode = val;
                                  } ,
                                ),
                                ///Postal Code
                               TextFormField(
                                  enabled: allowedit,
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Country',
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                  initialValue: user.country,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter State';
                                    }
                                  },
                                  onSaved: (val){
                                    euser.country = val;
                                  } ,
                                ),
                                ///Country
                                TextFormField(
                                  enabled: allowedit,
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                  initialValue: user.email,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter email';
                                    }
                                  },
                                  onSaved: (val){
                                    euser.email = val;
                                  } ,
                                ),
                                ///email
                                Container(
                                  child: ((){
                                    if (user is CompanyAdminModel) {
                                        return Container(
                                        child:   Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  TextFormField(
                                                    enabled: allowedit,
                                                    style: TextStyle(
                                                      fontFamily: 'HelveticaNeue',
                                                    ),
                                                    decoration: InputDecoration(
                                                      labelText: 'Company Name',
                                                      labelStyle: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'HelveticaNeue',
                                                      ),
                                                    ),
                                                    initialValue: user.companyName,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter Company Name';
                                                      }
                                                    },
                                                    onSaved: (val){
                                                      (euser as EditedCompanyAdmin).companyName = val;
                                                    } ,
                                                  ),
                                                  ///CompanyName
                                                   TextFormField(
                                                    enabled: allowedit,
                                                    style: TextStyle(
                                                      fontFamily: 'HelveticaNeue',
                                                    ),
                                                    decoration: InputDecoration(
                                                      labelText: 'Company Website',
                                                      labelStyle: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'HelveticaNeue',
                                                      ),
                                                    ),
                                                    initialValue: user.companyWebsite,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter Company Website';
                                                      }
                                                    },
                                                    onSaved: (val){
                                                      (euser as EditedCompanyAdmin).companyWebsite = val;
                                                    } ,
                                                  ),
                                                  ///CompanyWebsite
                                                ])
                                        );
                                    }else
                                    if (user is CustomerModel){
                                        return Container(
                                            child:   Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  TextFormField(
                                                    enabled: allowedit,
                                                    style: TextStyle(
                                                      fontFamily: 'HelveticaNeue',
                                                    ),
                                                    decoration: InputDecoration(
                                                      labelText: 'Solar Installation Provider',
                                                      labelStyle: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'HelveticaNeue',
                                                      ),
                                                    ),
                                                    initialValue: user.solarServiceProviderId,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter Solar Installation Provider';
                                                      }
                                                    },
                                                    onSaved: (val){
                                                      (euser as EditedCustomer).solarServiceProviderId = val;
                                                    } ,
                                                  ),
                                                  ///Solar Installation Provider
                                                ])
                                        );
                                    }else
                                    if (user is CompanyEmployee){
                                        return Container(
                  
                                        );
                                    }else{
                                      return Container();
                                    }  
                                     }())
                                ),
                                
                              ]),
      ),
    )
  );
}
}