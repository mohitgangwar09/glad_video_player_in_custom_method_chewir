part of 'dde_enquiry_cubit.dart';

enum DdeEnquiryStatus { initial, loading, success, error }

class DdeEnquiryState extends Equatable {

  final DdeEnquiryStatus status;
  final ResponseEnquiryModel? responseEnquiryModel;
  final ResponseEnquiryDetail? responseEnquiryDetail;
  final String? enquiryStatus,markAsClosed;
  final Completer<GoogleMapController>? mapController;
  final Set<Marker> ? markers;

  const DdeEnquiryState({
    required this.status,
    this.responseEnquiryModel,
    this.enquiryStatus,
    this.responseEnquiryDetail,
    this.markAsClosed,
    this.mapController,
    this.markers,
  });

  factory DdeEnquiryState.initial(){
    return DdeEnquiryState(
      status: DdeEnquiryStatus.initial,
      responseEnquiryModel: ResponseEnquiryModel(),
      enquiryStatus: "Pending",
      markAsClosed: "",
      mapController:  Completer(),
      markers: const <Marker>{},
      responseEnquiryDetail: ResponseEnquiryDetail(),
    );
  }


  factory DdeEnquiryState.initialMap(){
    return DdeEnquiryState(
      status: DdeEnquiryStatus.initial,
      mapController:  Completer(),
      markers: const <Marker>{},
    );
  }

  DdeEnquiryState copyWith({
    DdeEnquiryStatus? status,
    ResponseEnquiryModel? responseEnquiryModel,
    ResponseEnquiryDetail? responseEnquiryDetail,
    String? enquiryStatus,markAsClosed,
    Completer<GoogleMapController>? mapController,
    Set<Marker>? markers ,
  }) {
    return DdeEnquiryState(
      status: status ?? this.status,
      responseEnquiryModel: responseEnquiryModel ?? this.responseEnquiryModel,
      responseEnquiryDetail: responseEnquiryDetail ?? this.responseEnquiryDetail,
      enquiryStatus: enquiryStatus ?? this.enquiryStatus,
      markAsClosed: markAsClosed ?? this.markAsClosed,
      mapController: mapController ?? this.mapController,
      markers: markers ?? this.markers,
    );
  }

  @override
  List<Object?> get props =>[
    status,
    responseEnquiryModel,
    responseEnquiryDetail,
    enquiryStatus,
    markAsClosed,
    mapController,
    markers
  ];

}