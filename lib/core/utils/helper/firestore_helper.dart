import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static final instance = FirestoreHelper._();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Set Data in Firestore ---------------------------------------------------
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      final reference = _fireStore.doc(path);
      debugPrint('setData :: Request Data: $data');
      await reference.set(data);
    } catch (e) {
      rethrow;
    }
  }

  // Delete Data from Firestore -------------------------------------------
  Future<void> deleteData({
    required String path,
  }) async {
    try {
      final reference = _fireStore.doc(path);
      debugPrint('deleteData :: Path: $path');
      await reference.delete();
    } catch (e) {
      rethrow;
    }
  }

  // Get Document Stream from Firestore ----------------------------------
  Stream<T> documentsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    final reference = _fireStore.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) {
      return builder(snapshot.data(), snapshot.id);
    });
  }

  // Get Collection Stream from Firestore ---------------------------------
  Stream<List<T>> collectionsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = _fireStore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map(
            (snapshot) => builder(
              snapshot.data() as Map<String, dynamic>,
              snapshot.id,
            ),
          )
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }
}
