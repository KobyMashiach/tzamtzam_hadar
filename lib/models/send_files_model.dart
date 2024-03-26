class SendFilesModel {
  final String name;
  final String type;
  final String networkUrl;
  final String imageUrl;
  final String? qrCode;

  SendFilesModel(
      {required this.name,
      required this.type,
      required this.networkUrl,
      required this.imageUrl,
      this.qrCode});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'networkUrl': networkUrl,
      'imageUrl': imageUrl,
      'qrCode': qrCode,
    };
  }
}
