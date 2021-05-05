import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../app_pages.dart';
import '../../extensions/string_extensions.dart';
import '../../models/note.dart';
import '../../views/home/note_detail_view.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: Padding(
        padding: EdgeInsets.all(8),
        child: _buildNoteList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newNote = Note(
              color: colors[0],
              content: '',
              createdAt: DateTime.now().toString(),
              title: '',
              icon: '');
          Get.to(NoteDetailView(note: newNote), binding: HomeBinding());
        },
        child: Icon(CupertinoIcons.add),
      ),
    );
  }

  AppBar get _buildAppBar {
    return AppBar(
      elevation: 0,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      title: Text('NotePad'),
      centerTitle: true,
      leading: Icon(CupertinoIcons.person_alt_circle),
      actions: [
        IconButton(
            icon: Icon(CupertinoIcons.power),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.offNamed(AppRoutes.SIGN_IN);
            })
      ],
    );
  }

  Widget get _buildNoteList {
    return Obx(() => StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
          physics: BouncingScrollPhysics(),
          itemCount: controller.noteList.length,
          itemBuilder: (context, index) {
            return _buildNoteCard(controller.noteList[index]);
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(1, index.isEven ? 1.2 : 1.8),
        ));
  }

  Widget _buildNoteCard(Note note) {
    return Card(
        elevation: 2,
        child: InkWell(
          onTap: () {
            Get.to(NoteDetailView(note: note), binding: HomeBinding());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNoteCardTitle(note),
              const SizedBox(height: 4),
              Expanded(
                  child: Text(
                note.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                style: Get.textTheme.bodyText2,
              ).paddingAll(8))
            ],
          ),
        ));
  }

  Widget _buildNoteCardTitle(Note note) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: note.color.hexToColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          )),
      width: double.infinity,
      child: Row(
        children: [
          Icon((note.icon ?? '').iconData,
              color: Get.theme.colorScheme.onPrimary),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              note.title,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.subtitle1!
                  .copyWith(color: Get.theme.colorScheme.onPrimary),
            ),
          ),
          PopupMenuButton(
            tooltip: 'Daha Fazlası',
            onSelected: (value) => controller.deleteNote(note),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: 0, child: Text('Sil')),
            ],
          )
        ],
      ),
    );
  }
}
