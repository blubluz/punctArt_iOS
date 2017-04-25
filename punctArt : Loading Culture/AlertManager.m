//
//  AlertManager.m
//  Liga Ultrass
//
//  Created by Mihai Honceriu on 06/01/17.
//  Copyright © 2017 MihaiH. All rights reserved.
//

#import "AlertManager.h"
@implementation AlertManager
+(void)presentSimpleAlertWithMessage:(NSString *)message andTitle:(NSString *)title inViewController:(UIViewController *)vc{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [vc presentViewController:alertController animated:YES completion:nil];
}
@end
