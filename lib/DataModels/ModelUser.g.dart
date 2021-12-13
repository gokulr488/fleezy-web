// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ModelUser.dart';

// **************************************************************************
// CollectionGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

class _Sentinel {
  const _Sentinel();
}

const _sentinel = _Sentinel();

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class ModelUserCollectionReference
    implements
        ModelUserQuery,
        FirestoreCollectionReference<ModelUserQuerySnapshot> {
  factory ModelUserCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$ModelUserCollectionReference;

  static ModelUser fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return _$ModelUserFromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    ModelUser value,
    SetOptions? options,
  ) {
    return _$ModelUserToJson(value);
  }

  @override
  ModelUserDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<ModelUserDocumentReference> add(ModelUser value);
}

class _$ModelUserCollectionReference extends _$ModelUserQuery
    implements ModelUserCollectionReference {
  factory _$ModelUserCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$ModelUserCollectionReference._(
      firestore.collection('/Users/').withConverter(
            fromFirestore: ModelUserCollectionReference.fromFirestore,
            toFirestore: ModelUserCollectionReference.toFirestore,
          ),
    );
  }

  _$ModelUserCollectionReference._(
    CollectionReference<ModelUser> reference,
  ) : super(reference, reference);

  String get path => reference.path;

  @override
  CollectionReference<ModelUser> get reference =>
      super.reference as CollectionReference<ModelUser>;

  @override
  ModelUserDocumentReference doc([String? id]) {
    return ModelUserDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<ModelUserDocumentReference> add(ModelUser value) {
    return reference.add(value).then((ref) => ModelUserDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$ModelUserCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class ModelUserDocumentReference
    extends FirestoreDocumentReference<ModelUserDocumentSnapshot> {
  factory ModelUserDocumentReference(DocumentReference<ModelUser> reference) =
      _$ModelUserDocumentReference;

  DocumentReference<ModelUser> get reference;

  /// A reference to the [ModelUserCollectionReference] containing this document.
  ModelUserCollectionReference get parent {
    return _$ModelUserCollectionReference(reference.firestore);
  }

  @override
  Stream<ModelUserDocumentSnapshot> snapshots();

  @override
  Future<ModelUserDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  Future<void> update({
    String? uid,
    String roleName,
    String? fullName,
    String? userEmailId,
    String phoneNumber,
    String? password,
    List<String> companyId,
    String state,
    String? tripId,
  });

  Future<void> set(ModelUser value);
}

class _$ModelUserDocumentReference
    extends FirestoreDocumentReference<ModelUserDocumentSnapshot>
    implements ModelUserDocumentReference {
  _$ModelUserDocumentReference(this.reference);

  @override
  final DocumentReference<ModelUser> reference;

  /// A reference to the [ModelUserCollectionReference] containing this document.
  ModelUserCollectionReference get parent {
    return _$ModelUserCollectionReference(reference.firestore);
  }

  @override
  Stream<ModelUserDocumentSnapshot> snapshots() {
    return reference.snapshots().map((snapshot) {
      return ModelUserDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<ModelUserDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then((snapshot) {
      return ModelUserDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<void> delete() {
    return reference.delete();
  }

  Future<void> update({
    Object? uid = _sentinel,
    Object? roleName = _sentinel,
    Object? fullName = _sentinel,
    Object? userEmailId = _sentinel,
    Object? phoneNumber = _sentinel,
    Object? password = _sentinel,
    Object? companyId = _sentinel,
    Object? state = _sentinel,
    Object? tripId = _sentinel,
  }) async {
    final json = {
      if (uid != _sentinel) 'uid': uid as String?,
      if (roleName != _sentinel) 'roleName': roleName as String,
      if (fullName != _sentinel) 'fullName': fullName as String?,
      if (userEmailId != _sentinel) 'userEmailId': userEmailId as String?,
      if (phoneNumber != _sentinel) 'phoneNumber': phoneNumber as String,
      if (password != _sentinel) 'password': password as String?,
      if (companyId != _sentinel) 'companyId': companyId as List<String>,
      if (state != _sentinel) 'state': state as String,
      if (tripId != _sentinel) 'tripId': tripId as String?,
    };

    return reference.update(json);
  }

  Future<void> set(ModelUser value) {
    return reference.set(value);
  }

  @override
  bool operator ==(Object other) {
    return other is ModelUserDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

class ModelUserDocumentSnapshot extends FirestoreDocumentSnapshot {
  ModelUserDocumentSnapshot._(
    this.snapshot,
    this.data,
  );

  @override
  final DocumentSnapshot<ModelUser> snapshot;

  @override
  ModelUserDocumentReference get reference {
    return ModelUserDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final ModelUser? data;
}

abstract class ModelUserQuery
    implements QueryReference<ModelUserQuerySnapshot> {
  @override
  ModelUserQuery limit(int limit);

  @override
  ModelUserQuery limitToLast(int limit);

  ModelUserQuery whereUid({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  });
  ModelUserQuery whereRoleName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  ModelUserQuery whereFullName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  });
  ModelUserQuery whereUserEmailId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  });
  ModelUserQuery wherePhoneNumber({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  ModelUserQuery wherePassword({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  });
  ModelUserQuery whereCompanyId({
    List<String>? isEqualTo,
    List<String>? isNotEqualTo,
    List<String>? isLessThan,
    List<String>? isLessThanOrEqualTo,
    List<String>? isGreaterThan,
    List<String>? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? arrayContainsAny,
  });
  ModelUserQuery whereState({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  ModelUserQuery whereTripId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  });

  ModelUserQuery orderByUid({
    bool descending = false,
    String? startAt,
    String? startAfter,
    String? endAt,
    String? endBefore,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  });

  ModelUserQuery orderByRoleName({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  });

  ModelUserQuery orderByFullName({
    bool descending = false,
    String? startAt,
    String? startAfter,
    String? endAt,
    String? endBefore,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  });

  ModelUserQuery orderByUserEmailId({
    bool descending = false,
    String? startAt,
    String? startAfter,
    String? endAt,
    String? endBefore,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  });

  ModelUserQuery orderByPhoneNumber({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  });

  ModelUserQuery orderByPassword({
    bool descending = false,
    String? startAt,
    String? startAfter,
    String? endAt,
    String? endBefore,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  });

  ModelUserQuery orderByCompanyId({
    bool descending = false,
    List<String> startAt,
    List<String> startAfter,
    List<String> endAt,
    List<String> endBefore,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  });

  ModelUserQuery orderByState({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  });

  ModelUserQuery orderByTripId({
    bool descending = false,
    String? startAt,
    String? startAfter,
    String? endAt,
    String? endBefore,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  });
}

class _$ModelUserQuery extends QueryReference<ModelUserQuerySnapshot>
    implements ModelUserQuery {
  _$ModelUserQuery(
    this.reference,
    this._collection,
  );

  final CollectionReference<Object?> _collection;

  @override
  final Query<ModelUser> reference;

  ModelUserQuerySnapshot _decodeSnapshot(
    QuerySnapshot<ModelUser> snapshot,
  ) {
    final docs = snapshot.docs.map((e) {
      return ModelUserQueryDocumentSnapshot._(e, e.data());
    }).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return FirestoreDocumentChange<ModelUserDocumentSnapshot>(
        type: change.type,
        oldIndex: change.oldIndex,
        newIndex: change.newIndex,
        doc: ModelUserDocumentSnapshot._(change.doc, change.doc.data()),
      );
    }).toList();

    return ModelUserQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  @override
  Stream<ModelUserQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(_decodeSnapshot);
  }

  @override
  Future<ModelUserQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(_decodeSnapshot);
  }

  @override
  ModelUserQuery limit(int limit) {
    return _$ModelUserQuery(
      reference.limit(limit),
      _collection,
    );
  }

  @override
  ModelUserQuery limitToLast(int limit) {
    return _$ModelUserQuery(
      reference.limitToLast(limit),
      _collection,
    );
  }

  ModelUserQuery whereUid({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  }) {
    return _$ModelUserQuery(
      reference.where(
        'uid',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  ModelUserQuery whereRoleName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$ModelUserQuery(
      reference.where(
        'roleName',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  ModelUserQuery whereFullName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  }) {
    return _$ModelUserQuery(
      reference.where(
        'fullName',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  ModelUserQuery whereUserEmailId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  }) {
    return _$ModelUserQuery(
      reference.where(
        'userEmailId',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  ModelUserQuery wherePhoneNumber({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$ModelUserQuery(
      reference.where(
        'phoneNumber',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  ModelUserQuery wherePassword({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  }) {
    return _$ModelUserQuery(
      reference.where(
        'password',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  ModelUserQuery whereCompanyId({
    List<String>? isEqualTo,
    List<String>? isNotEqualTo,
    List<String>? isLessThan,
    List<String>? isLessThanOrEqualTo,
    List<String>? isGreaterThan,
    List<String>? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? arrayContainsAny,
  }) {
    return _$ModelUserQuery(
      reference.where(
        'companyId',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        arrayContainsAny: arrayContainsAny,
      ),
      _collection,
    );
  }

  ModelUserQuery whereState({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$ModelUserQuery(
      reference.where(
        'state',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  ModelUserQuery whereTripId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  }) {
    return _$ModelUserQuery(
      reference.where(
        'tripId',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  ModelUserQuery orderByUid({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('uid', descending: false);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ModelUserQuery(query, _collection);
  }

  ModelUserQuery orderByRoleName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('roleName', descending: false);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ModelUserQuery(query, _collection);
  }

  ModelUserQuery orderByFullName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('fullName', descending: false);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ModelUserQuery(query, _collection);
  }

  ModelUserQuery orderByUserEmailId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('userEmailId', descending: false);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ModelUserQuery(query, _collection);
  }

  ModelUserQuery orderByPhoneNumber({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('phoneNumber', descending: false);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ModelUserQuery(query, _collection);
  }

  ModelUserQuery orderByPassword({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('password', descending: false);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ModelUserQuery(query, _collection);
  }

  ModelUserQuery orderByCompanyId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('companyId', descending: false);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ModelUserQuery(query, _collection);
  }

  ModelUserQuery orderByState({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('state', descending: false);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ModelUserQuery(query, _collection);
  }

  ModelUserQuery orderByTripId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ModelUserDocumentSnapshot? startAtDocument,
    ModelUserDocumentSnapshot? endAtDocument,
    ModelUserDocumentSnapshot? endBeforeDocument,
    ModelUserDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('tripId', descending: false);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ModelUserQuery(query, _collection);
  }

  @override
  bool operator ==(Object other) {
    return other is _$ModelUserQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class ModelUserQuerySnapshot
    extends FirestoreQuerySnapshot<ModelUserQueryDocumentSnapshot> {
  ModelUserQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  final QuerySnapshot<ModelUser> snapshot;

  @override
  final List<ModelUserQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<ModelUserDocumentSnapshot>> docChanges;
}

class ModelUserQueryDocumentSnapshot extends FirestoreQueryDocumentSnapshot
    implements ModelUserDocumentSnapshot {
  ModelUserQueryDocumentSnapshot._(this.snapshot, this.data);

  @override
  final QueryDocumentSnapshot<ModelUser> snapshot;

  @override
  ModelUserDocumentReference get reference {
    return ModelUserDocumentReference(snapshot.reference);
  }

  @override
  final ModelUser data;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelUser _$ModelUserFromJson(Map<String, dynamic> json) => ModelUser(
      uid: json['uid'] as String?,
      roleName: json['roleName'] as String,
      fullName: json['fullName'] as String?,
      userEmailId: json['userEmailId'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String?,
      companyId:
          (json['companyId'] as List<dynamic>).map((e) => e as String).toList(),
      state: json['state'] as String,
      tripId: json['tripId'] as String?,
    );

Map<String, dynamic> _$ModelUserToJson(ModelUser instance) => <String, dynamic>{
      'uid': instance.uid,
      'roleName': instance.roleName,
      'fullName': instance.fullName,
      'userEmailId': instance.userEmailId,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'companyId': instance.companyId,
      'state': instance.state,
      'tripId': instance.tripId,
    };
