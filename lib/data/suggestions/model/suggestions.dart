class SuggestionResponse {
  final bool status;
  final String message;
  final Suggestion data;

  SuggestionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SuggestionResponse.fromJson(Map<String, dynamic> json) {
    return SuggestionResponse(
      status: json['status'],
      message: json['message'],
      data: Suggestion.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Suggestion {
  final int id;
  final String title;
  final String description;
  final int beneficiaryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Suggestion({
    required this.id,
    required this.title,
    required this.description,
    required this.beneficiaryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      beneficiaryId: json['beneficiary_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'beneficiary_id': beneficiaryId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
