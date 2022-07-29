abstract class ISecureStorage {
  Future<String?> getUsername();

  Future<String?> getPassword();

  void setUsername(String username);

  void setPassword(String password);
}
