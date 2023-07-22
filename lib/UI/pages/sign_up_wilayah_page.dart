import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salvapp_amcc/UI/pages/sign_up_set_profil.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../blocs/shared/shared_methods.dart';
import '../../common/common.dart';
import '../../models/city_model.dart';

import '../../models/provinces_model.dart';
import '../../models/sign_up_form_model.dart';
import '../../models/subdistricts_model.dart';
import '../../models/ward_model.dart';
import '../../services/region_service.dart';
import '../widgets/buttons.dart';
import '../widgets/forms.dart';

class SignupWilayahPage extends StatefulWidget {
  final SignupFormModel? data;
  static const routeName = '/singupwilayah';
  const SignupWilayahPage({super.key, required this.data});

  @override
  State<SignupWilayahPage> createState() => _SignupWilayahPageState();
}

class _SignupWilayahPageState extends State<SignupWilayahPage> {
  dynamic provinceValuess;
  dynamic provinceGetId;
  dynamic selectedProvince;

  dynamic cityValue;
  dynamic cityGetId;
  dynamic selectedCity;

  dynamic subdistrictValue;
  dynamic subdistrictGetId;
  dynamic selectedSubdistrict;

  dynamic wardValue;
  dynamic wardGetId;
  dynamic selectedWard;

  final TextEditingController kodeposController =
      TextEditingController(text: '');
  final TextEditingController alamatLengkapController =
      TextEditingController(text: '');

  late Future<Provinsi> provinceList;
  late Future<Kota> cityList;
  late Future<Kecamatan> kecamatanList;
  bool? isloading = false;

  //Geolocator
  Position? currentPositions;
  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<Kota> getCities(dynamic provId) async {
    dynamic listCity;
    await RegionService().getCity(int.parse(provId)).then((value) {
      setState(() {
        listCity = value;
      });
    });
    return listCity;
  }

  Future<Kecamatan> getSubDistricts(dynamic cityId) async {
    dynamic listSubdistricts;
    await RegionService().getSubDistrict(int.parse(cityId)).then((value) {
      setState(() {
        listSubdistricts = value;
      });
    });
    return listSubdistricts;
  }

  Future<Kelurahan> getWards(dynamic subDistrictId) async {
    dynamic listWards;
    await RegionService().getWard(int.parse(subDistrictId)).then((value) {
      setState(() {
        listWards = value;
      });
    });
    return listWards;
  }

  // kelurahanList = RegionService().getWard(widget.data.KecamatanId);

