import 'package:firebase_database/firebase_database.dart';
import 'package:realtime_fcs/model/notes_model.dart';

class FCService {
  //? instance
  static final DatabaseReference ref = FirebaseDatabase.instance.ref();

//! create a new instance

  static Future<void> create(
      {required String dbPaht,
      //required String childPath,
      required Map<String, dynamic> data}) async {
    // ignore: unused_local_variable
    String? childPath = ref.child(dbPaht).push().key;
    await ref.child(dbPaht).child(childPath!).set(data);
  }

  //! read a new instance

  static Future<List<DataSnapshot>> read({
    required String parentPath,
  }) async {
    // ignore: unused_local_variable
    List<DataSnapshot> list = [];
    //? api dagi ma'lumotlar path i
    final parentp = ref.child(parentPath);
    //? api dagi ma'lumotlarni o'qish metodi 1 marotaba
    // ignore: unused_local_variable
    DatabaseEvent databaseEvent = await parentp.once();
    //? parent path ichidagi m'lumotlar
    final childp = databaseEvent.snapshot.children;
    for (var e in childp) {
      list.add(e);
    }
    return list;
  }

  //! delete a notes model

  static Future<void> delete({required String id}) async {
    ref.child('notes').child(id).remove();
  }

  //! update a notes model
  static Future<void> update(
      {required NotesModel data, required String id}) async {
    await ref.child('notes').child(id).update(
          data.toJson(),
        );
  }
}
