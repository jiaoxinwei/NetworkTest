//
//  MeViewController.m
//  NetworkTest
//
//  Created by 茭白 on 2017/6/14.
//  Copyright © 2017年 茭白. All rights reserved.
//

#import "MeViewController.h"
#import "AppConfig.h"
#import <HZActionSheet.h>
@interface MeViewController ()<HZActionSheetDelegate>
{
    WorkEnvironment _currentEnvir;
}
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(100, 100, 100, 40);
    button.backgroundColor=[UIColor blueColor];
    [button setTitle:@"切库" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _currentEnvir = [AppConfig currentEnvir];
    EnvironmentModel *envirModel = [AppConfig httpURLs][_currentEnvir];
    
    UILabel *label=[[UILabel alloc] init];
    label.frame=CGRectMake(100, 200, 100, 40);
    label.backgroundColor=[UIColor blueColor];
    label.textColor=[UIColor redColor];
    label.text=envirModel.name;
    [self.view addSubview:label];
}
-(void)action:(UIButton *)button{
    NSMutableArray * unProductEnvirs = [AppConfig httpURLs];
    
    [unProductEnvirs removeObjectAtIndex:0];
    
    NSMutableArray * titleArray = [NSMutableArray array];
    
    for (EnvironmentModel * environment in unProductEnvirs) {
        [titleArray addObject:environment.name];
    }
    
    WorkEnvironment type = _currentEnvir -1;//这个type是用来索引的
    
    HZActionSheet * sheet = [[HZActionSheet alloc] initWithTitle:@"恭喜你开启了应用的彩蛋-切换库"
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                       destructiveButtonIndexSet:[NSIndexSet indexSetWithIndex:type]
                                               otherButtonTitles:titleArray];
    [sheet showInView:self.view];

}
-(void)actionSheet:(HZActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    WorkEnvironment type =_currentEnvir -1;
    //当type和button是一个值时不反应
    
    if (buttonIndex==actionSheet.cancelButtonIndex||buttonIndex==type) {
        return;
    }
    [AppConfig saveEnvirWithIndex:buttonIndex+1];
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
