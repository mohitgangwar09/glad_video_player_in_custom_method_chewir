part of 'dde_enquiry_cubit.dart';

enum DdeEnquiryStatus { initial, loading, success, error }

class DdeEnquiryState extends Equatable {

  final DdeEnquiryStatus status;
  final ResponseEnquiryModel? responseEnquiryModel;
  final ResponseEnquiryDetail? responseEnquiryDetail;
  final String? enquiryStatus,markAsClosed;

  const DdeEnquiryState({
    required this.status,
    this.responseEnquiryModel,
    this.enquiryStatus,
    this.responseEnquiryDetail,
    this.markAsClosed,
  });

  factory DdeEnquiryState.initial(){
    return DdeEnquiryState(
      status: DdeEnquiryStatus.initial,
      responseEnquiryModel: ResponseEnquiryModel(),
      enquiryStatus: "Pending",
      markAsClosed: "",
      responseEnquiryDetail: ResponseEnquiryDetail(),
    );
  }

  DdeEnquiryState copyWith({
    DdeEnquiryStatus? status,
    ResponseEnquiryModel? responseEnquiryModel,
    ResponseEnquiryDetail? responseEnquiryDetail,
    String? enquiryStatus,markAsClosed,
  }) {
    return DdeEnquiryState(
      status: status ?? this.status,
      responseEnquiryModel: responseEnquiryModel ?? this.responseEnquiryModel,
      responseEnquiryDetail: responseEnquiryDetail ?? this.responseEnquiryDetail,
      enquiryStatus: enquiryStatus ?? this.enquiryStatus,
      markAsClosed: markAsClosed ?? this.markAsClosed,
    );
  }

  @override
  List<Object?> get props =>[
    status,
    responseEnquiryModel,
    responseEnquiryDetail,
    enquiryStatus,
    markAsClosed
  ];

}