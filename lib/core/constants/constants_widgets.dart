import 'package:flutter/material.dart';

import '../../views/screens/notes_screen/notes_body.dart';
import '../../views/screens/partners_screen/partners_screen.dart';
import '../../views/screens/tracking_screen/tracking_screen.dart';
import '../../views/screens/transactions_screen/transactions_screen.dart';

class ConstantWidgets {
  ConstantWidgets();
  static List<Widget> screenBodies = [
    const TransactionsBody(),
    const PartnersBody(),
    const NotesBody(),
    const TrackingBody()
  ];
}
