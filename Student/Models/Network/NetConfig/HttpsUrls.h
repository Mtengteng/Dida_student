//
//  HttpsUrls.h
//  Music
//
//  Created by 马腾 on 2018/12/12.
//  Copyright © 2018 beiwaionline. All rights reserved.
//

#ifndef HttpsUrls_h
#define HttpsUrls_h

#define BaseURL                      @"http://wyp.party:7777"                          //测试服务器
#define LoginURL                     @"/user/login"                                         //登陆

//学习集
#define knowledgeBoxURL                 @"/knowledgeBox/box/%@"                            //通过学科获取所有box
#define knowledgeBoxGroupURL            @"/knowledgeBox/groups/%@"                         //通过boxID获取所有groups
#define knowledgeBoxNodeURL             @"/knowledgeBox/node/%@"                           //通过groupsID获取所有nodes

#define GetAllBookURL                @"/book/all/%@/%@"                                      //首页获取图书
#define GetBookChapterURL            @"/book/chapter/%@/%@"                                 //获取所有章节
#define GetBookChapterSectionURL     @"/book/sections/%@/%@"                                //获取章下所有的节
#define GetDictTypeURL               @"/dict/%@"                                            //获取字典数据

#define boxURL                      @"/report/knowledgeReport/%@/%@/%@"
#define PrivacyURL                   @"https://appd10.beiwaionline.com/files/login/privacyPolicy.html"      //隐私政策页面
#define UserProURL                   @"https://appd10.beiwaionline.com/files/login/userAgreement.html"      //用户协议页面


#endif /* HttpsUrls_h */



