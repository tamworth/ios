#import <UIKit/UIKit.h>
#import <RobotKit/RobotKit.h>
#import <RobotUIKit/RobotUIKit.h>

@interface ViewController : UIViewController

    @property (strong, nonatomic) RKConvenienceRobot *robot;
    @property (strong, nonatomic) RUICalibrateGestureHandler *calibrateHandler;
    @property (strong, nonatomic) IBOutlet UISlider *slider;

    - (IBAction)stopPressed:(id)sender;
    - (IBAction)zeroPressed:(id)sender;
    - (IBAction)ninetyPressed:(id)sender;
    - (IBAction)oneEightyPressed:(id)sender;
    - (IBAction)twoSeventyPressed:(id)sender;
    - (IBAction)sliderValueChanged:(id)sender;

@end