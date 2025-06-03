import 'package:firebase_auth/firebase_auth.dart';

import '../models/custom_error_model.dart';

CustomErrorModel handleException(e){
  try{
    throw e;
  } on FirebaseAuthException catch (e) {
      return CustomErrorModel(
        code: e.code,
        message: e.message ?? 'Invalid credentials',
      );
    } on FirebaseException catch(e){
      return CustomErrorModel(
        code: e.code,
        message: e.message ?? 'Firebase error',
      );
    } catch (e) {
      return CustomErrorModel(
        code: 'Exception',
        message: e.toString(),
      );
    }
}