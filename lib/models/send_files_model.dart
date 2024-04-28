class SendFilesModel {
  final String name;
  final String type;
  final String description;
  final String networkUrl;
  final String imageUrl;
  final String? qrCode;
  final bool emailLink;

  SendFilesModel({
    required this.name,
    required this.type,
    required this.description,
    required this.networkUrl,
    required this.imageUrl,
    this.qrCode,
    required this.emailLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'description': description,
      'networkUrl': networkUrl,
      'imageUrl': imageUrl,
      'qrCode': qrCode,
      'emailLink': emailLink,
    };
  }
}
