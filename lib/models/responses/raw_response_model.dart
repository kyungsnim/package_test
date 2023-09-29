class RawResponseModel {
  final int? status;
  final int? statusCode; /// TODO ... delete one
  final String? message;
  final dynamic data;
  RawResponseModel(this.status, this.statusCode, this.message, this.data);

  RawResponseModel.fromJson(Map<String, dynamic> data)
      : status = data['statusCode'],
        statusCode = data['statusCode'],
        message = data['message'],
        data = data['data'];
}