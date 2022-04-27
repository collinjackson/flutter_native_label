#import "NativeLabelPlugin.h"
#import "NativeLabelFactory.h"

@implementation NativeLabelPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    NativeLabelFactory* labelFactory =
        [[NativeLabelFactory alloc] initWithMessenger:registrar.messenger];

    [registrar registerViewFactory:labelFactory
                            withId:@"flutter_native_label"];
}

@end
