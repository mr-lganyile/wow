import '/models/competitions/voucher_type.dart';

class VoucherValidation {
  static bool isVoucherValid(String voucher, VoucherType voucherType) {
    return containsNumbersOnly(voucher);
  }

  static bool containsNumbersOnly(String voucher) {
    for (var charIndex = 0; charIndex < voucher.length; charIndex++) {
      if (!(voucher[charIndex] == '0' ||
          voucher[charIndex] == '1' ||
          voucher[charIndex] == '2' ||
          voucher[charIndex] == '3' ||
          voucher[charIndex] == '4' ||
          voucher[charIndex] == '5' ||
          voucher[charIndex] == '6' ||
          voucher[charIndex] == '7' ||
          voucher[charIndex] == '8' ||
          voucher[charIndex] == '9')) {
        return false;
      }
    }
    return true;
  }
}
