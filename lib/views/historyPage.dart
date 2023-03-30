import 'package:assignment3/bloc/app_bloc.dart';
import 'package:assignment3/bloc/app_state.dart';
import 'package:assignment3/dao/history_dao.dart';
import 'package:assignment3/entity/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatelessWidget {
  List<String> deserialize(History obj) {
    final items = obj.items.split(",").toList();
    return items;
  }

  Widget singleCheckout(History history, HistoryDAO dao) {
    final items = deserialize(history);
    final last = items.last;

    return Container(
      padding: const EdgeInsets.all(5),
      color: Colors.white70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("items list"),
              Text("items count: ${items.length - 1}"),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () async {
                  await dao.deleteHistory(history);
                },
              ),
            ],
          ),

          //
          const SizedBox(height: 20),

          //
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (int i = 0; i < items.length; i++)
                Row(
                  children: [
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.shopping_bag,
                      size: 24,
                    ),
                    const SizedBox(width: 20),
                    Text("${items[i]}"),
                  ],
                ),
            ],
          ),

          const SizedBox(height: 20),

          Text("total: \$${last}"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppBloc>().state as AppHistoryState;
    final dao = state.dao;

    return Scaffold(
      appBar: AppBar(title: const Text("history")),
      floatingActionButton: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Text("clear history"),
        ),
        onPressed: () async {
          await dao.deleteAllEmployee();
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder(
          stream: dao.getAllHistory(),
          builder: (context, snapshot) {
            //
            if (snapshot.hasError) {
              return const Center(child: Text("error"));
            } else if (snapshot.hasData) {
              var listHistory = snapshot.data as List<History>;

              return ListView.builder(
                itemCount: listHistory != null ? listHistory.length : 0,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      singleCheckout(listHistory[index], dao),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
