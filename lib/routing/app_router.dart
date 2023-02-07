import 'package:get/get.dart';
import '../controllers/transactions_form_controller.dart';
import '../views/screens/partners_screen/agencies_screen/agency_transactions.dart';
import '../views/screens/home_screen.dart';
import '../views/screens/partners_screen/noters_screen/noter_transactions.dart';
import '../views/screens/notes_screen/notes_screen.dart';
import '../views/screens/partners_screen/service_providers_screen/service_providers_screen.dart';
import '../views/screens/transactions_screen/transaction_form/add_transaction_screen.dart';

import '../views/screens/partners_screen/service_providers_screen/service_provider_transactions.dart';
import '../views/screens/transactions_screen/transaction_details/transaction_details.dart';

class AppRoutes {
  AppRoutes();
  List<GetPage> allPages = [
    GetPage(
      name: '/',
      page: () => const HomePage(),
    ),
    GetPage(
      name: '/addTransactionScreen',
      page: () => AddTransactionScreen(),
      binding: BindingsBuilder.put(() => TransactionsFormController()),
    ),
    GetPage(
      name: '/notesScreen',
      page: () => const NotesScreen(),
    ),
    GetPage(
      name: '/serviceProviders',
      page: () => const ServiceProvidersBody(),
    ),
    GetPage(
      name: '/agencyTransactions',
      page: () => const AgencyTransactions(),
    ),
    GetPage(
        name: '/transactionDetails', page: () => const TransactionDetails()),
    GetPage(
        name: '/serviceProviderTransactions',
        page: () => const ServiceProviderTransactions()),
    GetPage(
        name: '/noterTransactionsScreen',
        page: () => const NoterTransactions()),
  ];

  static const homeScreen = '/';
  static const addTransactionScreen = '/addTransactionScreen';
  static const notesScreen = '/notesScreen';
  static const serviceProviders = '/serviceProviders';
  static const agencyTransactions = '/agencyTransactions';
  static const transactionDetails = '/transactionDetails';
  static const serviceProviderTransactions = '/serviceProviderTransactions';
  static const noterTransactions = '/noterTransactionsScreen';
}
