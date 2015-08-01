//
//  PPCreatePartyViewController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 7/21/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "PPCreatePartyViewController.h"
#import "PartyController.h"
#import "Stack.h"

@interface PPCreatePartyViewController ()

@end

@implementation PPCreatePartyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (void)viewWillAppear:(BOOL)animated {
    
    [[Stack sharedInstance] resetManagedObjectContext];
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
