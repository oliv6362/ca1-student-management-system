BEGIN TRANSACTION;
EXEC sp_rename N'[Enrollment].[Grade]', N'FinalGrade', 'COLUMN';

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250928145934_V5__RenameGrade', N'9.0.9');

COMMIT;
GO

