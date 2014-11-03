//
//  NewTweetViewController.m
//  Twitter
//
//  Created by Erich Owens on 11/2/14.
//  Copyright (c) 2014 Erich Owens. All rights reserved.
//

#import "NewTweetViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "TweetsViewController.h"
#import "TwitterClient.h"

@interface NewTweetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *tweetTextField;

@end

@implementation NewTweetViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  User *user = [User currentUser];
  [self.profileImageView setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
  self.realNameLabel.text = user.name;
  self.userNameLabel.text = user.screenname;
  self.tweetTextField.text = self.originalText;
  
  UIColor *twitterBlue = [UIColor colorWithRed:85.0/255.0 green:172.0/255.0 blue:238.0/255.0 alpha:1.0];
  self.navigationController.navigationBar.barTintColor = twitterBlue;
  self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(onPost)];
}

- (void)onCancel {
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)onPost {
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  [dictionary addEntriesFromDictionary:self.params];
  dictionary[@"status"] = self.tweetTextField.text;
  
  [[TwitterClient sharedInstance] postNewStatus:dictionary];
  [self onCancel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
