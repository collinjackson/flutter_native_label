#import "NativeLabel.h"

@implementation NativeLabel {
    UILabel* _label;
    
    int64_t _viewId;
    FlutterMethodChannel* _channel;
    id _Nullable _args;

    float _containerWidth;
}


- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    
    if ([super init]) {
        NSString* channelName = [NSString stringWithFormat:@"flutter_native_label%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        
        _viewId = viewId;
        _args = args;

        _label = [[UILabel alloc] initWithFrame:frame];
        _label.backgroundColor = UIColor.clearColor;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        _label.numberOfLines = 0;

        float fontSize = 16.0;
        float textScaleFactor = 1.0;
        if (args[@"fontSize"] && ![args[@"fontSize"] isKindOfClass:[NSNull class]]) {
            fontSize = [args[@"fontSize"] floatValue];
        }
        if (args[@"textScaleFactor"] && ![args[@"textScaleFactor"] isKindOfClass:[NSNull class]]) {
            textScaleFactor = [args[@"textScaleFactor"] floatValue];
        }
        float fontWeight = [args[@"fontWeight"] floatValue];
        float scaledFontSize = fontSize * textScaleFactor;
        _label.font = [UIFont systemFontOfSize:scaledFontSize weight:fontWeight];
        if (args[@"fontColor"] && ![args[@"fontColor"] isKindOfClass:[NSNull class]]) {
            NSDictionary* fontColor = args[@"fontColor"];
            UIColor *textColor = [UIColor colorWithRed:[fontColor[@"red"] floatValue]/255.0 green:[fontColor[@"green"] floatValue]/255.0 blue:[fontColor[@"blue"] floatValue]/255.0 alpha:[fontColor[@"alpha"] floatValue]/255.0];
            _label.textColor = textColor;
        }

        _label.text = args[@"text"];

        _containerWidth = [args[@"width"] floatValue];
        
        __weak __typeof__(self) weakSelf = self;
        [_channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
            [weakSelf onMethodCall:call result:result];
        }];
    }
    return self;
}

- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([[call method] isEqualToString:@"getContentHeight"]) {
        CGSize boundSize = CGSizeMake(_containerWidth, MAXFLOAT);
        CGSize size = [_label sizeThatFits: boundSize];
        result([NSNumber numberWithFloat: size.height]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (UIView*)view {
    return _label;
}

@end
