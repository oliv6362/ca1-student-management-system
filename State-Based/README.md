# StudentManagement

## V1 Initial Schema - State-Based
### Steps
**1.** Defined `Student`, `Course`,and `Enrollment` entities.
- Added `DbSet<TEntity>` properties in `AppDbContext` to expose the tables.
- Configured relationships, primary and foreign keys using `OnModelCreating`.  
**2.** Generated EF Migration: `dotnet ef migrations add V1__InitialSchema`.  
**3.** Generated SQL Deployment Artifact: `dotnet ef migrations script -o ./State-Based/Artifacts/V1__InitialSchema.sql --idempotent`.  
**4.** Generated Desired State Script: `dotnet ef dbcontext script -o ./State-Based/State/V1/schema.sql`.

### Reasoning
To create the `Student`, `Course`,and `Enrollment` relations, I first defined them as entities with its properties.  
I then updated the `AppDbContext` by adding a `DbSet<TEntity>` for each entity and configured the relationships in `OnModelCreating`.  
After these changes, I generated a idempotent deployment artifact script and desired state script.  
This step is **non-destructive** because it only creates new tables and keys without removing or altering existing data.

------

## V2 Add MiddleName to Student - State-Based
### Steps
**1.** `Added MiddleName` property to the `Student` entity, and removed the last migration.  
**2.** Generated EF Migration: `dotnet ef migrations add V2__Baseline`.  
**3.** Generated SQL Deployment Artifact: `dotnet ef migrations script -o ./State-Based/Artifacts/V2__AddMiddleName.sql --idempotent`.  
**4.** Generated Desired State Script: `dotnet ef dbcontext script -o ./State-Based/State/V2/schema.sql`.

### Reasoning
I first updated the `Student` entity by adding the `MiddleName` property.  
I then removed the last migration by using the command `dotnet ef migrations remove`.  
After that I generated a idempotent deployment artifact script and desired state script.  
This step is **non-destructive** because adding a new column does not remove or modify any existing data.  
Using a idempotent deployment script also makes it safe to **re-run**.


------

## V3 Add DateOfBirth to Student - State-Based
### Steps
**1.** `Added DateOfBirth` property to the `Student` entity, and removed the last migration.  
**2.** Generated EF Migration: `dotnet ef migrations add V3__Baseline`.  
**3.** Generated SQL Deployment Artifact: `dotnet ef migrations script -o ./State-Based/Artifacts/V3__AddDateOfBirth.sql --idempotent`.  
**4.** Generated Desired State Script: `dotnet ef dbcontext script -o ./State-Based/State/V3/schema.sql`.

### Reasoning
I first updated the `Student` entity by adding the `DateOfBirth` property.  
I then removed the last migration by using the command `dotnet ef migrations remove`.  
After that I generated a idempotent deployment artifact script and desired state script.  
This step is also **non-destructive** because of the same reason as _"V2 Add MiddleName to Student"_.

------

## V4 Add Instrutor relation - State-Based
### Steps
**1.** Defined `Instructor` & updated `Course` entity, and removed the last migration.
- Added `DbSet<TEntity>` property in `AppDbContext` to expose the table.  
- Configured relationships, primary and foreign keys using `OnModelCreating`.
**2.** Generated EF Migration: `dotnet ef migrations add V4__Baseline`.  
**3.** Generated SQL Deployment Artifact: `dotnet ef migrations script -o ./State-Based/Artifacts/V4__AddInstructor.sql --idempotent`.  
**4.** Generated Desired State Script: `dotnet ef dbcontext script -o ./State-Based/State/V4/schema.sql`.

### Reasoning
To add the `Instructor` relation, I first defined the `Instructor` entity with its properties and updated the `Course` entity to include an `InstructorId` and a navigation property to `Instructor`.  
I then removed the last migration by using the command `dotnet ef migrations remove`.  
I then updated the `AppDbContext` by adding a `DbSet<Instructor>` and configured the relationships in `OnModelCreating`.  
After that I generated a idempotent deployment artifact script and desired state script.  
This step is **non-destructive** because it only creates a new table `Instructor` and adds a foreign key column `InstructorId` to the existing `Course` table.