  bool validate() {
    if (widget.data!.type == "buyer") {
      if (selectedProvince == null ||
          selectedCity == null ||
          selectedWard == null ||
          kodeposController.text == "" ||
          alamatLengkapController.text == "" ||
          selectedSubdistrict == null ||
          _currentPosition == null) {
        return false;
      }
      return true;
    } else {
      if (selectedProvince == null || selectedCity == null) {
        return false;
      }
      return true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provinceList = RegionService().getProvinces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Daftar")),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            child: ListView(children: [
              Container(
                color: greenColor,
                width: double.infinity,
                height: 227,
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Masukkan Informasi lebih \nlanjut terkait lokasi anda",
                            style: whiteTextStyle.copyWith(fontSize: 20),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            "Informasi lokasi memudahkan \ninteraksi pembeli dan penjual limbah makanan",
                            style: whiteTextStyle.copyWith(fontSize: 12),
                          )
                        ],
                      )
                    ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TimelineTile(
                                indicatorStyle: IndicatorStyle(
                                  color: greenColor,
                                ),
                                afterLineStyle: LineStyle(color: greenColor),
                                isFirst: true,
                                axis: TimelineAxis.horizontal,
                                alignment: TimelineAlign.center,
                                endChild: Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                  constraints: const BoxConstraints(),
                                  child: Wrap(children: [
                                    Text(
                                      "Informasi Dasar",
                                      style: greenTextStyle,
                                    )
                                  ]),
                                ),
                                startChild: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                ),
                              ),
                              TimelineTile(
                                indicatorStyle: IndicatorStyle(
                                  color: greyColor,
                                ),
                                
                                axis: TimelineAxis.horizontal,
                                alignment: TimelineAlign.center,
                                endChild: Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                  constraints: const BoxConstraints(),
                                  child: Wrap(children: [
                                    Text(
                                      "Lokasi",
                                      style: greenTextStyle,
                                    )
                                  ]),
                                ),
                                startChild: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                ),
                              ),
                              TimelineTile(
                                indicatorStyle: IndicatorStyle(
                                  color: greyColor,
                                ),
                                isLast: true,
                                axis: TimelineAxis.horizontal,
                                alignment: TimelineAlign.center,
                                endChild: Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                  constraints: const BoxConstraints(),
                                  child: Wrap(children: [
                                    Text(
                                      "Foto Profil",
                                      style: greenTextStyle,
                                    )
                                  ]),
                                ),
                                startChild: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 44,
                        ),
                        Container(
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomFormField(
                                  isShowTitle: false,
                                  title: "Alamat Lengkap",
                                  controller: alamatLengkapController,
                                ),
                                const SizedBox(
                                  height: 17,
                                ),
                                CustomFormField(
                                  isShowTitle: false,
                                  title: "Kode Pos",
                                  keyBoardType: TextInputType.number,
                                  controller: kodeposController,
                                ),
                                const SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  "Provinsi",
                                  style: blackTextStyle.copyWith(
                                      fontWeight: regular, fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  child: FutureBuilder(
                                    future: provinceList,
                                    builder: ((context,
                                        AsyncSnapshot<Provinsi> snapshot) {
                                      var state = snapshot.connectionState;
                                      if (state != ConnectionState.done) {
                                        return DropdownButtonFormField(
                                          hint: Text("Tunggu Sebentar.."),
                                          decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    color: greenColor,
                                                    width: 2.0),
                                              ),
                                              focusColor: greenColor,
                                              contentPadding:
                                                  const EdgeInsets.all(12),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          items: [],
                                          onChanged: (value) {},
                                        );
                                      } else {
                                        if (snapshot.hasData) {
                                          return DropdownButtonFormField(
                                            hint: selectedProvince == null
                                                ? Text("Pilih Provinsi")
                                                : Text(selectedProvince
                                                    .toString()),
                                            value: selectedProvince,
                                            isExpanded: true,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedProvince = value;
                                                selectedProvince.toString();
                                                provinceGetId =
                                                    selectedProvince.id;
                                                selectedCity = null;
                                                cityValue =
                                                    getCities(provinceGetId);
                                              });
                                            },
                                            decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  borderSide: BorderSide(
                                                      color: greenColor,
                                                      width: 2.0),
                                                ),
                                                focusColor: greenColor,
                                                contentPadding:
                                                    const EdgeInsets.all(12),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            items: snapshot.data!.provinsiValue
                                                .map((val) {
                                              return DropdownMenuItem(
                                                value: val,
                                                child: Text(
                                                  val.name,
                                                ),
                                              );
                                            }).toList(),
                                          );
                                        } else if (snapshot.hasError) {
                                          return DropdownButtonFormField(
                                            hint: Text("No Internet"),
                                            decoration: InputDecoration(
                                                focusColor: greenColor,
                                                contentPadding:
                                                    const EdgeInsets.all(12),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            items: [],
                                            onChanged: (value) {},
                                          );
                                        } else {
                                          return const Material(
                                            child: Text(""),
                                          );
                                        }
                                      }
                                    }),
                                  ),
                                ),
                                const SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  "Kota",
                                  style: blackTextStyle.copyWith(
                                      fontWeight: regular, fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                    child: selectedProvince != null
                                        ? FutureBuilder<Kota>(
                                            future: cityValue,
                                            builder: ((context, snapshot) {
                                              if (snapshot.connectionState !=
                                                  ConnectionState.done) {
                                                return DropdownButtonFormField(
                                                  hint:
                                                      Text("Tunggu Sebentar.."),
                                                  decoration: InputDecoration(
                                                      focusColor: greenColor,
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8))),
                                                  items: [],
                                                  onChanged: (value) {},
                                                );
                                              } else if (snapshot.hasData) {
                                                return DropdownButtonFormField(
                                                    decoration: InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide: BorderSide(
                                                              color: greenColor,
                                                              width: 2.0),
                                                        ),
                                                        focusColor: greenColor,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8))),
                                                    hint: selectedCity == null
                                                        ? Text("Pilih Kota")
                                                        : Text(
                                                            "${selectedCity.name}"),
                                                    isExpanded: true,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down),
                                                    value: selectedCity,
                                                    iconSize: 30,
                                                    elevation: 16,
                                                    items: snapshot.data!.value
                                                        .map<
                                                                DropdownMenuItem<
                                                                    KotaValue>>(
                                                            (KotaValue value) {
                                                      return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value
                                                              .name!
                                                              .toString()));
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        // cityData = getCities(provId);
                                                        selectedCity = value;
                                                        selectedCity.toString();
                                                        cityGetId =
                                                            selectedCity.id;
                                                        subdistrictValue =
                                                            getSubDistricts(
                                                                cityGetId);
                                                        selectedSubdistrict =
                                                            null;
                                                      });
                                                    });
                                              } else if (snapshot.hasError) {
                                                return DropdownButtonFormField(
                                                  hint: Text("No Internet"),
                                                  decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide: BorderSide(
                                                            color: greenColor,
                                                            width: 2.0),
                                                      ),
                                                      focusColor: greenColor,
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8))),
                                                  items: [],
                                                  onChanged: (value) {},
                                                );
                                              }

                                              return CircularProgressIndicator();
                                            }))
                                        : DropdownButtonFormField(
                                            hint: Text("Provinsi belum diisi"),
                                            decoration: InputDecoration(
                                                focusColor: greenColor,
                                                contentPadding:
                                                    const EdgeInsets.all(12),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            items: [],
                                            onChanged: (value) {},
                                          )),
                                const SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  "Kecamatan",
                                  style: blackTextStyle.copyWith(
                                      fontWeight: regular, fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                    child: selectedCity != null
                                        ? FutureBuilder<Kecamatan>(
                                            future: subdistrictValue,
                                            builder: ((context, snapshot) {
                                              if (snapshot.connectionState !=
                                                  ConnectionState.done) {
                                                return DropdownButtonFormField(
                                                  hint:
                                                      Text("Tunggu Sebentar.."),
                                                  decoration: InputDecoration(
                                                      focusColor: greenColor,
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8))),
                                                  items: [],
                                                  onChanged: (value) {},
                                                );
                                              } else if (snapshot.hasData) {
                                                return DropdownButtonFormField(
                                                    decoration: InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide: BorderSide(
                                                              color: greenColor,
                                                              width: 2.0),
                                                        ),
                                                        focusColor: greenColor,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8))),
                                                    hint: selectedSubdistrict ==
                                                            null
                                                        ? Text(
                                                            "Pilih Kecamatan")
                                                        : Text(
                                                            "${selectedSubdistrict}"),
                                                    isExpanded: true,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down),
                                                    value: selectedSubdistrict,
                                                    iconSize: 30,
                                                    elevation: 16,
                                                    items: snapshot.data!.value.map<
                                                            DropdownMenuItem<
                                                                KecamatanValue>>(
                                                        (KecamatanValue value) {
                                                      return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value.name
                                                              .toString()));
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedSubdistrict =
                                                            value;
                                                        selectedSubdistrict
                                                            .toString();
                                                        wardValue = getWards(
                                                            selectedSubdistrict
                                                                .id);
                                                        selectedWard = null;
                                                      });
                                                    });
                                              } else if (snapshot.hasError) {
                                                return DropdownButtonFormField(
                                                  hint: Text("No Internet"),
                                                  decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide: BorderSide(
                                                            color: greenColor,
                                                            width: 2.0),
                                                      ),
                                                      focusColor: greenColor,
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8))),
                                                  items: [],
                                                  onChanged: (value) {},
                                                );
                                              }

                                              return CircularProgressIndicator();
                                            }))
                                        : DropdownButtonFormField(
                                            hint: Text("Kota belum diisi"),
                                            decoration: InputDecoration(
                                                focusColor: greenColor,
                                                contentPadding:
                                                    const EdgeInsets.all(12),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            items: [],
                                            onChanged: (value) {},
                                          )),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Kelurahan",
                                      style: blackTextStyle.copyWith(
                                          fontWeight: regular, fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 17,
                                ),
                                Container(
                                    child: selectedSubdistrict != null
                                        ? FutureBuilder(
                                            future: wardValue,
                                            builder: ((context,
                                                AsyncSnapshot<Kelurahan>
                                                    snapshot) {
                                              var state =
                                                  snapshot.connectionState;
                                              if (state !=
                                                  ConnectionState.done) {
                                                return DropdownButtonFormField(
                                                  hint:
                                                      Text("Tunggu Sebentar.."),
                                                  decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide: BorderSide(
                                                            color: greenColor,
                                                            width: 2.0),
                                                      ),
                                                      focusColor: greenColor,
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8))),
                                                  items: [],
                                                  onChanged: (value) {},
                                                );
                                              } else {
                                                if (snapshot.hasData) {
                                                  return DropdownButtonFormField(
                                                    hint: selectedWard == null
                                                        ? Text(
                                                            "Pilih Kelurahan")
                                                        : Text(selectedWard
                                                            .toString()),
                                                    value: selectedWard,
                                                    isExpanded: true,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedWard = value;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide: BorderSide(
                                                              color: greenColor,
                                                              width: 2.0),
                                                        ),
                                                        focusColor: greenColor,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8))),
                                                    items: snapshot
                                                        .data!.kelurahanvalue
                                                        .map((val) {
                                                      return DropdownMenuItem(
                                                        value: val,
                                                        child: Text(
                                                          val.name,
                                                        ),
                                                      );
                                                    }).toList(),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                      child: Material(
                                                    child: Text(snapshot.error
                                                        .toString()),
                                                  ));
                                                } else {
                                                  return const Material(
                                                    child: Text(""),
                                                  );
                                                }
                                              }
                                            }),
                                          )
                                        : DropdownButtonFormField(
                                            hint: Text("Kecamatan belum diisi"),
                                            decoration: InputDecoration(
                                                focusColor: greenColor,
                                                contentPadding:
                                                    const EdgeInsets.all(12),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            items: [],
                                            onChanged: (value) {},
                                          )),
                                if (widget.data!.type == "buyer") ...[
                                  const SizedBox(
                                    height: 17,
                                  ),
                                  Text(
                                    "Ambil Lokasi Anda",
                                    style: blackTextStyle.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 60,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    whiteColor),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ))),
                                        onPressed: () async {
                                          //Location
                                          // await getLocation().then((value) {
                                          //   print(value);
                                          // });
                                          setState(() {
                                            isloading = true;
                                          });
                                          await _getCurrentPosition();

                                          setState(() {
                                            isloading = false;
                                          });
                                          print(_currentPosition!.latitude
                                              .toString());
                                          print(_currentPosition!.longitude
                                              .toString());
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Row(children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.black45,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    (_currentPosition == null &&
                                                            isloading == false)
                                                        ? "Ketuk untuk mengambil lokasi anda"
                                                        : (_currentPosition !=
                                                                    null &&
                                                                isloading ==
                                                                    false)
                                                            ? _currentAddress
                                                                .toString()
                                                            : (isloading ==
                                                                    true)
                                                                ? "Mengambil.."
                                                                : "",
                                                    style:
                                                        greyTextStyle.copyWith(
                                                            fontWeight: medium,
                                                            fontSize: 14),
                                                  ),
                                                )
                                              ]),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                                const SizedBox(
                                  height: 35,
                                ),
                                CustomFilledButton(
                                  title: "Selanjutnya",
                                  onPressed: () {
                                    if (validate()) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignupSetProfilPage(
                                                data: widget.data!.copyWith(
                                                    latitude:
                                                        _currentPosition == null
                                                            ? 0
                                                            : _currentPosition
                                                                ?.latitude,
                                                    longitude:
                                                        _currentPosition == null
                                                            ? 0
                                                            : _currentPosition
                                                                ?.longitude,
                                                    province: selectedProvince
                                                        .name
                                                        .toString(),
                                                    city: selectedCity.name
                                                        .toString(),
                                                    ward: selectedWard.name,
                                                    postal_code:
                                                        kodeposController.text,
                                                    address:
                                                        alamatLengkapController
                                                            .text,
                                                    subdistrict:
                                                        selectedSubdistrict.name
                                                            .toString())),
                                          ));
                                      //
                                    } else {
                                      showCustomSnacKbar(
                                          context, "Form tidak boleh kosong");
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 17,
                                )
                              ]),
                        ),
                      ]),
                ),
              ),
            ]),
          ),
        ));
  }
}
