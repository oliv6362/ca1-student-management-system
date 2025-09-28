BEGIN TRANSACTION;
ALTER TABLE [Student] ADD [MiddleName] nvarchar(max) NOT NULL DEFAULT N'';

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250928134101_V2__AddMiddleName', N'9.0.9');

COMMIT;
GO

