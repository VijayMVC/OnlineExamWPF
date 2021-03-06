USE [OnlineExam]
GO
SET IDENTITY_INSERT [dbo].[Lesson] ON 

INSERT [dbo].[Lesson] ([LessonID], [LessonName], [Description], [Level], [IsDisabled]) VALUES (1, N'تفکر و سواد رسانه ای', N'ندارد', N'11', 0)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [Description], [Level], [IsDisabled]) VALUES (5, N'برنامه سازی و پایگاه داده ها', N'ندارد', N'11', 0)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [Description], [Level], [IsDisabled]) VALUES (6, N'نصب و راه اندازی سیستم های رایانه ای', N'ندارد', N'11', 0)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [Description], [Level], [IsDisabled]) VALUES (7, N'دانش فنی پایه', N'ندارد', N'10', 0)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [Description], [Level], [IsDisabled]) VALUES (8, N'دانش فنی تخصصی', N'ندارد', N'12', 0)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [Description], [Level], [IsDisabled]) VALUES (9, N'کارگاه فن آوری های نوین', N'ندارد', N'11', 0)
SET IDENTITY_INSERT [dbo].[Lesson] OFF
SET IDENTITY_INSERT [dbo].[Chapter] ON 

INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (1, 1, N'پیاده سازی پایگاه داده', 5, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (2, 2, N'مدیریت مجموعه داده ', 5, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (3, 3, N'طراحی واسط گرافیکی', 5, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (4, 4, N'شایستگی کار با کنترلهای پیشرفته', 5, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (5, 5, N'مدیریت پایگاه داده', 5, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (6, 1, N'سواد فناورانه', 9, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (7, 2, N'فناوری اطلاعات و ارتباطات', 9, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (8, 3, N'فناوری هم گرا و مواد نوترکیب', 9, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (9, 4, N'انرژی های تجدید پذیر', 9, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (10, 5, N'از ایده تامحصول', 9, N'ندارد', 0)
SET IDENTITY_INSERT [dbo].[Chapter] OFF
SET IDENTITY_INSERT [dbo].[Designer] ON 

INSERT [dbo].[Designer] ([DesignerID], [Name], [CodeMeli], [Official], [UserName], [Password], [Mobile], [Email], [IsDisabled], [RegisterDate]) VALUES (1, N'محمد سبزواری', N'119', N'دبیر', N'admin', N'admin', N'0913', N'k@g.com', 0, NULL)
INSERT [dbo].[Designer] ([DesignerID], [Name], [CodeMeli], [Official], [UserName], [Password], [Mobile], [Email], [IsDisabled], [RegisterDate]) VALUES (2, N'کریم رحیمیان', N'118', N'دبیر', N'user1', N'user1', N'0914', N'l@g.com', 0, NULL)
INSERT [dbo].[Designer] ([DesignerID], [Name], [CodeMeli], [Official], [UserName], [Password], [Mobile], [Email], [IsDisabled], [RegisterDate]) VALUES (3, N'محمد شفیعی', N'117', N'دبیر', N'user2', N'user2', N'0915', N'l@g.com', 0, NULL)
SET IDENTITY_INSERT [dbo].[Designer] OFF
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (1, 1, 1, N'تستی', N'سخت', 20, CAST(N'2640-10-08T00:00:00.0000000' AS DateTime2), N'سوال1', 2, 1, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (2, 1, 1, N'تستی', N'سخت', 21, CAST(N'3261-12-28T00:00:00.0000000' AS DateTime2), N'سوال2', 1, 1, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (3, 1, 1, N'تستی', N'آسان', 23, CAST(N'3261-12-28T00:00:00.0000000' AS DateTime2), N'سوال3', 1, 2, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (4, 1, 1, N'تشریحی', N'سخت', 25, CAST(N'3261-12-28T00:00:00.0000000' AS DateTime2), N'سوال4', 1, 3, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (5, 2, 1, N'تستی', N'متوسط', 36, CAST(N'3261-12-28T00:00:00.0000000' AS DateTime2), N'سوال5', 1, 2, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (6, 2, 1, N'تشریحی', N'آسان', 50, CAST(N'3261-12-28T00:00:00.0000000' AS DateTime2), N'سوال6', 1, 1, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (7, 2, 2, N'عملی', N'آسان', 10, CAST(N'2639-04-25T00:00:00.0000000' AS DateTime2), N'سوال7', 2, 1, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (8, 2, 2, N'تستی', N'آسان', 12, CAST(N'2640-05-27T00:00:00.0000000' AS DateTime2), N'سوال8', 0, 2, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (9, 2, 2, N'جای خالی', N'آسان', 13, CAST(N'0841-05-28T00:00:00.0000000' AS DateTime2), N'سوال9', 0, 1, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (10, 2, 3, N'تشریحی', N'آسان', 15, CAST(N'2643-03-09T00:00:00.0000000' AS DateTime2), N'سوال10', 0, 2, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (11, 3, 3, N'تشریحی', N'سخت', 20, CAST(N'2636-03-21T00:00:00.0000000' AS DateTime2), N'سوال11', 0, 1, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (12, 3, 3, N'تستی', N'سخت', 21, CAST(N'2636-03-22T00:00:00.0000000' AS DateTime2), N'سوال12', 0, 2, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (13, 3, 4, N'عملی', N'متوسط', 22, CAST(N'2637-03-21T00:00:00.0000000' AS DateTime2), N'سوال13', 0, 1, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (14, 3, 4, N'عملی', N'متوسط', 23, CAST(N'2637-12-08T00:00:00.0000000' AS DateTime2), N'سوال14', 1, 3, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (15, 1, 5, N'جای خالی', N'متوسط', 24, CAST(N'2652-03-05T00:00:00.0000000' AS DateTime2), N'سوال15', 1, 1, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (16, 1, 5, N'جای خالی', N'متوسط', 25, CAST(N'2634-03-08T00:00:00.0000000' AS DateTime2), N'سوال16', 1, 1, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (17, 1, 5, N'جای خالی', N'آسان', 16, CAST(N'2630-09-06T00:00:00.0000000' AS DateTime2), N'سوال17', 2, 2, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (18, 2, 6, N'تستی', N'آسان', 17, CAST(N'2628-05-24T00:00:00.0000000' AS DateTime2), N'سوال18', 2, 1, 0)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]) VALUES (19, 2, 6, N'تستی', N'آسان', 19, CAST(N'2629-04-22T00:00:00.0000000' AS DateTime2), N'سوال19', 3, 2, 0)
SET IDENTITY_INSERT [dbo].[Question] OFF
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (1, N'محمدعلی شفیعی', N'118', N'1235464658', N'رضا', N'0913', N'admin', N'123', N'10', N'e@g.com', 0, CAST(N'2631-04-25T00:00:00.0000000' AS DateTime2), CAST(N'2631-05-02T00:00:00.0000000' AS DateTime2), 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (2, N'علیرضا محمدی', N'117', N'321654', N'عباس', N'0912', N'user1', N'124', N'11', N'skljdf@ldkjfg.o', 0, CAST(N'2641-12-23T00:00:00.0000000' AS DateTime2), CAST(N'2631-07-27T00:00:00.0000000' AS DateTime2), 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (3, N'عباس محمد مشاهی', N'116', N'6548', N'تقی', N'65465', N'klsjdf', N'123', N'10', N'mo@g.com', 0, CAST(N'2632-03-02T00:00:00.0000000' AS DateTime2), CAST(N'2632-03-02T00:00:00.0000000' AS DateTime2), 0)
SET IDENTITY_INSERT [dbo].[Student] OFF
SET IDENTITY_INSERT [dbo].[Exam] ON 

INSERT [dbo].[Exam] ([ExamID], [ExamName], [Level], [ChapterID], [Date], [Duration], [StartTime], [QuestionType], [ExamType], [SupervisorName], [RepeatTestCount], [OptionalQuestionCount], [OptionalQuestionScore], [DescriptionQuestionCount], [DescriptionQuestionScore], [BlankQuestionCount], [BlankQuestionScore], [TrueFalseQuestionCount], [TrueFalseQuestionScore], [PracticalQuestionCount], [PracticalQuestionScore], [TotalScore], [Status], [Difficulty], [StartDate], [DelayTime], [IsDisabled]) VALUES (1, N'آزمون مستمر برنامه سازی و پایگاه داده', N'11', 2, CAST(N'2641-01-05' AS Date), 40, CAST(N'08:30:00' AS Time), N'ترکیبی', N'مستمر', N'حسام صادقی', 3, 10, 10, 5, 10, 5, 5, 5, 5, 0, 0, 20, N'در صف', N'سخت', CAST(N'2642-03-03T00:00:00.0000000' AS DateTime2), 40, 0)
INSERT [dbo].[Exam] ([ExamID], [ExamName], [Level], [ChapterID], [Date], [Duration], [StartTime], [QuestionType], [ExamType], [SupervisorName], [RepeatTestCount], [OptionalQuestionCount], [OptionalQuestionScore], [DescriptionQuestionCount], [DescriptionQuestionScore], [BlankQuestionCount], [BlankQuestionScore], [TrueFalseQuestionCount], [TrueFalseQuestionScore], [PracticalQuestionCount], [PracticalQuestionScore], [TotalScore], [Status], [Difficulty], [StartDate], [DelayTime], [IsDisabled]) VALUES (2, N'آزمون پایانی پودمان 5', N'11', 10, CAST(N'2631-04-25' AS Date), 60, CAST(N'09:00:00' AS Time), N'تستی', N'پایانی', N'کریم رحیمیان', 3, 0, 0, 0, 0, 0, 0, 0, 0, 5, 20, 20, N'اتمام', N'سخت', CAST(N'2641-03-21T00:00:00.0000000' AS DateTime2), 40, 0)
INSERT [dbo].[Exam] ([ExamID], [ExamName], [Level], [ChapterID], [Date], [Duration], [StartTime], [QuestionType], [ExamType], [SupervisorName], [RepeatTestCount], [OptionalQuestionCount], [OptionalQuestionScore], [DescriptionQuestionCount], [DescriptionQuestionScore], [BlankQuestionCount], [BlankQuestionScore], [TrueFalseQuestionCount], [TrueFalseQuestionScore], [PracticalQuestionCount], [PracticalQuestionScore], [TotalScore], [Status], [Difficulty], [StartDate], [DelayTime], [IsDisabled]) VALUES (3, N'آزمون پایانی پودمان 3', N'11', 8, CAST(N'2636-03-21' AS Date), 60, CAST(N'10:00:00' AS Time), N'تستی', N'پایانی', N'کریم رحیمیان', 3, 10, 20, 0, 0, 0, 0, 0, 0, 0, 0, 20, N'درصفا', N'آسان', CAST(N'2642-04-21T00:00:00.0000000' AS DateTime2), 40, 0)
SET IDENTITY_INSERT [dbo].[Exam] OFF
SET IDENTITY_INSERT [dbo].[QuestionExam] ON 

INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (1, 1, 1, 1, N'الف', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (2, 1, 1, 2, N'ب', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (3, 1, 1, 3, NULL, 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (4, 1, 1, 4, N'ج', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (5, 1, 2, 1, N'جواب1', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (6, 1, 2, 2, N'جواب2', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (7, 1, 2, 3, N'جواب3', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (8, 1, 2, 4, N'جوال1', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (9, 1, 3, 1, N'ندارد', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (10, 1, 3, 2, N'فردا', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (11, 1, 3, 3, N'دیروز', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (12, 1, 3, 4, N'رادیو', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (13, 2, 1, 1, N'مانیتور', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (14, 2, 1, 2, N'اسب آبی', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (15, 2, 1, 3, N'آسب قرمز', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (16, 2, 1, 4, N'آسب تراوا', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (17, 2, 1, 5, N'خیر', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (18, 2, 2, 6, N'بله', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (19, 2, 2, 5, N'وارد', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (20, 2, 2, 4, N'ناوارد', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (21, 2, 2, 3, N'زندگی', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (22, 2, 2, 2, N'مردگی', 12, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (23, 2, 2, 1, N'فردا', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (24, 2, 3, 1, N'ب', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (25, 2, 3, 2, N'9', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (26, 2, 3, 3, N'6', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (27, 2, 3, 10, N'213984نصث98', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (28, 2, 3, 1, N'صمنصتب09234نب', NULL, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (29, 3, 1, 1, N'ندارد', 1, 0, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (30, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (31, NULL, NULL, NULL, NULL, NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[QuestionExam] OFF
SET IDENTITY_INSERT [dbo].[Participant] ON 

INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (1, 1, 1, 20, CAST(N'02:40:00' AS Time), CAST(N'12:20:00' AS Time), CAST(N'3873-10-11T00:00:00.0000000' AS DateTime2), 1, 0)
INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (2, 1, 2, 18, CAST(N'08:30:00' AS Time), CAST(N'13:30:00' AS Time), CAST(N'2640-08-16T00:00:00.0000000' AS DateTime2), 1, 0)
INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (3, 1, 3, 17, CAST(N'09:40:00' AS Time), CAST(N'14:00:00' AS Time), CAST(N'0840-08-16T00:00:00.0000000' AS DateTime2), 1, 0)
INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (4, 2, 1, 17, CAST(N'10:20:00' AS Time), CAST(N'15:15:00' AS Time), CAST(N'2640-08-18T00:00:00.0000000' AS DateTime2), 1, 0)
INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (5, 2, 2, 16, CAST(N'11:30:00' AS Time), CAST(N'16:15:00' AS Time), CAST(N'2640-08-19T00:00:00.0000000' AS DateTime2), 1, 0)
INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (6, 2, 3, 15, CAST(N'12:30:00' AS Time), CAST(N'17:15:00' AS Time), CAST(N'2640-08-21T00:00:00.0000000' AS DateTime2), 1, 0)
INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (7, 3, 1, 10, CAST(N'14:50:00' AS Time), CAST(N'18:30:00' AS Time), CAST(N'2640-08-06T00:00:00.0000000' AS DateTime2), 1, 0)
SET IDENTITY_INSERT [dbo].[Participant] OFF
SET IDENTITY_INSERT [dbo].[Contest] ON 

INSERT [dbo].[Contest] ([ContestID], [ExamID], [ContestText], [StudentID], [IsDisabled], [RegisterDate], [IsTeacherResponse], [TeacherResponse], [DesingerID]) VALUES (1, 1, N'اعتراض دارم به آزمون و به سوال شماره 2', 1, 0, CAST(N'2631-04-25T00:00:00.0000000' AS DateTime2), 0, N'برو دروغ میگی', 1)
INSERT [dbo].[Contest] ([ContestID], [ExamID], [ContestText], [StudentID], [IsDisabled], [RegisterDate], [IsTeacherResponse], [TeacherResponse], [DesingerID]) VALUES (2, 1, N'اعتراض دارم به سوال 2', 2, 0, CAST(N'2641-04-25T00:00:00.0000000' AS DateTime2), 0, N'دروغ نمیگی اینو', 1)
INSERT [dbo].[Contest] ([ContestID], [ExamID], [ContestText], [StudentID], [IsDisabled], [RegisterDate], [IsTeacherResponse], [TeacherResponse], [DesingerID]) VALUES (3, 2, N'اعتراض دارم به ', 3, 0, CAST(N'2631-07-27T00:00:00.0000000' AS DateTime2), 0, N'راست میگی', 2)
SET IDENTITY_INSERT [dbo].[Contest] OFF
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (1, N'الکترونیک', N'ندارد', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (2, N'رایانه و و نرم افزار', N'ندارد', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (3, N'الکتروتکنیک', N'ندارد', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (4, N'حسابداری', N'ندارد', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (5, N'باغداری و امور دام', N'ندارد', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (6, N'کشاورزی', N'ندارد', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (7, N'ریاضی فیزیک', N'ندارد', 0)
SET IDENTITY_INSERT [dbo].[Course] OFF
SET IDENTITY_INSERT [dbo].[LessonCourse] ON 

INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (1, 1, 1)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (2, 1, 2)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (3, 1, 3)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (4, 1, 4)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (5, 1, 5)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (6, 1, 6)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (7, 1, 7)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (1, 9, 8)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (2, 9, 9)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (3, 9, 10)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (4, 9, 11)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (5, 9, 12)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (6, 9, 13)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (7, 9, 14)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (2, 5, 15)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (2, 6, 16)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (2, 7, 17)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (2, 8, 18)
SET IDENTITY_INSERT [dbo].[LessonCourse] OFF
