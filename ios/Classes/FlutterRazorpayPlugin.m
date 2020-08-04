#import "FlutterRazorpayPlugin.h"
#if __has_include(<flutter_razorpay/flutter_razorpay-Swift.h>)
#import <flutter_razorpay/flutter_razorpay-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_razorpay-Swift.h"
#endif

@implementation FlutterRazorpayPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterRazorpayPlugin registerWithRegistrar:registrar];
}
@end
