import 'package:chat_pocket_base/core/patterns/either.dart';
import 'package:chat_pocket_base/models/models.dart';
import 'package:pocketbase/pocketbase.dart';

class AuthService {
  PocketBase pb;

  AuthService({required this.pb});

  Future<Either<ApiResponse, User>> signUp(User user) async {
    try {
      final response = await pb.collection('users').create(body: user.toJson());

      return Either.right(User.fromJson(response.toJson()));
    } on ClientException catch (clientException) {
      return Either.left(ApiResponse.fromClientException(clientException));
    } catch (e) {
      return Either.left(ApiResponse.fromError(e));
    }
  }

  Future<Either<ApiResponse, User>> signIn(User user) async {
    try {
      final userResponse = await pb
          .collection('users')
          .authWithPassword(user.email, user.password);

      final usr = User.fromJson(userResponse.toJson());

      pb.authStore.save(userResponse.token, usr);

      return Either.right(usr);
    } on ClientException catch (clientException) {
      return Either.left(ApiResponse.fromClientException(clientException));
    } catch (e) {
      return Either.left(ApiResponse.fromError(e));
    }
  }
}
