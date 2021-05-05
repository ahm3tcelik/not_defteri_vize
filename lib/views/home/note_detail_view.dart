import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../extensions/string_extensions.dart';
import '../../helpers/validator.dart';
import '../../models/note.dart';
import 'home_controller.dart';

class NoteDetailView extends GetView<HomeController> with Validator {
  final Note note;
  late final TextEditingController titleController;
  late final TextEditingController contentController;
  final formKey = GlobalKey<FormState>();

  NoteDetailView({required this.note}) {
    titleController =
        TextEditingController.fromValue(TextEditingValue(text: note.title));
    contentController =
        TextEditingController.fromValue(TextEditingValue(text: note.content));
  }

  @override
  Widget build(BuildContext context) {

    ever(controller.noteList, (List<Note> notes) {
      // onChanged
      final index = notes.indexWhere((n) => n.id == note.id);
      if (index != -1) {
        titleController.text = notes[index].title;
        contentController.text = notes[index].content;
      }
    });

    return GetBuilder(
      init: controller,
      global: true,
      builder: (_) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: note.color.hexToColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Get.height * 0.15,
                alignment: Alignment.center,
                child: _buildTopBar,
              ),
              SizedBox(height: Get.height * 0.05, child: _buildIcons),
              const SizedBox(height: 8.0),
              Expanded(child: _buildContainer),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildTopBar {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        icon: Icon(CupertinoIcons.back, color: Get.theme.colorScheme.onPrimary),
        onPressed: () => Get.back(),
      ),
      title: Text('NotePad',
          style: Get.textTheme.headline6!.copyWith(
              color: Get.theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold)),
      trailing: IconButton(
        icon: Icon(CupertinoIcons.floppy_disk,
            color: Get.theme.colorScheme.onPrimary),
        onPressed: () => controller.saveNote(
          note
            ..title = titleController.text
            ..content = contentController.text
        ),
      ),
    );
  }

  Widget get _buildContainer {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        color: Get.theme.colorScheme.background,
      ),
      padding: const EdgeInsets.all(8),
      child: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.05, child: _buildColors),
              const SizedBox(height: 16.0),
              _buildTextTitle,
              const SizedBox(height: 16.0),
              _buildTextContent
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildTextTitle {
    return TextFormField(
        controller: titleController,
        validator: validateDefault,
        maxLength: null,
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(
          hintText: 'Başlık',
          border: InputBorder.none,
        ),
        style: Get.textTheme.headline5!.copyWith(
          color: note.color.hexToColor,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget get _buildTextContent {
    return TextFormField(
      validator: validateDefault,
      textInputAction: TextInputAction.newline,
      maxLines: null,
      decoration: InputDecoration(
        isCollapsed: true,
        hintText: 'Not...',
        border: InputBorder.none,
      ),
      controller: contentController,
      textAlign: TextAlign.justify,
    );
  }

  Widget get _buildColors {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        for (String color in colors)
          _buildColorItem(color, controller.isColorSelected(note, color)),
      ],
    );
  }

  Widget _buildColorItem(String color, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.hexToColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        icon: isSelected
            ? Icon(Icons.colorize, color: Get.theme.colorScheme.onPrimary)
            : SizedBox(),
        onPressed: () => controller.selectColor(note, color),
      ),
    );
  }

  Widget get _buildIcons {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        for (String icon in icons)
          _buildIconItem(icon, controller.isIconSelected(note, icon))
      ],
    );
  }

  Widget _buildIconItem(String icon, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? Get.theme.colorScheme.onPrimary
            : note.color.hexToColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        icon: isSelected
            ? Icon(icon.iconData, color: note.color.hexToColor)
            : Icon(icon.iconData, color: Get.theme.colorScheme.onPrimary),
        onPressed: () => controller.selectIcon(note, icon),
      ),
    );
  }
}
