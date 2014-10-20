//
//  ViewController.m
//  WikipediaRaces
//
//  Created by Michael Maloof on 10/3/14.
//  Copyright (c) 2014 Michael Maloof. All rights reserved.
//

#import "ViewController.h"
#import "WikipediaViewController.h"


@interface ViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *connectLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UILabel *wikiRacesTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *beginWastingLife;
@property NSString *startWord;
@property NSString *endWord;
@property NSString *totalScoreString;
@property (weak, nonatomic) IBOutlet UILabel *highScore;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldBadgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *silverBadgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bronzeBadgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreTitle;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreTitle;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property int wikiLoads;
@property NSMutableArray *arrayOfWords;
@property int numberOfLoads;
@end

@implementation ViewController

- (void)viewDidLoad {


    [super viewDidLoad];
    self.toLabel.hidden = YES;
    self.connectLabel.hidden = YES;
    self.firstWordLabel.hidden = YES;
    self.secondWordLabel.hidden = YES;
    self.beginWastingLife.hidden = YES;
    self.goldBadgeLabel.hidden = YES;
    self.silverBadgeLabel.hidden = YES;
    self.bronzeBadgeLabel.hidden = YES;


    NSUserDefaults *saved = [NSUserDefaults standardUserDefaults];
    NSString *stringHighScore = [saved stringForKey:@"UserHighScore"];
    self.highScore.text = stringHighScore;


    NSUserDefaults *totalScore = [NSUserDefaults standardUserDefaults];
    NSInteger currenttotalScore = [totalScore integerForKey:@"Current Total"];
    self.totalScoreString = [NSString stringWithFormat:@"%ld", (long)currenttotalScore];
    self.totalScoreLabel.text = self.totalScoreString;

    NSUserDefaults *goldMedal = [NSUserDefaults standardUserDefaults];
    NSInteger doYouHaveGold = [goldMedal integerForKey:@"Check for Gold"];

    NSUserDefaults *silverMedal = [NSUserDefaults standardUserDefaults];
    NSInteger doYouHaveSilver = [silverMedal integerForKey:@"Check for Silver"];

    NSUserDefaults *bronzeMedal = [NSUserDefaults standardUserDefaults];
    NSInteger doYouHaveBronze = [bronzeMedal integerForKey:@"Check for Bronze"];


    if (doYouHaveGold == 1) {
        self.goldBadgeLabel.hidden = NO;
    } else if (doYouHaveSilver == 1) {
        self.silverBadgeLabel.hidden = NO;
    } else if (doYouHaveBronze == 1) {
        self.bronzeBadgeLabel.hidden = NO;
    }

    self.arrayOfWords = [[NSMutableArray alloc]init];
    [self returnRandomWikiWords];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.numberOfLoads += 1;
    if (self.numberOfLoads % 2 == 0) {
        NSMutableDictionary *wikiInfo = [[NSMutableDictionary alloc] init];
        NSString *currentURL = webView.request.URL.absoluteString;
        NSString *pageTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('section_0').innerHTML.toString()"];
        [wikiInfo setObject:currentURL forKey:@"url"];
        [wikiInfo setObject:pageTitle forKey:@"title"];
        [self.arrayOfWords addObject:wikiInfo];
        NSLog(@"%@", self.arrayOfWords);
    }

    if (self.numberOfLoads == 2) {
        [self returnRandomWikiWords];
    }

}

-(void)returnRandomWikiWords{
    NSURL *url = [NSURL URLWithString:@"http://en.m.wikipedia.org/wiki/Special:Random"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest:urlRequest];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onStartButtonPressed:(id)sender {

    self.startButton.hidden = YES;
    self.warningLabel.hidden = YES;
    self.wikiRacesTitleLabel.hidden = YES;

    self.toLabel.hidden = NO;
    self.connectLabel.hidden = NO;
    self.firstWordLabel.hidden = NO;
    self.secondWordLabel.hidden = NO;
    self.beginWastingLife.hidden = NO;
    self.highScore.hidden=YES;
    self.goldBadgeLabel.hidden=YES;
    self.silverBadgeLabel.hidden=YES;
    self.bronzeBadgeLabel.hidden=YES;
    self.totalScoreLabel.hidden=YES;
    self.totalScoreTitle.hidden=YES;
    self.highScoreTitle.hidden=YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if (self.arrayOfWords.count < 2) {
        [self returnRandomWikiWords];
    }else{
        WikipediaViewController *wikiCtrler = segue.destinationViewController;
        wikiCtrler.wordOne = self.arrayOfWords[0][@"title"];
        wikiCtrler.wordTwo = self.arrayOfWords[1][@"title"];
        wikiCtrler.wordOneUrl = self.arrayOfWords[0][@"url"];
        wikiCtrler.wordTwoUrl = self.arrayOfWords[1][@"url"];
    }
}


- (IBAction)returnToHome:(UIStoryboardSegue *)segue {
    NSLog(@"And now we are back.");
}

@end
