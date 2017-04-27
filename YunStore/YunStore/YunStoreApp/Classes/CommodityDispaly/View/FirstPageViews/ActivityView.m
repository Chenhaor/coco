//
//  ActivityView.m
//  YunFuStore
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ActivityView.h"
@interface ActivityView (){
    
    dispatch_source_t _timer;
}

@property(nonatomic, strong) UIView *countDownView;
@property(nonatomic, strong) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *dayLabel;
@property (strong, nonatomic) UILabel *hourLabel;
@property (strong, nonatomic) UILabel *minuteLabel;
@property (strong, nonatomic) UILabel *secondLabel;

@end

@implementation ActivityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self countDown];
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.activityIamgeView=[[UIImageView alloc]initWithFrame:self.frame];
    [self addSubview:self.activityIamgeView];

    self.countDownView=[UIView new];
    [self addSubview:self.countDownView];
    [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(-kScreenWidth/2);
        make.size.mas_offset(CGSizeMake(130, 30));
    }];
    
    self.titleLabel=[UILabel new];
    self.titleLabel.text=@"距离";
    self.titleLabel.textColor=[UIColor whiteColor];
    self.titleLabel.font=[UIFont systemFontOfSize:18];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.countDownView).mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.offset(40);
    }];

    UIImageView *dayImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeBackLeft"]];
    [self addSubview:dayImageView];
    [dayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.countDownView).mas_offset(UIEdgeInsetsMake(0, 40, 0, 0));
        make.width.offset(30);
    }];
    self.dayLabel=[UILabel new];
    self.dayLabel.textAlignment=NSTextAlignmentCenter;
    self.dayLabel.font=[UIFont systemFontOfSize:12];
    self.dayLabel.backgroundColor=[UIColor clearColor];
    self.dayLabel.textColor=[UIColor whiteColor];
    [dayImageView addSubview:self.dayLabel];
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.edges.equalTo(dayImageView).insets(UIEdgeInsetsMake(3, 3, 3, 3));
    }];

    
    UIImageView *hourImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeBackCente"]];
    [self addSubview:hourImageView];
    [hourImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.countDownView).mas_offset(UIEdgeInsetsMake(0, 70, 0, 0));
        make.width.offset(30);
    }];
    self.hourLabel=[UILabel new];
    self.hourLabel.textAlignment=NSTextAlignmentCenter;
    self.hourLabel.font=[UIFont systemFontOfSize:12];
    self.hourLabel.backgroundColor=[UIColor clearColor];
    self.hourLabel.textColor=[UIColor whiteColor];
    [hourImageView addSubview:self.hourLabel];
    [self.hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(hourImageView).insets(UIEdgeInsetsMake(3, 3, 3, 3));
    }];


    UIImageView *minuteImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeBackRight"]];
    [self addSubview:minuteImageView];
    [minuteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.countDownView).mas_offset(UIEdgeInsetsMake(0, 100, 0, 0));
        make.width.offset(30);
    }];
    self.minuteLabel=[UILabel new];
    self.minuteLabel.textAlignment=NSTextAlignmentCenter;
    self.minuteLabel.font=[UIFont systemFontOfSize:12];
    self.minuteLabel.backgroundColor=[UIColor clearColor];
    self.minuteLabel.textColor=[UIColor whiteColor];
    [minuteImageView addSubview:self.minuteLabel];
    [self.minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(minuteImageView).insets(UIEdgeInsetsMake(3, 3, 3, 3));
    }];
}

-(void)countDown{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *endDate = [dateFormatter dateFromString:[self getyyyymmdd]];
    NSDate *endDate_tomorrow = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([endDate timeIntervalSinceReferenceDate] + 24*3600)];
    NSDate *startDate = [NSDate date];
    NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
    
    if (_timer==nil) {
        __block int timeout = timeInterval; //倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每分钟执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.dayLabel.text = @"";
                        self.hourLabel.text = @"00";
                        self.minuteLabel.text = @"00";
                        self.secondLabel.text = @"00";
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    if (days==0) {
                        self.dayLabel.text = @"";
                    }
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days==0) {
                            self.dayLabel.text = @"0";
                        }else{
                            self.dayLabel.text = [NSString stringWithFormat:@"%d",days];
                        }
                        if (hours<10) {
                            self.hourLabel.text = [NSString stringWithFormat:@"0%d",hours];
                        }else{
                            self.hourLabel.text = [NSString stringWithFormat:@"%d",hours];
                        }
                        if (minute<10) {
                            self.minuteLabel.text = [NSString stringWithFormat:@"0%d",minute];
                        }else{
                            self.minuteLabel.text = [NSString stringWithFormat:@"%d",minute];
                        }
                        if (second<10) {
                            self.secondLabel.text = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            self.secondLabel.text = [NSString stringWithFormat:@"%d",second];
                        }
                        
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}

-(NSString *)getyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd";
    NSString *dayStr = [formatDay stringFromDate:now];
    
    return dayStr;
    
}
@end
