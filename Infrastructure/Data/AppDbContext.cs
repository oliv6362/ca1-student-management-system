
using StudentManagement.Domain.Model;
using Microsoft.EntityFrameworkCore;

namespace StudentManagement.Infrastructure.Data;
internal class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }
    public DbSet<Student> Students { get; set; }
    public DbSet<Course> Courses { get; set; }
    public DbSet<Enrollment> Enrollments { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {

    }
}