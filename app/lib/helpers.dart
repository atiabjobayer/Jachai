import 'dart:convert';

import 'dart:io';

class Helpers {
  static String bengaliNumbers(String english) {
    String bangla = '';

    english.split('').forEach(
      (char) {
        int i = '0123456789'.indexOf(char);
        if (i == -1) {
          bangla += char;
        } else
          bangla += '০১২৩৪৫৬৭৮৯'[i];
      },
    );
    return bangla;
  }

  static String imageToBase64String(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    return base64Encode(imageBytes);
  }
}
