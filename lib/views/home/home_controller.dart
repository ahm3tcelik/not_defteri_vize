import 'package:get/get.dart';

import '../../data/dao.dart';
import '../../data/db_helper.dart';
import '../../models/note.dart';

class HomeController extends GetxController {
  var noteList = <Note>[].obs;
  final noteDao = Dao.instance(DbHelper.instance);

  @override
  void onInit() {
    loadNotes();
    super.onInit();
  }

  Future<void> loadNotes() async {
    noteList.value = await noteDao.getAll();
  }

  void selectColor(Note note, String color) {
    note.color = color;
    refresh();
  }

  void selectIcon(Note note, String icon) {
    note.icon = icon;
    refresh();
  }

  Future<void> saveNote(Note note) async {
    // CREATE
    if (note.id == null) {
      await noteDao.create(note);
    }
    // UPDATE
    else {
      await noteDao.saveNote(note);
    }
    await loadNotes();
  }

  Future<void> deleteNote(Note note) async {
    await noteDao.delete(note);
    await loadNotes();
  }

  bool isColorSelected(Note note, String color) {
    return note.color == color;
  }

  bool isIconSelected(Note note, String icon) {
    return note.icon == icon;
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
