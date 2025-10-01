# CA1 Student Management System

## V1 Initial Schema - Change-Based EF
### Steps
**1.** Defined `Student`, `Course`, and `Enrollment` entities.
**2.** Added `DbSet<TEntity>` properties in `AppDbContext` to expose the tables.  
**3.** Configured relationships, primary and foreign keys using `OnModelCreating`.  
**4.** Generated EF Migrations: `dotnet ef migrations add V1__InitialSchema`.  
**5.** Generated SQL Migration Artifact: `dotnet ef migrations script -o ./Changed-Based/Artifacts/V1__InitialSchema.sql`.

### Reasoning
To create the `Student`, `Course`, and `Enrollment` relations, I first defined them as entities with its properties.  
I then updated the `AppDbContext` by adding a `DbSet<TEntity>` for each entity and configured the relationships in `OnModelCreating`.  
After these changes, I generated the initial migration and migration artifact which establishes a baseline schema so EF can track changes going forward.   
This step is **non-destructive** because it only creates new tables and keys without removing or altering existing data.

------

## V2 Add MiddleName to Student - Change-Based EF
### Steps
**1.** `Added MiddleName` property to the `Student` entity.  
**2.** Generated EF Migrations: `dotnet ef migrations add V2__AddMiddleName`.  
**3.** Generated SQL Migration Artifacts: `dotnet ef migrations script V1__InitialSchema V2__AddMiddleName -o ./Changed-Based/Artifacts/V2__AddMiddleName.sql`.

### Reasoning
I first updated the `Student` entity by adding the `MiddleName` property.  
I then used the command `dotnet ef migrations script V1__InitialSchema V2__AddMiddleName` to generate the SQL Artifact.  
This command makes EF Core detects the change compared to the previous migration and generates a migration artifact script that only applies the necessary change.  
This step is **non-destructive** because adding a new column does not remove or modify any existing data.  

------

## V3 Add DateOfBirth to Student - Change-Based EF
### Steps
**1.** Added `DateOfBirth` proerty to the `Student` entity.  
**2.** Generated EF Migrations: `dotnet ef migrations add V3__DateOfBirth`.  
**3.** Generated SQL Migration Artifacts: `dotnet ef migrations script V2__AddMiddleName V3__DateOfBirth -o ./Changed-Based/Artifacts/V3__DateOfBirth.sql`.

### Reasoning
This migration follows the same incremental process as _"V2 Add MiddleName to Student"_.  
This step is also **non-destructive** because of the same reason as _"V2 Add MiddleName to Student"_.

------

## V4 Add Instrutor relation - Change-Based EF
### Steps
**1.** Defined `Instructor` & updated `Course` entity.  
**2.** `DbSet<TEntity>` property in `AppDbContext` to expose the table.  
**3.** Configured relationships, primary and foreign keys using `OnModelCreating`.  
**4.** Generated EF Migrations: `dotnet ef migrations add V4__AddInstrutor`.  
**5.** Generated SQL Migration Artifacts: `dotnet ef migrations script V3__DateOfBirth V4__AddInstrutor -o ./Changed-Based/Artifacts/V4__AddInstrutor.sql`.  

### Reasoning
To add the `Instructor` relation, I first defined the `Instructor` entity with its properties and updated the `Course` entity to include an `InstructorId` and a navigation property to `Instructor`.  
I then updated the `AppDbContext` by adding a `DbSet<Instructor>` and configured the relationships in `OnModelCreating`.  
After these changes, I generated the migration and used `dotnet ef migrations script V3__DateOfBirth V4__AddInstrutor` to produce a migration artifact that applies only the necessary changes.  
This step is **non-destructive** because it only creates a new table `Instructor` and adds a foreign key column `InstructorId` to the existing `Course` table.

------

## V5 Rename Grade to FinalGrade in Enrollment - Change-Based EF
### Steps
**1.** Renamed `Grade` property to `FinalGrade` in `Enrollment` Entity.  
**2.** Generated EF Migrations: `dotnet ef migrations add V5__RenameGrade`.  
**3.** Generated SQL Migration Artifacts: `dotnet ef migrations script V4__AddInstrutor V5__RenameGrade -o ./Changed-Based/Artifacts/V5__RenameGrade.sql`.  

### Reasoning
I first updated the `Enrollment` entity by renaming the `Grade` property to `FinalGrade`.  
I then used the command `dotnet ef migrations script V4__AddInstrutor V5__RenameGrade` to generate the Migration Artifact reflecting this change.  
EF Core generates a `RenameColumn` operation, which in SQL Server is translated to an in-place rename using `sp_rename`.  
Because this operation only changes the column’s name and preserves all existing data, the migration is **non-destructive**.  
Normally renaming a column's name could be **destructive**, such as if EF Core had handled the property rename as a drop-and-recreate operation instead.  

------

## V6 Add Department relation - Change-Based EF
### Steps
**1.** Defined `Department` & updated `Intructor` entity.  
**2.** Added `DbSet<TEntity>` property in `AppDbContext` to expose the table.  
**3.** Configured relationships, primary and foreign keys using `OnModelCreating`.  
**4.** Generated EF Migrations: `dotnet ef migrations add V6__AddDepartment`.  
**3.** Generated SQL Migration Artifacts: `dotnet ef migrations script V5__RenameGrade V6__AddDepartment -o ./Changed-Based/Artifacts/V6__AddDepartment.sql`.  

### Reasoning
To add the `Department` relation, I first defined the `Department` entity with its properties and updated the `Intructor` entity to include an `DepartmentHeadOf` property.  
I then updated the `AppDbContext` by adding a `DbSet<Department>` and configured the relationships in `OnModelCreating`.  
After these changes, I generated the migration and used `dotnet ef migrations script V5__RenameGrade V6__AddDepartment` to produce a migration artifact reflecting this change.  
Adding the `Department` relation was a **non-destructive** step because it only creates a new table `Department` and adds a foregin key column `DepartmentHeadId` to the `Department` table.  
However, in this migration I also removed the accidentally created `InstructorId` column from the `Enrollment` table. This was a **destructive** operation, because dropping a column permanently deletes any data it contained.  

------

## V7 Modify the Course Credits relation - Change-Based EF
### Steps
**1.** Updated `Credits` property in `Course` entity.  
**2.** Generated EF Migrations: `dotnet ef migrations add V7__ModifyCourse`.  
**3.** Generated SQL Migration Artifacts: `dotnet ef migrations script V6__AddDepartment V7__ModifyCourse -o ./Changed-Based/Artifacts/V7__ModifyCourse.sql`.  

### Reasoning
To modify the `Course` relation, I updated the `Course` entity by changing the `Credits` property from data-type `int` to `decimal(5, 2)`.  
This is a **non-destructive** operation because it is a widening conversion, which means all existing `integer` values are safely represented as `decimals`.  
Conversely, changing from `decimal(5,2)` back to `int` could be **destructive**.  
