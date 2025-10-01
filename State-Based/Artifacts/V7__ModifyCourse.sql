-- Idempotent Deployment script for V7
IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001154001_V7__Baseline'
)
BEGIN
    CREATE TABLE [Instructor] (
        [Id] int NOT NULL IDENTITY,
        [FirstName] nvarchar(max) NOT NULL,
        [LastName] nvarchar(max) NOT NULL,
        [Email] nvarchar(max) NOT NULL,
        [HireDate] datetime2 NOT NULL,
        CONSTRAINT [PK_Instructor] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001154001_V7__Baseline'
)
BEGIN
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
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001154001_V7__Baseline'
)
IF COL_LENGTH('Course', 'Credits') IS NOT NULL
    ALTER TABLE [dbo].[Course] ALTER COLUMN [Credits] decimal(5,2) NOT NULL;

IF COL_LENGTH('Course', 'Credits') IS NULL 
    BEGIN
        CREATE TABLE [Course] (
            [Id] int NOT NULL IDENTITY,
            [InstructorId] int NOT NULL,
            [Title] nvarchar(max) NOT NULL,
            [Credits] decimal(5,2) NOT NULL,
            CONSTRAINT [PK_Course] PRIMARY KEY ([Id]),
            CONSTRAINT [FK_Course_Instructor_InstructorId] FOREIGN KEY ([InstructorId]) REFERENCES [Instructor] ([Id]) ON DELETE CASCADE
        );
    END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001154001_V7__Baseline'
)
BEGIN
    CREATE TABLE [Department] (
        [Id] int NOT NULL IDENTITY,
        [DepartmentHeadId] int NULL,
        [Name] nvarchar(max) NOT NULL,
        [Budget] decimal(18,2) NOT NULL,
        [StartDate] datetime2 NOT NULL,
        CONSTRAINT [PK_Department] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Department_Instructor_DepartmentHeadId] FOREIGN KEY ([DepartmentHeadId]) REFERENCES [Instructor] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001154001_V7__Baseline'
)
BEGIN
    CREATE TABLE [Enrollment] (
        [Id] int NOT NULL IDENTITY,
        [StudentId] int NOT NULL,
        [CourseId] int NOT NULL,
        [FinalGrade] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Enrollment] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Enrollment_Course_CourseId] FOREIGN KEY ([CourseId]) REFERENCES [Course] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Enrollment_Student_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Student] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001154001_V7__Baseline'
)
BEGIN
    CREATE INDEX [IX_Course_InstructorId] ON [Course] ([InstructorId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001154001_V7__Baseline'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Department_DepartmentHeadId] ON [Department] ([DepartmentHeadId]) WHERE [DepartmentHeadId] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001154001_V7__Baseline'
)
BEGIN
    CREATE INDEX [IX_Enrollment_CourseId] ON [Enrollment] ([CourseId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001154001_V7__Baseline'
)
BEGIN
    CREATE INDEX [IX_Enrollment_StudentId] ON [Enrollment] ([StudentId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001154001_V7__Baseline'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20251001154001_V7__Baseline', N'9.0.9');
END;

COMMIT;
GO

