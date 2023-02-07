import 'dart:math' as math;

import 'package:intl/intl.dart';
import '../enums/currencies.dart';
import '../enums/noter_payment.dart';
import '../enums/note_priority.dart';
import '../enums/ref_payment_by.dart';
import '../enums/services.dart';
import '../enums/transaction_types.dart';
import '../../models/agency.dart';
import '../../models/extra_service.dart';
import '../../models/note.dart';
import '../../models/noter_details.dart';
import '../../models/reference_details.dart';
import '../../models/service_provider.dart';
import '../../models/noter.dart';
import '../../models/transaction.dart';
import '../enums/customer_type.dart';
import '../enums/payment_status.dart';

class DummyData {
  static Transaction testTransaction = Transaction(
    isPinned: true,
    amount: 1500,
    customerType: CustomerType.referenced,
    paymentStatus: PaymentStatus.partiallyPaid,
    referenceDetails: ReferenceDetails(
        note: 'note here',
        paymentBy: PaymentBy.client,
        toRefPayment: PaymentStatus.notPaid,
        reference: Agency(name: 'kervan', id: '9328'),
        referencePortion: '300 ₺'),
    dateTime: DateTime.now(),
    id: math.Random().nextInt(1000).toString(),
    currency: Currency.eur,
    customer: 'wleed',
    note: 'test note',
    transactionType: TransactionType.embassy,
    netProfit: 1200,
    noterDetails: NoterDetails(
        noterProfit: 0,
        id: '7',
        noterFee: 300,
        noterPayment: NoterPayment.notDone),
    extraServices: [
      ExtraService(
          buyPrice: '7\$',
          paymentStatus: PaymentStatus.notPaid,
          sellPrice: '10\$',
          service: Services.docApproval,
          serviceProviderName: DummyData.serviceProvidersList.last.name),
      ExtraService(
        buyPrice: '7\$',
        paymentStatus: PaymentStatus.notPaid,
        sellPrice: '10\$',
        service: Services.docApproval,
        serviceProviderName: DummyData.serviceProvidersList.last.name,
        note: 'test note',
      ),
    ],
  );

  static final ExtraService _extraServiceTest = ExtraService(
      buyPrice: '10 \$',
      sellPrice: '15 \$',
      paymentStatus: PaymentStatus.paid,
      service: Services.docApproval,
      serviceProviderName: serviceProvidersList[0].name,
      note: null);

  static final ExtraService _extraServiceTest2 = ExtraService(
      buyPrice: '15 \$',
      sellPrice: '20 \$',
      paymentStatus: PaymentStatus.notPaid,
      service: Services.docApproval,
      serviceProviderName: serviceProvidersList[1].name,
      note: null);

