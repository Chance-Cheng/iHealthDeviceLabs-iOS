# iHealth Device Developer Documnentation
This document describes how to use the iHealth Device SDK to accomplish the major operation: Connection Device, Online Measurement, Offline Measurement and iHealth Device Management.

### Support iHealth Device for iOS

iHealth Bp3 
iHealth Bp5
iHealth Bp7
iHealth Bp3l
iHealth Abi
iHealth Hs3
iHealth Hs4
iHealth Hs4s
iHealth Hs5
iHealth Am3
iHealth Am3s
iHealth Po3
iHealth Bg1
iHealth Bg5

### Relevant files and frameworks
1、Import the following iHealthSDK files： BPHeader.h, BPMacroFile.h, BP3.h, BP3Controller.h, BP5.h, BP5Controller.h, BP7.h, BP7Controller.h,BP3L.h, BP3LController.h, ABI.h, ABIController.h, HSHeader.h、HSMacroFile.h、HS3.h、HS3Controller.h、HS4.h、HS4Controller.h、 HS5.h、HS5Controller.h、AMHeader.h、AMMacroFile.h、AM3.h、 AM3Controller.h、AM3S.h、AM3SController.h、User.h 、POHeader.h、POMacroFile.h、PO3.h、PO3Controller.h、iHealthLibrary.a，supports iOS 6.0 and above.

2、Frameworks

![box-model](https://github.com/iHealthDeviceLabs/iHealthDeviceLabs-iOS/blob/master/public/iOS_ihealth_Frameworks_doc.png?raw=true)

3、Configuration
Add 2 new Item in ‘Supported external accessory protocols’: com.jiuan.BPV20, com.jiuan.P930, com.jiuan.BPV21￼C.￼￼￼Add 1 new Item in ‘Required background modes’: App communicates with an accessory、 App communicates using CoreBluetooth![box-model](https://github.com/iHealthDeviceLabs/iHealthDeviceLabs-iOS/blob/master/public/iOS_ihealth_Configuration_doc.png?raw=true)
### How to use the iHealth SDK
##### 1. Operation procedure for BP3.
a) Register plug-in device info: `BP3ConnectNoti`;
b) Initialize controller classes:
```BP3Controller *controller = [BP3ControllershareBP3Controller];```c) Access control class instance after receive BP3ConnectNoti: 
 ```NSArray *bpDeviceArray = [controllergetAllCurrentBP3Instace];```
```BP3 *bpInstance = [bpDeviceArray objectAtIndex: 0];```
d) Using ‘bpInstance’ call communication module of the device

##### 2. Operation procedure for BP5.

a) Register plug-in device info: `BP5ConnectNoti`;
b) Initialize controller classes:
```BP5Controller *controller = [BP5ControllershareBP5Controller];```
c) Access control class instance after receive BP5ConnectNoti: 
```NSArray *bpDeviceArray = [controllergetAllCurrentBP5Instace];`````` BP5 *bpInstance = [bpDeviceArray objectAtIndex: i];```d) Using ‘bpInstance’ call communication module of the device
##### 3. Operation procedure for BP7.

a) Register plug-in device info: `BP7ConnectNoti`;
b) Initialize controller classes:
```BP7Controller *controller = [BP7ControllershareBP7Controller];```
c) Access control class instance after receive BP7ConnectNoti: 
```NSArray *bpDeviceArray = [controllergetAllCurrentBP7Instace];```
```BP7 *bpInstance = [bpDeviceArray objectAtIndex: i];```
d) Using ‘bpInstance’ call communication module of the device##### 4. Operation procedure for ABI.

For ABI Mesure(both arm and leg)
a) Register plug-in device info: `ABIConnectNoti`;

b) Initializedcontrollerclass:

```ABIController *controller = [ABIController       shareABIController];```
c) Access controller class instance after receive ABIConnectNoti:
```ABI *bpInstance = [controller getCurrentABIInstace];```
d) Using ‘bpInstance’ call communication module of the device.
For Arm Mesure(arm only)
a) Register plug-in device info: `ArmConnectNoti`; 

b) Initializedcontrollerclass:
```ABIController *controller = [ABIController           shareABIController];```
c) Access controller class instance after receive ArmConnectNoti:
```ABI *bpInstance = [controller getCurrentArmInstance];```
d) Using ‘bpInstance’ call communication module of the device.
##### 5. Operation procedure for BP3L.

a) Register plug-in device info: `BP3LConnectNoti`;

b) Initialize controller classes:

```BP3LController *controller = [BP3LController
shareBP3LController];```

