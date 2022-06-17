#import "NativeLabel.h"

@interface UILabelWithCopyAndInsets : UILabel
@property (nonatomic, strong) UIView *overlayView;
- (id) initWithFrame:(CGRect)frame copyable:(BOOL)copyable;
- (void) setContentEdgeInsets:(UIEdgeInsets)edgeInsets;
@end

@implementation UILabelWithCopyAndInsets {
    float topInset, leftInset, bottomInset, rightInset;
    BOOL _copyable;
}

@synthesize overlayView = _overlayView;

- (BOOL)canBecomeFirstResponder {
    return _copyable;
}

- (id) initWithFrame:(CGRect)frame copyable:(BOOL)copyable {
    self = [super initWithFrame:frame];
    _copyable = copyable;
    if (_copyable) {
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(showMenu:)];
        [self addGestureRecognizer:recognizer];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideMenu:) name:UIMenuControllerWillHideMenuNotification object:nil];
    }
    return self;
}

- (void)copy:(id)sender
{
    [UIPasteboard generalPasteboard].string = self.text;
}

- (void)showMenu:(UIGestureRecognizer *)gestureRecognizer {
    if (!(gestureRecognizer.state == UIGestureRecognizerStateRecognized))
        return;

    CGRect frame = self.frame;
    
    frame.origin.x -= 3;
    frame.origin.y -= 1;
    frame.size.width += 6;
    frame.size.height += 6;
    
    self.overlayView = [[UIView alloc] initWithFrame: frame];
    
    [self.overlayView.layer setCornerRadius:3];
    [self.overlayView setBackgroundColor:[UIColor grayColor]];
    [self.overlayView setAlpha:0];
    [self.superview addSubview: self.overlayView];
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.overlayView setAlpha:0.2];
    }];
    
    [self becomeFirstResponder];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.frame inView:self.superview];
    [menu setMenuVisible:YES animated:YES];
}

- (void)willHideMenu:(NSNotification *)inNotification
{
    if (self.overlayView == nil)
    {
        return;
    }
    
    [UIView animateWithDuration:0.4 animations:^
     {
         [self.overlayView setAlpha:0.0];
     } completion:^(BOOL finished)
     {
         [self.overlayView removeFromSuperview];
         self.overlayView = nil;
     }];
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (_copyable && action == @selector(copy:)) {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset);
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize) intrinsicContentSize {
    CGSize intrinsicSuperViewContentSize = [super intrinsicContentSize];
    intrinsicSuperViewContentSize.width += leftInset + rightInset;
    intrinsicSuperViewContentSize.height += topInset + bottomInset;
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
    UILabelWithCopyAndInsets* _label;
    
    int64_t _viewId;
    FlutterMethodChannel* _channel;
    id _Nullable _args;

    float _containerWidth;
    UIEdgeInsets _edgeInsets;
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

        BOOL copyable = false;
        if (args[@"copyable"] && ![args[@"copyable"] isKindOfClass:[NSNull class]]) {
            copyable = [args[@"copyable"] boolValue];
        }

        _label = [[UILabelWithCopyAndInsets alloc] initWithFrame:frame copyable:copyable];
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
        if (args[@"fontName"] && ![args[@"fontName"] isKindOfClass:[NSNull class]]) {
            _label.font = [UIFont fontWithName:args[@"fontName"] size:scaledFontSize];
        } else {
            _label.font = [UIFont systemFontOfSize:scaledFontSize weight:fontWeight];
        }
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
        _edgeInsets = UIEdgeInsetsMake(edgeInsetTop, edgeInsetLeft, edgeInsetBottom, edgeInsetRight);
        [_label setContentEdgeInsets:_edgeInsets];

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
    if ([[call method] isEqualToString:@"getContentDimensions"]) {
        CGSize size = [_label intrinsicContentSize];
        if (size.width > _containerWidth) {
            CGSize boundSize = CGSizeMake(_containerWidth -  _edgeInsets.left - _edgeInsets.right, MAXFLOAT);
            size = [_label sizeThatFits: boundSize];
            float width = size.width + _edgeInsets.left + _edgeInsets.right;
            float height = size.height + _edgeInsets.top + _edgeInsets.bottom;
            size = CGSizeMake(width, height);
        }
        result(@[[NSNumber numberWithFloat: size.width], [NSNumber numberWithFloat:size.height]]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (UIView*)view {
    return _label;
}

@end
