# iHealth Device Developer 


###Latest version: 2.0


###Documnentation
This document describes how to use the iHealth Device SDK to accomplish the major operation: Connection Device, Online Measurement, Offline Measurement and iHealth Device Management.

### Support iHealth Device for iOS

    BP: 
    iHealth Bp3    iHealth Bp5   iHealth Bp7   iHealth Bp7S   iHealth Bp3l   iHealth KD926 iHealth KN550BT iHealth Abi 
    
    HS: 
    iHealth Hs3    iHealth Hs4   iHealth Hs4s(Same with Hs4)   iHealth Hs5  
    
    AM: 
    iHealth Am3    iHealth Am3s   iHealth Am4  
         
    BG: 
    iHealth Bg1    iHealth Bg5     
    
    PO: 
    iHealth Po3     




### Relevant files and frameworks
1、Import the following iHealthSDK files：   


    BP: 
    BPHeader.h、 BPMacroFile.h、 BP3.h、 BP3Controller.h, BP5.h、BP5Controller.h、 BP7.h、 BP7Controller.h、BP3L.h、 BP3LController.h、 ABI.h, ABIController.h、BP7S.h、BP7SController.h、KD926.h、KD926Controller.h、KN550BT.h、KN550BTController.h  
    
    
	HS: 
	HSHeader.h、HSMacroFile.h、HS3.h、HS3Controller.h、HS4.h、HS4Controller.h、 HS5.h、HS5Controller.h、
	
	AM: 
	AMHeader.h、AMMacroFile.h、AM3.h、 AM3Controller.h、AM3S.h、AM3SController.h、AM4.h、AM4Controller.h、
	
	PO: 
	POHeader.h、POMacroFile.h、PO3.h、PO3Controller.h、
	
	BG: 
	BGHeader.h、BGMacroFile.h、BG5.h、BG5Controller.h、AudioBG1Communication.h
	
	Common: 
	User.h、ConnectDeviceController.h、ScanDeviceController.h、HSHeader.h
	
	Library: iHealthLibrary.a、
	
	supports iOS 7.0 and above.

2、Frameworks

![box-model](https://github.com/iHealthDeviceLabs/iHealthDeviceLabs-iOS/blob/master/public/iOS_ihealth_Frameworks_doc.png?raw=true)

3、Configuration


Add 2 new Item in ‘Supported external accessory protocols’: com.jiuan.BPV20, com.jiuan.P930, com.jiuan.BPV21,com.jiuan.BGV30,com.jiuan.BGV31,com.ihealth.sc221￼
￼￼￼Add 1 new Item in ‘Required background modes’: App communicates with an accessory、 App communicates using CoreBluetooth![box-model](https://github.com/iHealthDeviceLabs/iHealthDeviceLabs-iOS/blob/master/public/iOS_ihealth_Configuration_doc.png?raw=true)

### How to apply for SDK permissions

[Click this link](https://github.com/iHealthDeviceLabs/iHealthDeviceLabs-iOS/blob/master/doc/Developer_Registration_Application_Instruction.md)
### How to use the iHealth SDK
``` 1. Operation procedure for BP3.
```Reference BP5```

 2. Operation procedure for BP5.

	a) Register plug-in device info: `BP5ConnectNoti`;
	b) Initialize controller classes:
	```BP5Controller *controller = [BP5ControllershareBP5Controller];```
	c) Access control class instance after receive `BP5ConnectNoti`: 
	```NSArray *bpDeviceArray = [controllergetAllCurrentBP5Instace];```	``` BP5 *bpInstance = [bpDeviceArray objectAtIndex: i];```	d) Using ‘bpInstance’ call communication module of the device
 3. Operation procedure for BP7.

	```Reference BP5```
 4. Operation procedure for ABI.

	For ABI Mesure(both arm and leg)
	a) Register plug-in device info: `ABIConnectNoti`;
	b) Initializedcontrollerclass:

	```ABIController *controller = [ABIController       shareABIController];```
	c) Access controller class instance after receive `ABIConnectNoti`:
	```ABI *bpInstance = [controller getCurrentABIInstace];```
	d) Using ‘bpInstance’ call communication module of the device.
	
	For Arm Mesure(arm only)
	a) Register plug-in device info: `ArmConnectNoti`; 

	b) Initializedcontrollerclass:
	```ABIController *controller = [ABIController           shareABIController];```
	c) Access controller class instance after receive ArmConnectNoti:
	```ABI *bpInstance = [controller getCurrentArmInstance];```
	d) Using ‘bpInstance’ call communication module of the device.
 5. Operation procedure for BP3L.

	a) Register plug-in device info: `BP3LDiscover`;

	b) Start scan BP3L

	``` [[ScanDeviceController commandGetInstance]commandScanDeviceType:HealthDeviceType_BP3L] ```

	c) Register plug-in device info: `BP3LConnectFailed`、`BP3LConnectNoti`、	`BP3LDisConnectNoti`;

	d) Connect BP3L after receive `BP3LDiscover`

	``` [[ScanDeviceController commandGetInstance]commandStopScanDeviceType:HealthDeviceType_BP3L] ```


	``` [[ConnectDeviceController commandGetInstance]commandContectDeviceWithDeviceType:HealthDeviceType_BP3L andSerialNub:serialNub] ```

	e) Access control class instance after receive `BP3LConnectNoti`: 

	```BP3LController *controller = [BP3LController
shareBP3LController];```
	```  NSArray *bpDeviceArray = [controller
getAllCurrentBP3LInstace]; ```

	```BP3L *bpInstance = [bpDeviceArray objectAtIndex: i];```

	f) Using ‘bpInstance’ call communication module of the device

 6. Operation procedure for BP7S、KN550BT、KD926、

	```Reference BP3L```

 7. Operation procedure for HS3.

	```Reference BP5```
 8. Operation procedure for HS4.

	```Reference BP3L```
 9. Operation procedure for HS5.

	```Reference BP5```
 10. Operation procedure for AM3.	```Reference BP3L```
 11. Operation procedure for AM3S.	```Reference BP3L```
 12. Operation procedure for AM4.	```Reference BP3L```
 13. Operation procedure for PO3.	```Reference BP3L```
 14. Operation procedure for BG1.
	a) Initialization for BG1 (connected BG via soundjack)
	```AudioBG1Communication *audioBG1Communication=[AudioBG1Communication audioCommunicationObject];```
	b) Using ‘audioBG1Communication’ to call the communication module of the device

 15. Operation procedure for BG5.
	```Reference BP5``````
## API Guide

[Click this link](https://github.com/iHealthDeviceLabs/iHealthDeviceLabs-iOS/tree/master/api-docs)

## Examples[Click this link](https://github.com/iHealthDeviceLabs/iHealthDeviceLabs-iOS/tree/master/examples)
## Release Note

[Click this link](https://github.com/iHealthDeviceLabs/iHealthDeviceLabs-iOS/blob/master/doc/ReleaseNote.md)
## FAQ

[Click this link](https://github.com/iHealthDeviceLabs/iHealthDeviceLabs-iOS/blob/master/doc/FAQ.md)