------

## V5 Rename Grade to FinalGrade in Enrollment - State-Based
### Steps
**1.** Renamed `Grade` property to `FinalGrade` in `Enrollment` Entity, and removed the last migration.
**2.** Generated EF Migration: `dotnet ef migrations add V5__Baseline`.  
**3.** Generated SQL Deployment Artifact: `dotnet ef migrations script -o ./State-Based/Artifacts/V5__RenameGrade.sql --idempotent`.  
**4.** Generated Desired State Script: `dotnet ef dbcontext script -o ./State-Based/State/V5/schema.sql`.

### Reasoning
I first updated the `Enrollment` entity by renaming the `Grade` property to `FinalGrade`.  
I then removed the last migration by using the command `dotnet ef migrations remove`.  
After that I generated a idempotent deployment artifact script and desired state script´.  
I then updated the deployment script by adding a check for whether a `Enrollment` relation has a `Grade` column or not.  
This step is **non-destructive** because the deployment script uses the `sp_rename` operation in order to rename `Grade` to `FinalGrade`.
If the `Enrollment` relation already has a `Grade` column then the `sp_rename` operation won't execute, and it will instead just create the table with `FinalGrade` column.

------

## V6 Add Department relation - Change-Based EF
### Steps
**1.** Defined `Department` & updated `Intructor` entity, and removed the last migration.
- Added `DbSet<TEntity>` property in `AppDbContext` to expose the table.  
- Configured relationships, primary and foreign keys using `OnModelCreating`.
**2.** Generated EF Migration: `dotnet ef migrations add V6__Baseline`.  
**3.** Generated SQL Deployment Artifact: `dotnet ef migrations script -o ./State-Based/Artifacts/V6__AddDepartment.sql --idempotent`.  
**4.** Generated Desired State Script: `dotnet ef dbcontext script -o ./State-Based/State/V6/schema.sql`.

### Reasoning
To add the `Department` relation, I first defined the `Department` entity with its properties and updated the `Intructor` entity to include an `DepartmentHeadOf` property.  
I then updated the `AppDbContext` by adding a `DbSet<Department>` and configured the relationships in `OnModelCreating`.  
I then removed the last migration by using the command `dotnet ef migrations remove`.  
After that I generated a idempotent deployment artifact script and desired state script´.  
Adding the `Department` relation was a **non-destructive** step because it only creates a new table `Department` and adds a foregin key column `DepartmentHeadId` to the `Department` table.

------

## V7 Modify the Course Credits relation - Change-Based EF
### Steps
**1.** Updated `Credits` property in `Course` entity, and removed the last migration.
**2.** Generated EF Migration: `dotnet ef migrations add V7__Baseline`.  
**3.** Generated SQL Deployment Artifact: `dotnet ef migrations script -o ./State-Based/Artifacts/V7__ModifyGrade.sql --idempotent`.  
**4.** Generated Desired State Script: `dotnet ef dbcontext script -o ./State-Based/State/V7/schema.sql`.

### Reasoning
To modify the `Course` relation, I updated the `Course` entity by changing the `Credits` property from data-type `int` to `decimal(5, 2)`.
I then removed the last migration by using the command `dotnet ef migrations remove`.  
After that I generated a idempotent deployment artifact script and desired state script´.  
I then updated the deployment script by adding a check for whether a `Course` relation has a `Credits` column or not.  
This is a **non-destructive** operation because it is a widening conversion, which means all existing `integer` values are safely represented as `decimals`.  
If `Course` relation already have a `Credits` column, then the script will execute `ALTER TABLE` to modify it into a `decimal(5, 2)`.
