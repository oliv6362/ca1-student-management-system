-- Idempotent Deployment script for V5
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
    WHERE [MigrationId] = N'20251001141637_V5__Baseline'
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
    WHERE [MigrationId] = N'20251001141637_V5__Baseline'
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
    WHERE [MigrationId] = N'20251001141637_V5__Baseline'
)
BEGIN
    CREATE TABLE [Course] (
        [Id] int NOT NULL IDENTITY,
        [InstructorId] int NOT NULL,
        [Title] nvarchar(max) NOT NULL,
        [Credits] int NOT NULL,
        CONSTRAINT [PK_Course] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Course_Instructor_InstructorId] FOREIGN KEY ([InstructorId]) REFERENCES [Instructor] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001141637_V5__Baseline'
)
IF COL_LENGTH('Enrollment','Grade') IS NOT NULL
AND COL_LENGTH('Enrollment','FinalGrade') IS NULL
    EXEC sp_rename N'[Enrollment].[Grade]', N'FinalGrade', N'COLUMN';

IF COL_LENGTH('Enrollment','Grade') IS NULL
AND COL_LENGTH('Enrollment','FinalGrade') IS NULL 
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
    WHERE [MigrationId] = N'20251001141637_V5__Baseline'
)
BEGIN
    CREATE INDEX [IX_Course_InstructorId] ON [Course] ([InstructorId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001141637_V5__Baseline'
)
BEGIN
    CREATE INDEX [IX_Enrollment_CourseId] ON [Enrollment] ([CourseId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001141637_V5__Baseline'
)
BEGIN
    CREATE INDEX [IX_Enrollment_StudentId] ON [Enrollment] ([StudentId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251001141637_V5__Baseline'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20251001141637_V5__Baseline', N'9.0.9');
END;

COMMIT;
GO

