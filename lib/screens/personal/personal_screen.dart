import 'package:fakebook_frontend/blocs/personal_post/personal_post_bloc.dart';
import 'package:fakebook_frontend/blocs/personal_post/personal_post_event.dart';
import 'package:fakebook_frontend/blocs/post/post_bloc.dart';
import 'package:fakebook_frontend/models/post_model.dart';
import 'package:fakebook_frontend/screens/personal/widgets/friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fakebook_frontend/screens/personal/sub_screens/profile_settings_screen.dart';

import 'package:fakebook_frontend/screens/personal/widgets/personal_widgets.dart';
import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:fakebook_frontend/constants/localdata/local_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/personal_post/personal_post_state.dart';
import '../../common/widgets/bottom_loader.dart';
import '../../models/auth_user_model.dart';
import '../home/widgets/post_container.dart';

class PersonalScreen extends StatefulWidget {
  final String? accountId;

  PersonalScreen({this.accountId});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  final _scrollController = ScrollController();

  late final AuthUser authUser;
  late final String? accountId;
  late final String userId; // dùng chung cho cả mình và người khác
  late final bool isMe;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    authUser = BlocProvider.of<AuthBloc>(context).state.authUser;
    accountId = widget.accountId;
    userId = accountId ?? authUser.id;
    isMe = accountId != null ? false : true;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // if(currentScroll >= (maxScroll * 0.99)) print("POST OBSERVER: Bottom");
    return currentScroll >= (maxScroll * 0.95);
  }


  void _onScroll() {
    if (_isBottom){
      context.read<PersonalPostBloc>().add(PersonalPostFetched(accountId: userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("#PersonalScreen: $accountId");

    // final postList = BlocProvider.of<PostBloc>(context).state;
    // print("#PersonalScreen: " + postList.postList.toString());
    context.read<PersonalPostBloc>().add(PersonalPostReload(accountId: userId));
    context.read<PersonalPostBloc>().add(PersonalPostFetched(accountId: userId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return isMe ?
              Icon(Icons.menu, color: Colors.black, size: 30) :
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black)
              );
          },
        ),
        title: Text(
            currentUser.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        centerTitle: true
      ),
      body: RefreshIndicator(
        color: Colors.blue,
        backgroundColor: Colors.white,
        onRefresh: () async {
          context.read<PersonalPostBloc>().add(PersonalPostReload(accountId: userId));
          context.read<PersonalPostBloc>().add(PersonalPostFetched(accountId: userId));
          return Future<void>.delayed(const Duration(seconds: 2));
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250.0,
                    color: Colors.white,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => CoverBottomSheet());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 210.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                currentUser.imageUrl),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  Positioned(top: 160, left: 360, child: CameraButton()),
                  Positioned(
                      top: 80.0,
                      left: 20.0,
                      child: CircleAvatar(
                        radius: 85.0,
                        backgroundColor: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => AvatarBottomSheet());
                          },
                          child: CircleAvatar(
                            radius: 80.0,
                            backgroundImage:
                            CachedNetworkImageProvider(currentUser.imageUrl),
                          ),
                        ),
                      )),
                  Positioned(top: 200, left: 135, child: CameraButton())
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentUser.name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileSetScreen()));
                      },
                      child: ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10.0)),
                        child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 45.0,
                            color: Colors.grey[300],
                            child: const Text(
                              "Cài đặt trang cá nhân",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            )),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    const Divider(height: 10.0, thickness: 2),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Icon(Icons.cases_sharp),
                        const SizedBox(width: 10.0),
                        RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: "Sống và làm việc tại ",
                                  style:
                                  TextStyle(fontSize: 16.0, color: Colors.black)),
                              TextSpan(
                                  text: "Hà Nội",
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ]))
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const Divider(height: 10.0, thickness: 2),
                    const SizedBox(height: 10.0),
                    Row(
                      children: const [
                        Expanded(
                            child: Text(
                              "Friends",
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.bold),
                            )),
                        Text(
                          "Find Friends",
                          style: TextStyle(
                              fontSize: 17.0, color: Palette.facebookBlue),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                    Text("69 friends",
                        style:
                        TextStyle(fontSize: 17.0, color: Colors.grey[700])),
                    // Friend(friendName: "Hoang", imageUrl: currentUser.imageUrl)
                    const SizedBox(
                      height: 10.0,
                    ),
                    // Container(
                    //   height: 800.0,
                    //   child: GridView.count(
                    //     crossAxisCount: 3,
                    //     children: List.generate(6, (index) {
                    //       return Friend(friendName: "Friend $index",
                    //           imageUrl: currentUser.imageUrl);
                    //     }),
                    //   ),
                    // )
                    Container(
                      height: 300.0,
                      child: GridView.builder(
                        itemCount: 6,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height/1.5)),
                        itemBuilder: (context, index) {
                          return GridTile(
                            child: Friend(
                              friendName: "Friend $index", imageUrl: currentUser.imageUrl,
                            ),
                            // child: index%2 == 0?Container(color: Colors.red):Container(color: Colors.blue,)
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            PersonalPostList()
          ],
          controller: _scrollController,
        ),
      ),
    );
  }
}

class PersonalPostList extends StatefulWidget {
  const PersonalPostList({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalPostList> createState() => _PersonalPostListState();
}

class _PersonalPostListState extends State<PersonalPostList> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalPostBloc, PersonalPostState>(
        builder: (context, state) {
          // switch case hết giá trị thì BlocBuilder sẽ tự hiểu không bao giờ rơi vào trường hợp null ---> Siêu ghê
          switch (state.status) {
            case PersonalPostStatus.initial:
              return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
            case PersonalPostStatus.loading:
              return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
            case PersonalPostStatus.failure:
              return const SliverToBoxAdapter(child: Center(child: Text('Failed to fetch posts')));
            case PersonalPostStatus.success:
              return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return index >= state.postList.posts.length
                        ? const BottomLoader()
                        : PostContainer(post: state.postList.posts[index] as Post);
                  },
                      childCount: state.postList.posts.length)
              );
          // return const Center(child: Text('Successed to fetch posts'));
          }
        }
    );
  }
}