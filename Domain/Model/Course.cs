using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentManagement.Domain.Model;
internal class Course
{
    public int Id { get; set; }
    public int InstructorId { get; set; }
    public string Title { get; set; }
    [Precision(5, 2)]
    public decimal Credits { get; set; }
    public Instructor? Instructor {get; set; } 
    public ICollection<Enrollment> Enrollments { get; set; } = new List<Enrollment>();
}
