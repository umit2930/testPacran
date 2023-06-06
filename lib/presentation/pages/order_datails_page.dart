import 'package:dobareh_bloc/business_logic/order_details/order_details_cubit.dart';
import 'package:dobareh_bloc/data/model/order/order_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  static Widget router({required int orderID}) {
    return BlocProvider(create: (context) {
      return OrderDetailsCubit(orderID);
    },child: const OrderDetailsPage(),);
  }

  @override
  Widget build(BuildContext context) {

    context.read<OrderDetailsCubit>().getOrderDetails();

    return Scaffold(
      body: Placeholder(),
    );
  }
}
