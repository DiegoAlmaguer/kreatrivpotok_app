enum UserRole { admin, staff, client }

extension UserRoleX on UserRole {
  static UserRole fromString(String raw) {
    return UserRole.values.firstWhere(
      (r) => r.name == raw,
      orElse: () => UserRole.client,
    );
  }
}
