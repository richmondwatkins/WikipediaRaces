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



    //Above I have the urlTextField hidden so that the user can't see it but we can use it to use the strings that are produced from the URL in this text box.
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
    [self loadURLString:[NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@", self.wordOne]];

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
    self.clickCounter += 0.5;
    self.clickCounterDisplay = [NSString stringWithFormat:@"%0.f", self.clickCounter ];
    self.title = self.clickCounterDisplay;

    NSString *theTitle =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    int clickToInt = (int) self.clickCounter;
    if ([theTitle containsString:self.wordTwo] && (clickToInt % 2 == 0)) {
        [self winningClick];
    }

}

-(void)winningClick{
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
    [self presentViewController:viewController animated:YES completion:nil];

}

-(void)loadWebPageWithString:(NSString *)urlString {
    if (![urlString containsString:@"wiki"]) {
        [self.wikipediaWebView goBack];
    }
}



@end