  static List<Transaction> transactionsList = [
    Transaction(
      isPinned: true,
      amount: 6000,
      customerType: CustomerType.referenced,
      paymentStatus: PaymentStatus.paid,
      referenceDetails: ReferenceDetails(
          note: 'some details',
          paymentBy: PaymentBy.reference,
          toRefPayment: PaymentStatus.partiallyPaid,
          reference: Agency(name: agenciesList[0].name, id: agenciesList[0].id),
          referencePortion: '300 tl'),
      dateTime: DateTime.now().add(const Duration(days: 1)),
      id: '2',
      customer: 'johny mice',
      note: 'note goes here',
      currency: Currency.eur,
      transactionType: TransactionType.legal,
      netProfit: 1800,
      noterDetails: null,
      extraServices: [
        _extraServiceTest,
        _extraServiceTest2,
      ],
    ),
    Transaction(
      id: '77',
      isPinned: true,
      customerType: CustomerType.direct,
      paymentStatus: PaymentStatus.paid,
      referenceDetails: null,
      amount: 7000,
      dateTime: DateTime.now().add(const Duration(days: 2)),
      customer: 'steven sigal',
      note: 'note goes here',
      currency: Currency.eur,
      transactionType: TransactionType.translation,
      netProfit: 2500,
      noterDetails: NoterDetails(
          noterProfit: 50,
          id: '39',
          noterFee: 200,
          noterPayment: NoterPayment.done),
      extraServices: [],
    ),

    Transaction(
      id: '85',
      isPinned: true,
      customerType: CustomerType.direct,
      paymentStatus: PaymentStatus.paid,
      referenceDetails: null,
      amount: 9000,
      dateTime: DateTime.now().add(const Duration(days: 1, minutes: 1)),
      customer: 'bruce wil',
      note: '150 tl noter',
      currency: Currency.usd,
      transactionType: TransactionType.translation,
      netProfit: 2500,
      noterDetails: NoterDetails(
          noterProfit: 50,
          id: '39',
          noterFee: 130,
          noterPayment: NoterPayment.done),
      extraServices: [
        ExtraService(
            buyPrice: '10\$',
            paymentStatus: PaymentStatus.paid,
            sellPrice: '15\$',
            service: Services.docApproval,
            serviceProviderName: serviceProvidersList.first.name),
        ExtraService(
            buyPrice: '10\$',
            paymentStatus: PaymentStatus.notPaid,
            sellPrice: '15\$',
            service: Services.docApproval,
            serviceProviderName: serviceProvidersList.last.name),
      ],
    ),
    Transaction(
      id: '123',
      isPinned: true,
      customerType: CustomerType.direct,
      paymentStatus: PaymentStatus.notPaid,
      referenceDetails: null,
      amount: 3000,
      dateTime: DateTime.now().add(const Duration(days: 1)),
      customer: 'dany ross',
      note: '150 tl noter',
      currency: Currency.usd,
      transactionType: TransactionType.translation,
      netProfit: 2500,
      noterDetails: NoterDetails(
          noterProfit: 50,
          id: '39',
          noterFee: 130,
          noterPayment: NoterPayment.done),
      extraServices: [
        ExtraService(
            buyPrice: '10\$',
            paymentStatus: PaymentStatus.paid,
            sellPrice: '15\$',
            service: Services.docApproval,
            serviceProviderName: serviceProvidersList.first.name),
        ExtraService(
            buyPrice: '10\$',
            paymentStatus: PaymentStatus.paid,
            sellPrice: '15\$',
            service: Services.docApproval,
            serviceProviderName: serviceProvidersList.last.name),
      ],
    ),
    Transaction(
      id: '3',
      isPinned: true,
      customerType: CustomerType.direct,
      paymentStatus: PaymentStatus.notPaid,
      referenceDetails: null,
      amount: 10000,
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      customer: 'monica dee',
      note: '150 tl noter',
      currency: Currency.eur,
      transactionType: TransactionType.visa,
      netProfit: 2500,
      noterDetails: NoterDetails(
          noterProfit: 50,
          id: '39',
          noterFee: 130,
          noterPayment: NoterPayment.notDone),
      extraServices: [
        ExtraService(
            buyPrice: '10\$',
            paymentStatus: PaymentStatus.paid,
            sellPrice: '15\$',
            service: Services.docApproval,
            serviceProviderName: serviceProvidersList.first.name),
      ],
    ),
    Transaction(
      isPinned: false,
      customerType: CustomerType.referenced,
      paymentStatus: PaymentStatus.notPaid,
      referenceDetails: null,
      amount: 8000,
      dateTime: DateTime.now().add(const Duration(days: 1)),
      id: '4',
      customer: 'sarah sugar',
      note: 'note goes here',
      currency: Currency.usd,
      transactionType: TransactionType.translation,
      netProfit: 1500,
      noterDetails: NoterDetails(
          noterProfit: 0,
          id: '39',
          noterFee: 350,
          noterPayment: NoterPayment.done),
      extraServices: [
        ExtraService(
            buyPrice: '15\$',
            paymentStatus: PaymentStatus.notPaid,
            sellPrice: '25\$',
            service: Services.docApproval,
            serviceProviderName: DummyData.serviceProvidersList.last.name),
      ],
    ),
    Transaction(
      isPinned: false,
      amount: 6300,
      customerType: CustomerType.referenced,
      paymentStatus: PaymentStatus.paid,
      referenceDetails: ReferenceDetails(
          note: 'some details',
          paymentBy: PaymentBy.reference,
          toRefPayment: PaymentStatus.partiallyPaid,
          reference: Agency(name: agenciesList[1].name, id: agenciesList[1].id),
          referencePortion: '300 €'),
      dateTime: DateTime.now().add(const Duration(days: 30)),
      id: '9',
      customer: 'jennifer free',
      note: 'note',
      currency: Currency.tl,
      transactionType: TransactionType.legal,
      netProfit: 1300,
      noterDetails: NoterDetails(
          noterProfit: 150,
          id: '7',
          noterFee: 400,
          noterPayment: NoterPayment.notDone),
      extraServices: null,
    ),
    Transaction(
      isPinned: false,
      customerType: CustomerType.direct,
      paymentStatus: PaymentStatus.partiallyPaid,
      referenceDetails: null,
      amount: 11000,
      dateTime: DateTime.now().subtract(const Duration(days: 30)),
      id: '10',
      customer: 'ahmet cuma',
      note: '250 tl noter',
      currency: Currency.tl,
      transactionType: TransactionType.visa,
      netProfit: 4000,
      noterDetails: NoterDetails(
          noterProfit: 0,
          id: '39',
          noterFee: 130,
          noterPayment: NoterPayment.done),
      extraServices: [],
    ),
    Transaction(
      isPinned: false,
      customerType: CustomerType.referenced,
      paymentStatus: PaymentStatus.notPaid,
      referenceDetails: ReferenceDetails(
          paymentBy: PaymentBy.client,
          reference: Agency(name: agenciesList[2].name, id: agenciesList[2].id),
          toRefPayment: PaymentStatus.notPaid,
          referencePortion: '400 \$'),
      amount: 17000,
      dateTime: DateTime.now().subtract(const Duration(days: 30)),
      id: '11',
      customer: 'mario',
      note: '1500 tl noter',
      currency: Currency.tl,
      transactionType: TransactionType.translation,
      netProfit: 7000,
      noterDetails: NoterDetails(
          noterProfit: 150,
          id: '39',
          noterFee: 1000,
          noterPayment: NoterPayment.done),
      extraServices: [
        ExtraService(
            buyPrice: '7\$',
            paymentStatus: PaymentStatus.notPaid,
            sellPrice: '10\$',
            service: Services.docApproval,
            serviceProviderName: DummyData.serviceProvidersList.last.name),
        ExtraService(
            buyPrice: '7\$',
            paymentStatus: PaymentStatus.partiallyPaid,
            sellPrice: '10\$',
            service: Services.healthInsurance,
            serviceProviderName: DummyData.serviceProvidersList.first.name)
      ],
    ),
    Transaction(
      isPinned: false,
      amount: 10000,
      customerType: CustomerType.direct,
      paymentStatus: PaymentStatus.paid,
      referenceDetails: null,
      dateTime: DateTime.now().subtract(const Duration(days: 60)),
      id: '13',
      currency: Currency.usd,
      customer: 'luigi',
      note: 'note goes here',
      transactionType: TransactionType.translation,
      netProfit: 3000,
      noterDetails: NoterDetails(
          noterProfit: 150,
          id: '7',
          noterFee: 2000,
          noterPayment: NoterPayment.notDone),
      extraServices: [
        ExtraService(
            buyPrice: '7\$',
            paymentStatus: PaymentStatus.partiallyPaid,
            sellPrice: '10\$',
            service: Services.healthInsurance,
            serviceProviderName: DummyData.serviceProvidersList.first.name),
      ],
    ),
    Transaction(
      isPinned: false,
      amount: 3000,
      customerType: CustomerType.referenced,
      paymentStatus: PaymentStatus.paid,
      referenceDetails: ReferenceDetails(
          note: 'some details',
          paymentBy: PaymentBy.reference,
          toRefPayment: PaymentStatus.partiallyPaid,
          reference: Agency(name: agenciesList[1].name, id: agenciesList[1].id),
          referencePortion: '300 tl'),
      dateTime: DateTime.now().subtract(const Duration(days: 90)),
      id: '14',
      customer: 'paul marco',
      note: '',
      currency: Currency.tl,
      transactionType: TransactionType.visa,
      netProfit: 1000,
      noterDetails: NoterDetails(
          noterProfit: 60,
          id: '7',
          noterFee: 400,
          noterPayment: NoterPayment.done),
      extraServices: [],
    ),
    Transaction(
      isPinned: false,
      customerType: CustomerType.direct,
      paymentStatus: PaymentStatus.partiallyPaid,
      referenceDetails: null,
      amount: 7000,
      dateTime: DateTime.now().subtract(const Duration(days: 92)),
      id: '15',
      customer: 'kate polo',
      note: 'note goes here',
      currency: Currency.eur,
      transactionType: TransactionType.other,
      netProfit: 2500,
      extraServices: [
        ExtraService(
            buyPrice: '10\$',
            paymentStatus: PaymentStatus.paid,
            sellPrice: '15\$',
            service: Services.docApproval,
            serviceProviderName: DummyData.serviceProvidersList.first.name)
      ],
    ),
    Transaction(
      isPinned: false,
      customerType: CustomerType.referenced,
      paymentStatus: PaymentStatus.notPaid,
      referenceDetails: null,
      amount: 5000,
      dateTime: DateTime.now().subtract(const Duration(days: 120)),
      id: '16',
      customer: 'halit sen',
      note: 'note goes here',
      currency: Currency.tl,
      transactionType: TransactionType.translation,
      netProfit: 1000,
      noterDetails: NoterDetails(
          noterProfit: 100,
          id: '39',
          noterFee: 320,
          noterPayment: NoterPayment.notDone),
      extraServices: [
        ExtraService(
            buyPrice: '7\$',
            paymentStatus: PaymentStatus.notPaid,
            sellPrice: '10\$',
            service: Services.docApproval,
            serviceProviderName: DummyData.serviceProvidersList.last.name),
      ],
    ),
    Transaction(
      isPinned: false,
      amount: 7000,
      customerType: CustomerType.direct,
      paymentStatus: PaymentStatus.paid,
      referenceDetails: null,
      dateTime: DateTime.now().subtract(const Duration(days: 120)),
      id: '17',
      currency: Currency.tl,
      customer: 'ali klay',
      note: 'note goes here',
      transactionType: TransactionType.translation,
      netProfit: 2250,
      noterDetails: NoterDetails(
          noterProfit: 150,
          id: '7',
          noterFee: 800,
          noterPayment: NoterPayment.notDone),
      extraServices: [],
    ),
    Transaction(
      isPinned: false,
      amount: 3000,
      customerType: CustomerType.referenced,
      paymentStatus: PaymentStatus.notPaid,
      referenceDetails: ReferenceDetails(
          note: 'some details',
          paymentBy: PaymentBy.reference,
          toRefPayment: PaymentStatus.partiallyPaid,
          reference: Agency(name: agenciesList[0].name, id: agenciesList[1].id),
          referencePortion: '100 €'),
      dateTime: DateTime.now().subtract(const Duration(days: 150)),
      id: '19',
      customer: 'didem kaya',
      note: '300 tl noter',
      currency: Currency.eur,
      transactionType: TransactionType.visa,
      netProfit: 1000,
      extraServices: [],
    ),

    ////////////////////////////////////////////////////////////////////////////
    Transaction(
      isPinned: false,
      amount: 30000,
      customerType: CustomerType.referenced,
      paymentStatus: PaymentStatus.paid,
      referenceDetails: ReferenceDetails(
          note: 'some details',
          paymentBy: PaymentBy.reference,
          toRefPayment: PaymentStatus.partiallyPaid,
          reference: Agency(name: 'kervan', id: '1'),
          referencePortion: '300 \$'),
      dateTime: DateTime.now().add(const Duration(days: 150)),
      id: '19',
      customer: 'mohamed ahmad',
      note: '150 tl noter',
      currency: Currency.eur,
      transactionType: TransactionType.legal,
      netProfit: 15000,
      extraServices: [],
    ),
    Transaction(
      isPinned: false,
      amount: 30000,
      customerType: CustomerType.referenced,
      paymentStatus: PaymentStatus.notPaid,
      referenceDetails: ReferenceDetails(
          note: 'some details',
          paymentBy: PaymentBy.reference,
          toRefPayment: PaymentStatus.partiallyPaid,
          reference: Agency(name: 'kervan', id: '1'),
          referencePortion: '300 ₺'),
      dateTime: DateTime.now().add(const Duration(days: 180)),
      id: '19',
      customer: 'mohamed ahmad',
      note: '150 tl noter',
      currency: Currency.eur,
      transactionType: TransactionType.legal,
      netProfit: 17000,
      extraServices: [],
    ),
    Transaction(
      isPinned: false,
      customerType: CustomerType.direct,
      paymentStatus: PaymentStatus.partiallyPaid,
      referenceDetails: null,
      amount: 20000,
      dateTime: DateTime.now().add(const Duration(days: 210)),
      id: '20',
      customer: 'wleed messi',
      note: '150 tl noter',
      currency: Currency.eur,
      transactionType: TransactionType.other,
      netProfit: 20000,
      noterDetails: NoterDetails(
          noterProfit: 0,
          id: '39',
          noterFee: 130,
          noterPayment: NoterPayment.done),
      extraServices: [
        ExtraService(
            buyPrice: '10\$',
            paymentStatus: PaymentStatus.paid,
            sellPrice: '15\$',
            service: Services.docApproval,
            serviceProviderName: DummyData.serviceProvidersList.first.name)
      ],
    ),
    Transaction(
      isPinned: false,
      customerType: CustomerType.direct,
      paymentStatus: PaymentStatus.notPaid,
      referenceDetails: null,
      amount: 10000,
      dateTime: DateTime.now().add(const Duration(days: 240)),
      id: '21',
      customer: 'wleed messi',
      note: '150 tl noter',
      currency: Currency.tl,
      transactionType: TransactionType.embassy,
      netProfit: 13000,
      noterDetails: NoterDetails(
          noterProfit: 0,
          id: '39',
          noterFee: 150,
          noterPayment: NoterPayment.done),
      extraServices: [
        ExtraService(
            buyPrice: '7\$',
            paymentStatus: PaymentStatus.notPaid,
            sellPrice: '10\$',
            service: Services.docApproval,
            serviceProviderName: DummyData.serviceProvidersList.last.name),
        ExtraService(
            buyPrice: '7\$',
            paymentStatus: PaymentStatus.partiallyPaid,
            sellPrice: '10\$',
            service: Services.healthInsurance,
            serviceProviderName: DummyData.serviceProvidersList.first.name)
      ],
    ),
    Transaction(
      isPinned: true,
      customerType: CustomerType.direct,
      paymentStatus: PaymentStatus.partiallyPaid,
      referenceDetails: null,
      amount: 10000,
      dateTime: DateTime.now().add(const Duration(days: 270)),
      id: '21',
      customer: 'wleed messi',
      note: '150 tl noter',
      currency: Currency.tl,
      transactionType: TransactionType.embassy,
      netProfit: 10000,
      noterDetails: NoterDetails(
          noterProfit: 0,
          id: '39',
          noterFee: 150,
          noterPayment: NoterPayment.done),
      extraServices: [
        ExtraService(
            buyPrice: '7\$',
            paymentStatus: PaymentStatus.notPaid,
            sellPrice: '10\$',
            service: Services.docApproval,
            serviceProviderName: DummyData.serviceProvidersList.last.name),
        ExtraService(
            buyPrice: '7\$',
            paymentStatus: PaymentStatus.partiallyPaid,
            sellPrice: '10\$',
            service: Services.healthInsurance,
            serviceProviderName: DummyData.serviceProvidersList.first.name)
      ],
    ),
    Transaction(
      isPinned: false,
      customerType: CustomerType.referenced,
      paymentStatus: PaymentStatus.notPaid,
      referenceDetails: null,
      amount: 10000,
      dateTime: DateTime.now().add(const Duration(days: 300)),
      id: '21',
      customer: 'wleed messi',
      note: '150 tl noter',
      currency: Currency.tl,
      transactionType: TransactionType.embassy,
      netProfit: 19000,
      noterDetails: NoterDetails(
          noterProfit: 0,
          id: '39',
          noterFee: 150,
          noterPayment: NoterPayment.done),
      extraServices: [
        ExtraService(
            buyPrice: '7\$',
            paymentStatus: PaymentStatus.notPaid,
            sellPrice: '10\$',
            service: Services.docApproval,
            serviceProviderName: DummyData.serviceProvidersList.last.name),
        ExtraService(
            buyPrice: '7\$',
            paymentStatus: PaymentStatus.partiallyPaid,
            sellPrice: '10\$',
            service: Services.healthInsurance,
            serviceProviderName: DummyData.serviceProvidersList.first.name)
      ],
    ),
    Transaction(
      isPinned: false,
      customerType: CustomerType.referenced,
      paymentStatus: PaymentStatus.notPaid,
      referenceDetails: null,
      amount: 12000,
      dateTime: DateTime.now().add(const Duration(days: 60)),
      id: '21',
      customer: 'wleed messi',
      note: '150 tl noter',
      currency: Currency.tl,
      transactionType: TransactionType.embassy,
      netProfit: 9000,
      noterDetails: NoterDetails(
          noterProfit: 0,
          id: '39',
          noterFee: 150,
          noterPayment: NoterPayment.done),
      extraServices: [
        ExtraService(
            buyPrice: '7\$',
            paymentStatus: PaymentStatus.notPaid,
            sellPrice: '10\$',
            service: Services.docApproval,
            serviceProviderName: DummyData.serviceProvidersList.last.name),
        ExtraService(
            buyPrice: '7\$',
            paymentStatus: PaymentStatus.paid,
            sellPrice: '10\$',
            service: Services.healthInsurance,
            serviceProviderName: DummyData.serviceProvidersList[1].name)
      ],
    ),
  ];

