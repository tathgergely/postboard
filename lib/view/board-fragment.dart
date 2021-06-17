import 'package:flutter/material.dart';
import 'package:postboard/model/post.dart';
import 'package:postboard/view/card/incoming-message-card.dart';
import 'package:postboard/view/card/outgoing-message-card.dart';
import 'package:postboard/view/edit-fragment.dart';
import 'package:postboard/view/element/circle-social-avatar.dart';
import 'package:postboard/view/element/rounded-button.dart';
import 'package:postboard/view/element/rounded-textfield.dart';
import 'package:postboard/viewmodel/board-viewmodel.dart';
import 'package:provider/provider.dart';

class BoardFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Body(Provider.of<BoardViewModel>(context));
  }
}

class _Body extends StatelessWidget {
  final BoardViewModel vm;
  final TextEditingController controller = TextEditingController();

  _Body(this.vm);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new Flexible(
          child: _PostsContainer(vm),
          flex: 8,
        ),
        new Flexible(
          child: Row(
            children: [
              new Flexible(
                  child: new RoundedTextField(
                      controller: controller,
                      stream: vm.newPost,
                      onChange: vm.changeNewPost,
                      hintText: 'Type message'),
                  flex: 5),
              StreamBuilder(
                  stream: vm.newPostValid,
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    bool isEnabled = snapshot.hasData ? snapshot.data! : false;
                    return Flexible(
                        child: new RoundedButton(
                            text: 'Send',
                            press: () {
                              vm.submitNewPost();
                              controller.clear();
                            },
                            isEnabled: isEnabled),
                        flex: 1);
                  })
            ],
          ),
          flex: 1,
        )
      ],
    );
  }
}

class _PostsContainer extends StatelessWidget {
  final BoardViewModel vm;

  _PostsContainer(this.vm);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: vm.getPosts,
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            final List<Post> posts = snapshot.data!;
            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  Post post = posts[index];
                  return vm.isOutGoing(post)
                      ? _showMenu(new OutGoingMessageCard(post: post), vm, post)
                      : IncomingMessageCard(
                          post: post,
                          avatar: post.sender.imageUrl != "asset"
                              ? CircleSocialAvatar.url(
                                  imgUrl: post.sender.imageUrl)
                              : CircleSocialAvatar.asset(
                                  imageAsset: "assets/images/avatar.png"));
                });
          } else {
            return Center(
              child: Text("Loading"),
            );
          }
        });
  }
}

class _showMenu extends StatelessWidget {
  Widget child;
  BoardViewModel vm;
  Post post;

  _showMenu(this.child, this.vm, this.post);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: child,
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          new PopupMenuItem(
            child: new InkWell(
              child: new Text("Delete"),
              onTap: () {
                vm.deletePost(post);
              },
            ),
          ),
          post.hidden
              ? new PopupMenuItem(
                  child: new InkWell(
                    child: new Text("Reveal"),
                    onTap: () {
                      vm.revealPost(post);
                      Navigator.pop(context);
                    },
                  ),
                )
              : new PopupMenuItem(
                  child: new InkWell(
                    child: new Text("Hide"),
                    onTap: () {
                      vm.hidePost(post);
                      Navigator.pop(context);
                    },
                  ),
                ),
          new PopupMenuItem(
            child: new InkWell(
                child: new Text("Edit"),
                onTap: () {
                  Navigator.of(context).pop(context);
                  print("Test");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => EditFragment(vm, post)),
                  );

                }),
          )
        ];
      },
    );
  }
}