c) Access control class instance after receive BP3LConnectNoti: 

```NSArray *bpDeviceArray = [controller
getAllCurrentBP3LInstace];```

```BP3L *bpInstance = [bpDeviceArray objectAtIndex: i];```

d) Using ‘bpInstance’ call communication module of the device

##### 6. Operation procedure for HS3.

a) Register plug-in device HS3 info: `HS3ConnectNoti`;

b) Initialize controller class:```HS3Controller*controller=[HS3Controller shareIHHs3Controller];```c) Access control class instance after receiving HS3Controller:
```NSArray *hsDeviceArray = [controller getAllCurrentHS3Instace];```
```HS3 *hsInstance = [hsDeviceArray objectAtIndex:i]; ```
d)Use hsInstance to call HS3 related communication methods.

##### 7. Operation procedure for HS4.
a) Register plug-in device HS4 info: `HS4ConnectNoti`;
b) Initialize HS4 controller class:
```HS4Controller*controller=[HS4Controller shareIHHs4Controller];```
c) Access control class instance after receiving HS4Controller:
```NSArray *hsDeviceArray = [controller getAllCurrentHS4Instace];```
```HS4 *hsInstance = [hsDeviceArray objectAtIndex:i];```
d) Use hsInstance to call HS4 related communication methods.
##### 8. Operation procedure for HS5.

a) Register plug-in device HS5 info: `HS5ConnectNoti`; 

b) Initialize HS5 controller class:```HS5Controller*controller=[HS5Controller shareIHHs5Controller];```
c) Access control class instance after receiving 
HS5Controller:```NSArray *hsDeviceArray = [controller getAllCurrentHS5Instace];```
```HS5 *hsInstance = [hsDeviceArray objectAtIndex:i];``` 
d) Use hsInstance to call HS5 related communication methods.
##### 9. Operation procedure for AM3.a) Register plug-in device AM3 info:`AM3ConnectNoti`; 
b) Initialize AM3 controller class:
```AM3Controller *controller = [AM3Controller shareIHAM3Controller];```c)Access control class instance after receiving 
AM3Controller:

```NSArray *amDeviceArray = [controller getAllCurrentAM3Instace];```

```AM3 *amInstance = [amDeviceArray objectAtIndex:i];```
d) Use amInstance to call AM3 related communication methods.
e) If already connected to the correct AM3, can stop connections to any other AM3's with the following API:
```[controller commandCanConnectAM:], ```
True: Can connect to AM3's. False: Stop connecting to other AM3's.
##### 10. Operation procedure for AM3S.a) Register plug-in device AM3S info:`AM3SConnectNoti`; 
b) Initialize AM3S controller class:
```AM3SController *controller = [AM3SController shareIHAM3SController];```c)Access control class instance after receiving 
AM3SController:

```NSArray *amDeviceArray = [controller getAllCurrentAM3SInstace];```

```AM3S *amInstance = [amDeviceArray objectAtIndex:i];```
d) Use amInstance to call AM3S related communication methods.
e) If already connected to the correct AM3S, can stop connections to any other AM3S's with the following API:
```[controller commandCanConnectAMS:], ```
True: Can connect to AM3S's. False: Stop connecting to other AM3S's.
##### 11. Operation procedure for PO3.a) Register plug-in device PO3 info:`PO3ConnectNoti`; 
b) Initialize PO3 controller class:
```PO3Controller *po3Controller = [PO3Controller shareIHPO3Controller];```c)Access control class instance after receiving 
PO3Controller:

```NSArray *po3Array = [po3Controller getAllCurrentPO3Instace];```

```PO3 *po3Instance =[po3Array objectAtIndex:i]```
d) Use amInstance to call PO3 related communication methods.
##### 12. Operation procedure for BG1.
a) Initialization for BG1 (connected BG via soundjack)
```AudioBG1Communication *audioBG1Communication=[AudioBG1Communication audioCommunicationObject];```
b) Using ‘audioBG1Communication’ to call the communication module of the device

##### 13. Operation procedure for BG5.
a) Initialization for BG5 (wireless BG viaBluetooth)
```BG5Controller *controller=[BG5Controller shareIHBg5Controller];```
``` BG5 *bg5=[[controller getAllCurrentBG5Instace] objectAtIndex:i];```
b)  Use amInstance to call bg5 related communication methods.## API Guide

[Click this link]()

## Examples[Click this link](https://github.com/iHealthDeviceLabs/iHealthDeviceLabs-iOS/tree/master/examples)
## Release Note

[Click this link]()
## FAQ

[Click this link]()