  static List<Noter> notersList = [
    Noter(id: '7', monthlyProfits: {'01-2023': 900}),
    Noter(id: '39', monthlyProfits: {'01-2023': 2000}),
  ];

  static List<Agency> agenciesList = [
    Agency(id: '1', name: 'kervan'),
    Agency(id: '2', name: 'gcs group'),
    Agency(id: '3', name: 'rgc office'),
  ];

  static List<ServiceProvider> serviceProvidersList = [
    ServiceProvider(
        id: '1',
        name: 'gcs group',
        services: [Services.appointments, Services.translation]),
    ServiceProvider(id: '2', name: 'kervan', services: [
      Services.healthInsurance,
      Services.docApproval,
      Services.translation
    ]),
    ServiceProvider(
        id: '3', name: 'rgc office', services: [Services.translation]),
  ];

  static List<Note> notesList = [
    Note(
        id: '0',
        title: 'Note Title',
        description: 'Note Description is to do or remind me about ...',
        priority: NotePriority.veryImportant,
        createdAt: DateFormat('yyyy-MM-dd').format(DateTime.now())),
    Note(
        id: '1',
        title: 'Note Title 2',
        description: 'Note Description is to do or remind me about ...',
        priority: NotePriority.important,
        createdAt: DateFormat('yyyy-MM-dd')
            .format(DateTime.now().add(const Duration(days: 1)))),
    Note(
        id: '2',
        title: 'Note Title 3',
        description: 'Note Description is to do or remind me about ...',
        priority: NotePriority.normal,
        createdAt: DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(const Duration(days: 1)))),
  ];
}
