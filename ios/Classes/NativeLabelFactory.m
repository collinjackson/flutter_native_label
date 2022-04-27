#import "NativeLabelFactory.h"
#import "NativeLabel.h"

@implementation NativeLabelFactory {
    NSObject<FlutterBinaryMessenger>* _messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    self = [super init];
    if (self) {
        _messenger = messenger;
    }
    return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    NativeLabel* label = [[NativeLabel alloc] initWithFrame:frame
                                                     viewIdentifier:viewId
                                                          arguments:args
                                                    binaryMessenger:_messenger];
    return label;
}

@end
