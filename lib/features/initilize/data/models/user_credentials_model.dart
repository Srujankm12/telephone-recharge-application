class UserCredentialsModel {
  final String collegeId;
  final String machineId;
  final String userId;
  final String amount;
  const UserCredentialsModel({
    required this.userId,
    required this.machineId,
    required this.collegeId,
    required this.amount,
  });
}