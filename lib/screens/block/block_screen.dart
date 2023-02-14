import 'package:fakebook_frontend/blocs/block/block_bloc.dart';
import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:fakebook_frontend/screens/block/widgets/block_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fakebook_frontend/blocs/block/block_bloc.dart';
import 'package:fakebook_frontend/blocs/block/block_state.dart';
import 'package:fakebook_frontend/blocs/block/block_event.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BlockScreen extends StatelessWidget {
  const BlockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BlockedAccountsBloc>(context).add(BlockedAccountsFetched());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: const Text('Block', style: TextStyle(color: Colors.black)),
        ),
        body: BlocBuilder<BlockedAccountsBloc, BlockedAccountsState>(
            builder: (context, state) {
          return Column(
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Danh sách chặn ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                "(${state.blockedAccounts?.length.toString() ?? ''})",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              )
                            ],
                          )),
                    ],
                  )),
              BlockList()
            ],
          );
        }));
  }
}

class BlockList extends StatefulWidget {
  const BlockList({
    Key? key,
  }) : super(key: key);

  @override
  State<BlockList> createState() => _BlockListState();
}

class _BlockListState extends State<BlockList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlockedAccountsBloc, BlockedAccountsState>(
        builder: (context, state) {
      // switch case hết giá trị thì BlocBuilder sẽ tự hiểu không bao giờ rơi vào trường hợp null ---> Siêu ghê
      switch (state.blockedAccountsStatus) {
        case BlockedAccountsStatus.initial:
          return Center(child: CircularProgressIndicator());
        case BlockedAccountsStatus.loading:
          return Center(child: CircularProgressIndicator());
        case BlockedAccountsStatus.failure:
          return Center(child: Text('Failed to fetch posts'));
        case BlockedAccountsStatus.success:
          return Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: ListView.builder(
                  itemCount: state.blockedAccounts?.length,
                  itemBuilder: (context, index) {
                    final item = state.blockedAccounts?[index];
                    final time = DateTime.parse(item?.createdAt as String);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ProfileAvatar(
                            imageUrl: item?.userHeader.avatar as String),
                        const SizedBox(width: 12.0),
                        Expanded(
                            child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(item?.userHeader.name as String,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.black)),
                            SizedBox(height: 5),
                            Text(
                              'Blocked at ${time.hour.toString()}:${time.minute.toString()} ngày ${time.day}/${time.month}/${time.year}',
                              style: TextStyle(color: Palette.grey2),
                            ),
                          ],
                        )),
                      ],
                    );
                  }),
            ),
          );
        // return const Center(child: Text('Successed to fetch posts'));
      }
    });
  }
}
