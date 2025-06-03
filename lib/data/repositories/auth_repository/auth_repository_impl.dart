import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../utils/constants/firebase_constants.dart';
import '../../models/app_user/app_user_model.dart';
import '../handle_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  User? get currentUser => fbAuth.currentUser;

  @override
  Future<void> changePassword({required String password}) async {
    try {
      await currentUser!.updatePassword(password);
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<void> reauthenticateWithCredential({
    required String email,
    required String password,
  }) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await currentUser!.reauthenticateWithCredential(credential);
    } catch (e) {
      throw handleException(e);
    }
  }

  //Check when reload user should be used...
  //Called after email verification...
  //If not email verification logic, remove it ...
  @override
  Future<void> reloadUser() async {
    try {
      await currentUser!.reload();
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await fbAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      final userCredential = await fbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final signedInUser = userCredential.user;
      final userId = signedInUser!.uid;

      // Fetch user document from Firestore
      final userDoc = await usersCollection.doc(userId).get();

      // Create AppUserModel from Firestore document
      final appUser = AppUserModel.fromDoc(userDoc);

      //open hive storage using the userId...
      if (!Hive.isBoxOpen('User_$userId')) {
        await Hive.openBox('User_$userId');
      }
      if (!Hive.isBoxOpen('Tasks_$userId')) {
        await Hive.openBox('Tasks_$userId');
      }

      // Open Hive box and store user details
      final userBox = Hive.box('User_$userId');
      await userBox.put('details', appUser.toJson());
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final userId = currentUser?.uid;

      await fbAuth.signOut();

      //Close user box
      if (userId != null && Hive.isBoxOpen('User_$userId')) {
        await Hive.box('User_$userId').close();
      }
      //Close task box
      if (userId != null && Hive.isBoxOpen('Tasks_$userId')) {
        await Hive.box('Tasks_$userId').close();
      }
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) async {
    try {
      final userCredential = await fbAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final signedInUser = userCredential.user;

      await usersCollection.doc(signedInUser!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
      });

      //Get the userId...
      final userId = signedInUser.uid;

      // Fetch user document from Firestore
      final userDoc = await usersCollection.doc(userId).get();

      // Create AppUserModel from Firestore document
      final appUser = AppUserModel.fromDoc(userDoc);

      //open hive storage using the userId...
      if (!Hive.isBoxOpen('User_$userId')) {
        await Hive.openBox('User_$userId');
      }
      if (!Hive.isBoxOpen('Tasks_$userId')) {
        await Hive.openBox('Tasks_$userId');
      }

      // Open Hive box and store user details
      final userBox = Hive.box('User_$userId');
      await userBox.put('details', appUser.toJson());
    } catch (e) {
      throw handleException(e);
    }
  }
}
