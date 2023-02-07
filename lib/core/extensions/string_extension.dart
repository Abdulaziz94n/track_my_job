extension StringExtension on String {
  String get capitalizeFirst =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);

  String get capitalizeFirstOfEach =>
      isEmpty ? this : split(' ').map((e) => e.capitalizeFirst).join(' ');

  String get trimAndLower => trim().toLowerCase();

  String get hardCoded => this;

  String get removeNumsFromString => replaceAll(RegExp(r'[-.,0-9 ]'), '');

  int get getNumsFromString => int.tryParse(replaceAll(RegExp(r'[^0-9]'), ''))!;

  // check isCurrency need modifiy to my needs
  // static bool isCurrency(String s) => hasMatch(s,
  //   r'^(S?\$|\₩|Rp|\¥|\€|\₹|\₽|fr|R\$|R)?[ ]?[-]?([0-9]{1,3}[,.]([0-9]{3}[,.])*[0-9]{3}|[0-9]+)([,.][0-9]{1,2})?( ?(USD?|AUD|NZD|CAD|CHF|GBP|CNY|EUR|JPY|IDR|MXN|NOK|KRW|TRY|INR|RUB|BRL|ZAR|SGD|MYR))?$');
}

extension NullableStringExtension on String? {
  bool get nullOrEmpty => this == null || this!.isEmpty ? true : false;
}
