//
//  ViewController.m
//  TFHpple
//
//  Created by aten07 on 2017/4/10.
//  Copyright © 2017年 GZT. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"
#import "XPathQuery.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)test{
#pragma mark 每页主题
    //    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//div[@class = 'container']"];
    ////    NSLog(@"%d",itemArray.count);
    //
    //    for (TFHppleElement * hppleElement in itemArray) {
    //
    //        //raw ：div[@class = 'containe‘ 中的HTML源码
    //
    //        NSLog(@"%@",hppleElement.content);
    //
    //
    //    }
    
    //这个没有毛病
    //获取html的NSData数据
    //    NSData * testHpple =[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testHpple" ofType:@"html"] options:NSUTF8StringEncoding error:nil];
    //    //解析Html数据
    //    TFHpple *youxpathParsertestHpple =[[TFHpple alloc] initWithXMLData:testHpple];
    //
    //    //根据标签来进行过滤
    //    NSArray *arraytestHpple =[youxpathParsertestHpple searchWithXPathQuery:@"//span"];
    //
    //    for (TFHppleElement *hppthElement in arraytestHpple) {
    //        NSLog(@"%@",[hppthElement objectForKey:@"class"] );
    //        if ([[hppthElement objectForKey:@"class"] isEqualToString:@"zhiding"]) {
    //            NSLog(@"%@",hppthElement.text);
    //        }
    //
    //    }
    //
    
    //截取到body
//    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//body"];
    
    //raw:网页源码
    //tagName:当前标签
//    for (TFHppleElement * hppleElement in itemArray) {
//        //         NSLog(@"%@",hppleElement.parent);
//    }
    
    //eg:
    //获取html的NSData数据
    NSData * date =[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.cnblogs.com/YouXianMing/"]];
    //解析Html数据
    TFHpple *youxpathParser =[[TFHpple alloc] initWithXMLData:date];
    
    //根据标签来进行过滤
    NSArray *array =[youxpathParser searchWithXPathQuery:@"//title"];
    for (TFHppleElement *hppthElement in array) {
        NSLog(@"hppthElement.raw______________%@",hppthElement.raw);
        NSLog(@"hppthElement.text_+___________%@",hppthElement.text);
    }
    
    //根据标签来进行过滤
    NSArray *arraydiv =[youxpathParser searchWithXPathQuery:@"//div"];
    //整理数据
    for (TFHppleElement *hppthElement in arraydiv) {
        NSLog(@"objectForKey______________%@",[hppthElement objectForKey:@"class"]);
        if ([[hppthElement objectForKey:@"class"] isEqualToString:@"day"]) {
            NSLog(@"hppthElement.raw______________%@",hppthElement.raw);
            NSLog(@"hppthElement.text_+___________%@",hppthElement.text);
        }
        
    }
    
    
    
    

}


//eg:
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSString *imageStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://bbs.zhibo8.cc/forum/list/?fid=281"] encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"%@",imageStr);

 
    NSData *htmlData = [imageStr dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:htmlData];
//    topic-list
    NSString * topic_list ;
    
    NSArray <TFHppleElement *>* topic_listarr = [xpathParser searchWithXPathQuery:@"//table[@class='topic-list']"];
    
    TFHppleElement * ab = [topic_listarr[0] firstChildWithClassName:@"major"];
//    NSLog(@"%@",ab.raw); //置顶的信息
    NSArray *aaa =  topic_listarr[0].children;
    
//    NSLog(@"%@",aaa); //置顶的信息

    NSArray<TFHppleElement *> * abs =[topic_listarr[0] childrenWithTagName:@"tbody"];
    NSArray<TFHppleElement *> * tr =[abs[1] childrenWithTagName:@"tr"];
    for (TFHppleElement *object in tr) {
        NSArray<TFHppleElement *> * td =[object childrenWithTagName:@"td"];
        for (int i = 0; i < td.count; i++) {
            switch (i) {
                case 0: //标题
                {
                    NSArray<TFHppleElement *> * cententext = [td[i] childrenWithTagName:@"a"];
                    NSLog(@"%@",cententext[1].text);
              
                    NSArray<TFHppleElement *> * imageUrl = [[td[i] firstChildWithTagName:@"p"] childrenWithTagName:@"img"];
                    if (imageUrl.count != 0) {
                        NSLog(@"%@",imageUrl[0].raw);
                    }
                    
                    
                }
                    break;
                case 1: //作者
                {
                   TFHppleElement * titleName = [[td[i] firstChildWithTagName:@"cite"] firstChildWithTagName:@"a"];
                     NSLog(@"titleName.text___%@",titleName.text);
                    TFHppleElement * time = [td[i] firstChildWithTagName:@"em"];
                    NSLog(@"titleName.text___%@",time.text);

                    
                }
                    break;
                case 2: //查看、回复
                {
                    
                }
                    break;
                case 3: //最后发表
                {
                    
                }
                    break;
                default:
                    break;
            }
        }
    }
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
