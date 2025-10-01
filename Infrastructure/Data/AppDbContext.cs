
using StudentManagement.Domain.Model;
using Microsoft.EntityFrameworkCore;

namespace StudentManagement.Infrastructure.Data;
internal class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }
    public DbSet<Student> Students { get; set; }
    public DbSet<Course> Courses { get; set; }
    public DbSet<Enrollment> Enrollments { get; set; }
    public DbSet<Instructor> Instructors { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        //STUDENT
        modelBuilder.Entity<Student>(e =>
        {
            e.ToTable("Student");
            e.HasKey(s => s.Id);

        });

        //COURSE
        modelBuilder.Entity<Course>(e =>
        {
            e.ToTable("Course");
            e.HasKey(c => c.Id);

            //FK - Instructor
            e.HasOne(c => c.Instructor)
                .WithMany(i => i.Courses)
                .HasForeignKey(c => c.InstructorId);
        });

        //ENROLLMENT
        modelBuilder.Entity<Enrollment>(e =>
        {
            e.ToTable("Enrollment");
            e.HasKey(en => en.Id);

            //FK - Student
            e.HasOne(en => en.Student)
                .WithMany(s => s.Enrollments)
                .HasForeignKey(en => en.StudentId);

            //FK - Course
            e.HasOne(en => en.Course)
                .WithMany(c => c.Enrollments)
                .HasForeignKey(en => en.CourseId);
        });

        //INSTRUCTOR
        modelBuilder.Entity<Instructor>(i =>
        {
            i.ToTable("Instructor");
            i.HasKey(i => i.Id);
        });
    }
}