// import 'package:dartz/dartz.dart';
// import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
// import 'package:roadrunner_provider_app/core/unified_api/handling_exception_manager.dart';
// import 'package:roadrunner_provider_app/features/client/data/datasources/client_datasource.dart';

// import '../model/client.dart';

// class ClientAddressesRepo with HandlingExceptionManager {
//   final ClientDatasource _clientDatasource;

//   ClientAddressesRepo(this._clientDatasource);

//   Future<Either<Failure, List<Address>>> getAddresses() async {
//     return handleError(
//       tryCall: () async {
//         final addresses = await _clientDatasource.getAddresses();
//         return Right(addresses);
//       },
//     );
//   }

//   Future<Either<Failure, void>> addAddress(Address address) async {
//     return handleError(
//       tryCall: () async {
//         await _clientDatasource.addAddress(address);
//         return const Right(null);
//       },
//     );
//   }

//   Future<Either<Failure, void>> updateAddress(Address address) async {
//     return handleError(
//       tryCall: () async {
//         await _clientDatasource.updateAddress(address);
//         return const Right(null);
//       },
//     );
//   }

//   Future<Either<Failure, void>> deleteAddress(String addressId) async {
//     return handleError(
//       tryCall: () async {
//         await _clientDatasource.deleteAddress(addressId);
//         return const Right(null);
//       },
//     );
//   }
// }