import 'package:flutter/widgets.dart';

/// [Page] Spacing constants [variants]

const double tiny = 4.0;

const double small = 8.0;

const double origin = 16.0;

const double medium = 24.0;

const double large = 32.0;

const double huge = 64.0;

///
const SizedBox space8 = SizedBox(height: 8, width: 8);
const SizedBox space4 = SizedBox(height: 4, width: 4);
const SizedBox space6 = SizedBox(height: 6, width: 6);
const SizedBox space16 = SizedBox(height: 16.0, width: 16.0);
const SizedBox space24 = SizedBox(height: 24.0, width: 24.0);
const SizedBox space32 = SizedBox(height: 32.0, width: 32.0);
const SizedBox space64 = SizedBox(height: 64.0, width: 64.0);
const Spacer spacer = Spacer();

/// Border radius constants [variants]
const borderRadius10 = 10.0;
const borderRadius12 = 12.0;

double defaultHeight(BuildContext context) {
  return MediaQuery.of(context).size.height -
      76 -
      MediaQuery.of(context).padding.top -
      80 -
      origin;
}
