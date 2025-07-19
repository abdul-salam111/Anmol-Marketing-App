class Company {
  final String companyId;  // Keep as String if you want consistency
  final String companyName;
  final String companyLogo;

  Company({
    required this.companyId,
    required this.companyName,
    required this.companyLogo,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      // Convert int to String if needed
      companyId: json['companyId']?.toString() ?? '',
      companyName: json['companyName'] ?? '',
      companyLogo: json['companyLogo'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'companyName': companyName,
      'companyLogo': companyLogo,
    };
  }
}