import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import './auth_exception.dart';
import './base_auth_repository.dart';
import '/../repositories/firebase_providers.dart';


final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref.read));

class AuthRepository implements BaseAuthRepository {
  final Reader _read;

  const AuthRepository(this._read);

  @override
  Stream<User?> get authStateChanges =>
      _read(firebaseAuthProvider).authStateChanges();
  
  @override
  Future<void> signInAnonymously() async {
    try {
          await _read(firebaseAuthProvider).signInAnonymously();
    } on FirebaseAuthException catch(error) {
      throw AuthException(message: error.message);
    }
  }

  @override
  User? getCurrentUser() {
    try {
     return  _read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (error) {
      throw AuthException(message: error.message);
    }
  }
      

  @override
  Future<void> signOut() async {
    await _read(firebaseAuthProvider).signOut();
    await signInAnonymously();
  }

}
