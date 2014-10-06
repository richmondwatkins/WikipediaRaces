//
//  WikipediaViewController.m
//  WikipediaRaces
//
//  Created by Michael Maloof on 10/3/14.
//  Copyright (c) 2014 Michael Maloof. All rights reserved.
//

#import "WikipediaViewController.h"
#import "ResultsViewController.h"
#import "ViewController.h"


@interface WikipediaViewController () <UIWebViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *wikipediaWebView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property  float clickCounter;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UILabel *finishedLabel;
@property NSString *clickCounterDisplay;
@property NSTimer *stopWatch;
@property NSDate *startDate;
@property NSString *timeString;
@property int numberOfLoads;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *finalWordToolBarDisplay;

@end

@implementation WikipediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.urlTextField.hidden = YES;
    self.finishButton.hidden = YES;
    [self loadHomePage];
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationController.toolbarHidden = NO;
    self.finishedLabel.hidden=YES;
    self.startDate = [NSDate date];
    self.stopWatch = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];


    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:nil];

    self.finalWordToolBarDisplay.title = self.wordTwo;

    NSArray *actionButtonItemsTwo = @[cameraItem];
    self.navigationItem.rightBarButtonItems = actionButtonItemsTwo;
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) loadURLString: (NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL: url];
    [self.wikipediaWebView loadRequest:urlRequest];

}

- (void) loadHomePage {
    [self loadURLString:[NSString stringWithFormat:@"%@", self.wordOneUrl]];

}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('searchInput').parentNode.removeChild(document.getElementById('searchInput'))"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('mw-mf-main-menu-button').parentNode.removeChild(document.getElementById('mw-mf-main-menu-button'))"];

    [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function alerter() { "
     "var elements = document.getElementsByClassName('mw-disambig');"
     "elements[0].parentNode.removeChild(elements[0]);"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];

    [webView stringByEvaluatingJavaScriptFromString:@"alerter();"];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.numberOfLoads += 1;
    if (self.numberOfLoads <= 2) {
        self.clickCounter = 1;
    }else{
        self.clickCounter += 0.5;
    }

    self.clickCounterDisplay = [NSString stringWithFormat:@"%0.f", self.clickCounter ];

    NSString *theTitle =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    int clickToInt = (int) self.clickCounter;
    if ([theTitle containsString:self.wordTwo] && (clickToInt % 2 == 0)) {
        [self winningClick];
    }

}

-(void)winningClick{
    [self.stopWatch invalidate];
    self.stopWatch = nil;
    [self updateTimer];
    UIAlertView *alertView = [[UIAlertView alloc]init];
    alertView.delegate = self;
    alertView.title = [NSString  stringWithFormat:@"Success! You have found the wikipedia page for %@", self.wordTwo];
    [alertView addButtonWithTitle:@"See Results"];
    [alertView show];
}


-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ResultsViewController *viewController = (ResultsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RVC"];
    viewController.clickCounterData = self.clickCounterDisplay;
    viewController.timerData = self.timeString;
    [self presentViewController:viewController animated:YES completion:nil];

}

-(void)loadWebPageWithString:(NSString *)urlString {
    if (![urlString containsString:@"wiki"]) {
        [self.wikipediaWebView goBack];
    }
}

- (void)updateTimer

{
    static NSInteger counter = 0;
    self.title = [NSString stringWithFormat:@"Clicks  %@  Time  %ld        ", self.clickCounterDisplay, (long)counter++];

    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];

    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];

    // Format the elapsed time and set it to the label
    self.timeString = [dateFormatter stringFromDate:timerDate];
}

@end
