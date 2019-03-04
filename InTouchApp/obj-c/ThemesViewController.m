//
//  ThemesViewController.m
//  InTouchApp
//
//  Created by Михаил Борисов on 02/03/2019.
//  Copyright © 2019 Mikhail Borisov. All rights reserved.
//

#import "ThemesViewController.h"
#import "InTouchApp-Swift.h"
@class ThemesViewControllerDelegate;

@interface ThemesViewController ()
@end


@implementation ThemesViewController

- (IBAction)firstThemeButton:(id)sender {
  Themes *cgh = [[Themes alloc] init];
  [self themesViewController:self didSelectTheme:[cgh theme1]];
  
  
}
- (IBAction)secondThemeButton:(id)sender {
  Themes *cgh = [[Themes alloc] init];
  [self themesViewController:self didSelectTheme:[cgh theme2]];
  self.view.backgroundColor = [cgh theme2];
}
- (IBAction)thirdThemeButton:(id)sender {
  Themes *cgh = [[Themes alloc] init];
  [self themesViewController:self didSelectTheme:[cgh theme3]];
  self.view.backgroundColor = [cgh theme3];
}
- (void)themesViewController:(ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme {
 
}
- (IBAction)returnButton:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
  //  Themes * theme = [[Themes alloc] init];
    // Do any additional setup after loading the view.
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
