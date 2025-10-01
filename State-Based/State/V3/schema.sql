-- Desired state script for V3
CREATE TABLE [Course] (
    [Id] int NOT NULL IDENTITY,
    [Title] nvarchar(max) NOT NULL,
    [Credits] int NOT NULL,
    CONSTRAINT [PK_Course] PRIMARY KEY ([Id])
);
GO


CREATE TABLE [Student] (
    [Id] int NOT NULL IDENTITY,
    [FirstName] nvarchar(max) NOT NULL,
    [MiddleName] nvarchar(max) NOT NULL,
    [LastName] nvarchar(max) NOT NULL,
    [DateOfBirth] datetime2 NOT NULL,       -- New column
    [Email] nvarchar(max) NOT NULL,
    [EnrollmentDate] datetime2 NOT NULL,
    CONSTRAINT [PK_Student] PRIMARY KEY ([Id])
);
GO


CREATE TABLE [Enrollment] (
    [Id] int NOT NULL IDENTITY,
    [StudentId] int NOT NULL,
    [CourseId] int NOT NULL,
    [Grade] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Enrollment] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Enrollment_Course_CourseId] FOREIGN KEY ([CourseId]) REFERENCES [Course] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Enrollment_Student_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Student] ([Id]) ON DELETE CASCADE
);
GO


CREATE INDEX [IX_Enrollment_CourseId] ON [Enrollment] ([CourseId]);
GO


CREATE INDEX [IX_Enrollment_StudentId] ON [Enrollment] ([StudentId]);
GO


