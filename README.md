# 鲸鱼选课系统  [![Build Status](https://www.travis-ci.org/skkshr/CourseSelect_New.svg?branch=master)](https://www.travis-ci.org/skkshr/CourseSelect_New)
国科大研究生课程 高级软件工程 大作业

在原有系统CourseSelect的基础上新增部分新功能和完善已有功能,并对新增功能编写了测试代码。

线上地址http://45.63.62.120:3000
### 选课模块相关改进
1. 勾选学位课和课程检索
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/xu/x1.png)
2. 查看课程详情
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/xu/x2.png)
3. 我的课表
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/xu/x3.png)
4. 学分统计
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/xu/x4.png)
5. 处理选课冲突
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/xu/x5.png)
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/xu/x6.png)
6. 成绩列表优化
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/xu/x7.png)
7. 新增选课学生名单查看
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/xu/x8.png)
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/xu/x9.png)
8. 测试结果
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/xu/xzh%E6%B5%8B%E8%AF%95%E7%BB%93%E6%9E%9C.png)
### 新增评估功能模块
1. 学生对已选课程评估
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/sun/s1.png)
2. 学生查看修改评估:对于已经评估过的课程，评估按钮变为修改评估按钮，如上图。
3. 管理员搜索课程功能：此搜索功能为模糊搜索。
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/sun/s2.png)
4. 管理员查看课程评估结果功能：点击查看按钮，可以查看某课程的具体评估结果。
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/sun/s3.png)
5. 图形化展示评估结果：如上图扇形统计图所示。
6. 管理员开通/关闭教师查看评估结果权限的功能：管理员可以授权或关闭教师查看所授课程的评估结果。
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/sun/s4.png)
7. 管理员修改评估条目内容：可以增加、删除、修改具体评估项。
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/sun/s5.png)
8. 教师根据权限查看评估反馈功能
9. 数据库设计：新建表evaluations、新建表evaluationitems、Courses表添加权限字段isopen。
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/sun/db.png)
10. 测试结果
![](https://github.com/skkshr/CourseSelect_New/blob/master/raw/sun/st.png)
### 新增通知功能模块
1. 教师发布通知
2. 历史通知记录
3. 学生查看通知
4. 通知搜索功能
