BEGIN TRANSACTION;
ALTER TABLE [Enrollment] ADD [InstructorId] int NULL;

ALTER TABLE [Course] ADD [InstructorId] int NOT NULL DEFAULT 0;

CREATE TABLE [Instructor] (
    [Id] int NOT NULL IDENTITY,
    [FirstName] nvarchar(max) NOT NULL,
    [LastName] nvarchar(max) NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    [HireDate] datetime2 NOT NULL,
    CONSTRAINT [PK_Instructor] PRIMARY KEY ([Id])
);

CREATE INDEX [IX_Enrollment_InstructorId] ON [Enrollment] ([InstructorId]);

CREATE INDEX [IX_Course_InstructorId] ON [Course] ([InstructorId]);

ALTER TABLE [Course] ADD CONSTRAINT [FK_Course_Instructor_InstructorId] FOREIGN KEY ([InstructorId]) REFERENCES [Instructor] ([Id]) ON DELETE CASCADE;

ALTER TABLE [Enrollment] ADD CONSTRAINT [FK_Enrollment_Instructor_InstructorId] FOREIGN KEY ([InstructorId]) REFERENCES [Instructor] ([Id]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250928145116_V4__AddInstructor', N'9.0.9');

COMMIT;
GO

