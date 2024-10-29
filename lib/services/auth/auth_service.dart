import 'package:chat_pocket_base/models/models.dart';
import 'package:pocketbase/pocketbase.dart';

class AuthService {
  PocketBase pb;

  AuthService({required this.pb});

  Future<ApiResponse> signUp(User user) async {
    try {
      await pb.collection('users').create(body: user.toJson());

      return ApiResponse.customMessage('User created successfully');
    } on ClientException catch (clientException) {
      return ApiResponse.fromClientException(clientException);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> signIn(User user) async {
    try {
      final response = await pb
          .collection('users')
          .authWithPassword(user.email, user.password);

      final authenticatedUser = User.fromJson(response.toJson());

      pb.authStore.save(response.token, authenticatedUser);

      return ApiResponse.customMessage('User authenticated successfully');
    } on ClientException catch (clientException) {
      return ApiResponse.fromClientException(clientException);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> checkStatus() async {
    try {
      final response = await pb.collection('users').authRefresh();

      final authenticatedUser = User.fromJson(response.toJson());

      pb.authStore.save(response.token, authenticatedUser);

      return ApiResponse.customMessage('User authenticated successfully');
    } on ClientException catch (clientException) {
      return ApiResponse.fromClientException(clientException);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }
}
