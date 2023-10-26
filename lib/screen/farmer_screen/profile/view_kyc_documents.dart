import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/data/model/farmer_profile_model.dart';
import 'package:glad/screen/custom_widget/container_border.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/screen/dde_screen/dde_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class ViewKYCDocuments extends StatefulWidget {
  const ViewKYCDocuments({super.key, required this.farmerDocuments});
  final dynamic farmerDocuments;

  @override
  State<ViewKYCDocuments> createState() => _ViewKYCDocumentsState();
}

class _ViewKYCDocumentsState extends State<ViewKYCDocuments> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Column(
            children: [
              CustomAppBar(
                context: context,
                titleText1: 'KYC documents',
                titleText1Style:
                figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                centerTitle: true,
                leading: arrowBackButton(),
                description: 'Provide the following details',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      10.verticalSpace(),
                      Center(
                        child: ClipOval(
                          clipper: MyClip(),
                          child: SizedBox(
                            height: 180,
                            width: 190,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.transparent,
                                  )),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: widget.farmerDocuments.profilePic!,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      SvgPicture.asset(Images.uploadPP),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      40.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hint: 'Select Address Proof',
                                enabled: false,
                                controller: TextEditingController()..text = widget.farmerDocuments.docName!,
                                // itemList: const [
                                //   "Utility Bill",
                                //   "Bank Statement",
                                //   "Lease Agreement"
                                // ],
                                // onChanged: (String? value) {
                                // },
                                // image2: Images.arrowDropdown,
                                // image2Colors: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hint: 'Doc. No.',
                                controller: TextEditingController()..text = widget.farmerDocuments.docNo!,
                                hintStyle: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black),
                                readOnly: true,
                              ),
                            ),
                            10.horizontalSpace(),
                            Expanded(
                              child: CustomTextField(
                                hint: 'Exp. Date',
                                hintStyle: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black),
                                image2: Images.calender,
                                controller: TextEditingController()..text = widget.farmerDocuments.docExpiryDate! == '0000-00-00' ? '': widget.farmerDocuments.docExpiryDate!,
                                image2Colors: ColorResources.maroon,
                                readOnly: true,
                                focusNode: FocusNode(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            20.verticalSpace(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                for (DocumentFiles image in widget.farmerDocuments.documentFiles!)
                                  Row(
                                    children: [
                                      viewDocumentImage(image.fullUrl!, isPDF: widget.farmerDocuments.docName == 'Bank Statement'),
                                      10.horizontalSpace(),
                                    ],
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                      40.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hint: 'Select ID Proof',
                                readOnly: true,
                                controller: TextEditingController()..text = widget.farmerDocuments.docType!,
                                // dropdownValue: widget.farmerDocuments.docType,
                                // itemList: const [
                                //   // "Passport", "NIC"
                                // ],
                                // onChanged: (String? value) {
                                // },
                                // icon: Images.arrowDropdown,
                                // iconColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hint: 'Doc. No.',
                                controller: TextEditingController()..text = widget.farmerDocuments.docTypeNo!,
                                hintStyle: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black),
                                readOnly: true,
                              ),
                            ),
                            10.horizontalSpace(),
                            Expanded(
                              child: CustomTextField(
                                hint: 'Exp. Date',
                                controller: TextEditingController()..text = widget.farmerDocuments.docTypeExpiryDate!,
                                hintStyle: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black),
                                image2: Images.calender,
                                image2Colors: ColorResources.maroon,
                                readOnly: true,
                                focusNode: FocusNode(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            20.verticalSpace(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (DocumentTypeFiles image in widget.farmerDocuments.documentTypeFiles!)
                                  Row(
                                    children: [
                                      viewDocumentImage(image.fullUrl!),
                                      10.horizontalSpace(),
                                    ],
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // 40.verticalSpace(),
                      40.verticalSpace(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
