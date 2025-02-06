import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:roadrunner_provider_app/core/unified_api/exceptions.dart';
import 'package:roadrunner_provider_app/core/unified_api/failures.dart';

mixin HandlingExceptionManager {
  // The wrapHandling<T> function is used to handle errors during the execution of asynchronous operations.

  Future<Either<Failure, T>> wrapHandling<T>({
    required Future<Right<Failure, T>> Function() tryCall,
    Future<T?> Function()? tryCallLocal,
  }) async {
    try {
      final right = await tryCall();
      return (right);
    } on ServerException catch (e) {
      log("<< ServerException >> ");
      if (tryCallLocal != null) {
        final result = await tryCallLocal();
        if (result != null) {
          return Right(result);
        } else {
          return Left(ServerFailure(e.message));
        }
      } else {
        return Left(ServerFailure(e.message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
