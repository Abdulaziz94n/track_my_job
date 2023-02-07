enum PaymentBy {
  reference,
  client;

  factory PaymentBy.fromString(String str) {
    switch (str) {
      case 'client':
        return PaymentBy.client;
      case 'reference':
        return PaymentBy.reference;
      default:
        return PaymentBy.client;
    }
  }

  @override
  String toString() => 'PaymentBy: $name';
}
