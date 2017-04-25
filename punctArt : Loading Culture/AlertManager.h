//
//  AlertManager.h
//  Liga Ultrass
//
//  Created by Mihai Honceriu on 06/01/17.
//  Copyright © 2017 MihaiH. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AlertManager : NSObject
+(void)presentSimpleAlertWithMessage:(NSString *)message andTitle:(NSString *)title inViewController:(UIViewController *)vc;
@end
