import 'package:flutter/material.dart';

const kbackground = Colors.white;
const kbutton = Color.fromARGB(255, 8, 206, 156);
const kbarColor = Color.fromARGB(255, 8, 206, 156);

const primaryColor=Color.fromRGBO(0, 197, 105, 1);

const CACHED_USER_DATA='CACHED_USER_DATA';
const TbarColor = Color.fromARGB(255, 137, 207, 190);

String rgbToHex(int r, int g, int b) {
  final hexR = r.toRadixString(16).padLeft(2, '0');
  final hexG = g.toRadixString(16).padLeft(2, '0');
  final hexB = b.toRadixString(16).padLeft(2, '0');
  return '#$hexR$hexG$hexB';
}

final String tableProduct ='Products';
final String columnName='name';
final String columnBarcode='barcode';


final String tableScanLocation ='ScanBarcodeLocation';
final String columnNameProLoc='name';
final String columnBarcodeLoc='barcode';
final String columnEmailLoc='email';
final String columnNameLoc='locationName';
final String columnDateLoc='date';


final String tableScanInventory ='ScanBarcodeInventory';
final String columnNameProInv='name';
final String columnBarcodeInv='barcode';
final String columnEmailInv='email';
final String columnNameInv='locationName';
final String columnDateInv='date';
final String columnCountInv='count';

final String tableLocation ='Location';
final String columnLocName='nameLoc';
final String columnLocNumber='numberLoc';
final String columnLocId='IdLoc';

final String tableInventory='Inventory';
final String columnInvName='nameLoc';
final String columnInvNumber='numberLoc';
final String columnInvId='IdLoc';