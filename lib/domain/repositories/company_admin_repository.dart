import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/entities/company_admin.dart';
import 'package:auditergy_flutter/domain/entities/company_employee.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_note.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

//the Repository of the Entity tells the outside world what things are able to do with an instance

abstract class CompanyAdminRepository {
  Future<Either<Failure, List<CompanyEmployee>>> getEmployees(
      {@required CompanyAdmin companyAdmin});

/*   /// Updates selected variables of a [User]
  Future<Either<Failure, bool>> updateCompanyAdminData(
      {@required Map<String, dynamic> updatedVariables});  */
}
