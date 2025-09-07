class RechargeHistoryEntity {
  final String userId;
  final String rechargeAmount;
  final String date;
  final String time;
  RechargeHistoryEntity({
    required this.userId,
    required this.date,
    required this.rechargeAmount,
    required this.time,
  });
}
