#import "NativeLabel.h"

@interface UILabelWithInsets : UILabel
- (void) setContentEdgeInsets:(UIEdgeInsets)edgeInsets;
@end

@implementation UILabelWithInsets {
    float topInset, leftInset, bottomInset, rightInset;
}

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset);
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize) intrinsicContentSize {
    CGSize intrinsicSuperViewContentSize = [super intrinsicContentSize];
    intrinsicSuperViewContentSize.height += topInset + bottomInset;
    intrinsicSuperViewContentSize.width += leftInset + rightInset;
    return intrinsicSuperViewContentSize;
}

- (void) setContentEdgeInsets:(UIEdgeInsets)edgeInsets {
    topInset = edgeInsets.top;
    leftInset = edgeInsets.left;
    rightInset = edgeInsets.right;
    bottomInset = edgeInsets.bottom;
    [self invalidateIntrinsicContentSize];
}
@end

@implementation NativeLabel {
    UILabelWithInsets* _label;
    
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

        _label = [[UILabelWithInsets alloc] initWithFrame:frame];
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

        NSString *text = args[@"text"];
        NSMutableAttributedString *attributedText =
            [[NSMutableAttributedString alloc] initWithString:text];

        if (args[@"lineSpacing"] && ![args[@"lineSpacing"] isKindOfClass:[NSNull class]]) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = [args[@"lineSpacing"] floatValue];
            [attributedText addAttribute:NSParagraphStyleAttributeName
                                   value:paragraphStyle
                                   range:NSMakeRange(0, [text length])];
        }

        if (args[@"kern"] && ![args[@"kern"] isKindOfClass:[NSNull class]]) {
            [attributedText addAttribute:NSKernAttributeName
                        value:args[@"kern"]
                        range:NSMakeRange(0, [text length])];
        }

        float edgeInsetTop = 0.0;
        if (args[@"edgeInsetTop"] && ![args[@"edgeInsetTop"] isKindOfClass:[NSNull class]]) {
            edgeInsetTop = [args[@"edgeInsetTop"] floatValue];
        }
        float edgeInsetBottom = 0.0;
        if (args[@"edgeInsetBottom"] && ![args[@"edgeInsetBottom"] isKindOfClass:[NSNull class]]) {
            edgeInsetBottom = [args[@"edgeInsetBottom"] floatValue];
        }
        float edgeInsetLeft = 0.0;
        if (args[@"edgeInsetLeft"] && ![args[@"edgeInsetLeft"] isKindOfClass:[NSNull class]]) {
            edgeInsetLeft = [args[@"edgeInsetLeft"] floatValue];
        }
        float edgeInsetRight = 0.0;
        if (args[@"edgeInsetRight"] && ![args[@"edgeInsetRight"] isKindOfClass:[NSNull class]]) {
            edgeInsetRight = [args[@"edgeInsetRight"] floatValue];
        }
        [_label setContentEdgeInsets:UIEdgeInsetsMake(edgeInsetTop, edgeInsetLeft, edgeInsetBottom, edgeInsetRight)];

        _label.attributedText = attributedText;

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
