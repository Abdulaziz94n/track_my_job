import 'package:flutter/material.dart';
import 'package:track_my_job/core/extensions/build_context_extension.dart';
import 'package:track_my_job/core/extensions/date_time_extension.dart';
import 'package:track_my_job/core/extensions/string_extension.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/enums/customer_type.dart';
import '../../../../models/transaction.dart';
import '../../../shared/app_card.dart';
import '../../../shared/app_text.dart';
import '../../../shared/spacing_widgets.dart';

class TransactionMainDetailsCard extends StatelessWidget {
  const TransactionMainDetailsCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
          textTheme: TextTheme(
              titleSmall: context.appTextTheme.titleSmall!
                  .copyWith(color: Colors.white))),
      child: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.only(top: Sizes.p16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.p20),
            child: AppCard(
              backgroundImage: 'card_background.jpg',
              height: context.screenHeight * 0.22,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Flexible(
                          child: AppText(
                              style: context.appTextTheme.titleSmall!
                                  .copyWith(fontSize: 22),
                              text: transaction
                                  .transactionType.type.capitalizeFirstOfEach),
                        ),
                        Flexible(
                          child: AppText(
                            style: context.appTextTheme.bodySmall!,
                            text: transaction.dateTime.dMyFromDateDotSeperated,
                          ),
                        ),
                      ],
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: AppText(
                              style: context.appTextTheme.titleSmall!,
                              text:
                                  transaction.customer!.capitalizeFirstOfEach),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: AppText(
                              style: context.appTextTheme.bodyLarge!,
                              text: CustomerType.getCustomerTypeTranslatedText(
                                  transaction.customerType)),
                        ),
                        Flexible(
                          child: AppText(
                              style: context.appTextTheme.bodyLarge!,
                              text:
                                  '${transaction.amount} ${transaction.currency.symbol}'),
                        ),
                      ],
                    ),
                    VerticalSpacingWidget(Sizes.p4)
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
