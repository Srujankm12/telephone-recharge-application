class InitCardRestrictedEntity {
  final String signal;
  final String mode;
  final String amount;
  final List<String> phoneNumbers;

  InitCardRestrictedEntity({
    required this.amount,
    required this.phoneNumbers,
    required this.signal,
    required this.mode,
  });
}
