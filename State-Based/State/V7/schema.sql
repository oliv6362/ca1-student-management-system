-- Desired state script for V7
CREATE TABLE [Instructor] (
    [Id] int NOT NULL IDENTITY,
    [FirstName] nvarchar(max) NOT NULL,
    [LastName] nvarchar(max) NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    [HireDate] datetime2 NOT NULL,
    CONSTRAINT [PK_Instructor] PRIMARY KEY ([Id])
);
GO


CREATE TABLE [Student] (
    [Id] int NOT NULL IDENTITY,
    [FirstName] nvarchar(max) NOT NULL,
    [MiddleName] nvarchar(max) NOT NULL,
    [LastName] nvarchar(max) NOT NULL,
    [DateOfBirth] datetime2 NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    [EnrollmentDate] datetime2 NOT NULL,
    CONSTRAINT [PK_Student] PRIMARY KEY ([Id])
);
GO


CREATE TABLE [Course] (
    [Id] int NOT NULL IDENTITY,
    [InstructorId] int NOT NULL,
    [Title] nvarchar(max) NOT NULL,
    [Credits] decimal(5,2) NOT NULL,        -- Modified Column
    CONSTRAINT [PK_Course] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Course_Instructor_InstructorId] FOREIGN KEY ([InstructorId]) REFERENCES [Instructor] ([Id]) ON DELETE CASCADE
);
GO


CREATE TABLE [Department] (
    [Id] int NOT NULL IDENTITY,
    [DepartmentHeadId] int NULL,
    [Name] nvarchar(max) NOT NULL,
    [Budget] decimal(18,2) NOT NULL,
    [StartDate] datetime2 NOT NULL,
    CONSTRAINT [PK_Department] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Department_Instructor_DepartmentHeadId] FOREIGN KEY ([DepartmentHeadId]) REFERENCES [Instructor] ([Id])
);
GO


CREATE TABLE [Enrollment] (
    [Id] int NOT NULL IDENTITY,
    [StudentId] int NOT NULL,
    [CourseId] int NOT NULL,
    [FinalGrade] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Enrollment] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Enrollment_Course_CourseId] FOREIGN KEY ([CourseId]) REFERENCES [Course] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Enrollment_Student_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Student] ([Id]) ON DELETE CASCADE
);
GO


CREATE INDEX [IX_Course_InstructorId] ON [Course] ([InstructorId]);
GO


CREATE UNIQUE INDEX [IX_Department_DepartmentHeadId] ON [Department] ([DepartmentHeadId]) WHERE [DepartmentHeadId] IS NOT NULL;
GO


CREATE INDEX [IX_Enrollment_CourseId] ON [Enrollment] ([CourseId]);
GO


CREATE INDEX [IX_Enrollment_StudentId] ON [Enrollment] ([StudentId]);
GO


