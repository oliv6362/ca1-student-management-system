BEGIN TRANSACTION;
ALTER TABLE [Enrollment] DROP CONSTRAINT [FK_Enrollment_Instructor_InstructorId];

DROP INDEX [IX_Enrollment_InstructorId] ON [Enrollment];

DECLARE @var sysname;
SELECT @var = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Enrollment]') AND [c].[name] = N'InstructorId');
IF @var IS NOT NULL EXEC(N'ALTER TABLE [Enrollment] DROP CONSTRAINT [' + @var + '];');
ALTER TABLE [Enrollment] DROP COLUMN [InstructorId];

CREATE TABLE [Department] (
    [Id] int NOT NULL IDENTITY,
    [DepartmentHeadId] int NULL,
    [Name] nvarchar(max) NOT NULL,
    [Budget] decimal(18,2) NOT NULL,
    [StartDate] datetime2 NOT NULL,
    CONSTRAINT [PK_Department] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Department_Instructor_DepartmentHeadId] FOREIGN KEY ([DepartmentHeadId]) REFERENCES [Instructor] ([Id])
);

CREATE UNIQUE INDEX [IX_Department_DepartmentHeadId] ON [Department] ([DepartmentHeadId]) WHERE [DepartmentHeadId] IS NOT NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250929184058_V6__AddDepartment', N'9.0.9');

COMMIT;
GO

