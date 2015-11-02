#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

@synthesize robot;
@synthesize calibrateHandler;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    calibrateHandler = [[RUICalibrateGestureHandler alloc] initWithView:self.view];
    [[RKRobotDiscoveryAgent sharedAgent] addNotificationObserver:self selector:@selector(handleRobotStateChangeNotification:)];
}

- (void)appDidBecomeActive:(NSNotification *)notification {
    [RKRobotDiscoveryAgent startDiscovery];
}

- (void)appWillResignActive:(NSNotification *)notification {
    [RKRobotDiscoveryAgent stopDiscovery];
    [RKRobotDiscoveryAgent disconnectAll];
}

- (void)handleRobotStateChangeNotification:(RKRobotChangedStateNotification *)notification {

    switch (notification.type) {
        case RKRobotConnecting:
            break;
        case RKRobotOnline:
            robot = [[RKOllie alloc] initWithRobot:notification.robot];
            [calibrateHandler setRobot:robot.robot];
            break;
        case RKRobotDisconnected:
            [calibrateHandler setRobot:nil];
            robot = nil;
            [RKRobotDiscoveryAgent startDiscovery];
            break;
        default:
            break;
    }
}

- (IBAction)stopPressed:(id)sender {
    [robot stop];
}

- (IBAction)zeroPressed:(id)sender {
        [self moveToHeading:0.0 velocity:0.3];
}

- (IBAction)ninetyPressed:(id)sender {
        [self moveToHeading:90.0 velocity:0.3];
}

- (IBAction)oneEightyPressed:(id)sender {
        [self moveToHeading:180.0 velocity:0.3];
}

- (IBAction)twoSeventyPressed:(id)sender {
        [self moveToHeading:270.0 velocity:0.3];
}

- (IBAction)sliderValueChanged:(id)sender {
    [robot driveWithHeading:round(self.slider.value) andVelocity:0.0];
    NSLog(@"Slider: %f", self.slider.value);
}

-(void)moveToHeading:(float)heading velocity:(float)velocity {
    [robot driveWithHeading:heading andVelocity:velocity];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(stop:) userInfo:nil repeats:NO];
}

-(void)stop:(NSTimer *)timer {
    [robot stop];
}

@end
