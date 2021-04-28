library constants;

import 'package:flutter/material.dart';

double responsiveCofficient(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return 0.00112 * size.height;
}
